-----------------------------------------------------------------
--                                                             --
-- Mathematics                                                 --
--                                                             --
-- Copyright (c) 2016, 2017 John Leimon, Adam Schwem           --
--                                                             --
-- Permission to use, copy, modify, and/or distribute          --
-- this software for any purpose with or without fee           --
-- is hereby granted, provided that the above copyright        --
-- notice and this permission notice appear in all copies.     --
--                                                             --
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR             --
-- DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE       --
-- INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY         --
-- AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE         --
-- FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL         --
-- DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS       --
-- OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF            --
-- CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING      --
-- OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF      --
-- THIS SOFTWARE.                                              --
-----------------------------------------------------------------
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Float_Random;
   use Ada.Numerics.Float_Random;
with NN.IO;
   use NN.IO;
with Ada.Text_IO;
   use Ada.Text_IO;

package body NN.Math is

   Float_Generator : Generator;

   package Math_Functions is new
           Ada.Numerics.Generic_Elementary_Functions (Long_Long_Float);
   use Math_Functions;

   -------------------
   -- PseudoInverse --
   -------------------

   function PseudoInverse (Input : Real_Matrix) return Real_Matrix
   is
      Input_Transpose : Real_Matrix := Transpose (Input);
   begin
      return Inverse (Input_Transpose * Input) * Input_Transpose;
   end PseudoInverse;

   ------------------------
   -- Create_Real_Matrix --
   ------------------------

   function Create_Real_Matrix (Rows    : Natural;
                                Columns : Natural) return Real_Matrix
   is
      Output : Real_Matrix (Integer'First ..
                            Integer'First + Rows - 1,
                            Integer'First ..
                            Integer'First + Columns - 1);
      pragma Warnings (Off, Output);
   begin
      return Output;
   end Create_Real_Matrix;

   ------------------------
   -- Create_Real_Matrix --
   ------------------------

   function Create_Real_Matrix (Rows    : Natural;
                                Columns : Natural) return Real_Matrix_Access
   is
      Output : Real_Matrix_Access :=
               new Real_Matrix (Integer'First ..
                                Integer'First + Rows - 1,
                                Integer'First ..
                                Integer'First + Columns - 1);
      pragma Warnings (Off, Output);
   begin
      return Output;
   end Create_Real_Matrix;

   ------------
   -- Delete --
   ------------

   procedure Delete (Matrix : in out Real_Matrix_Access_Array)
   is
   begin
      for I in Matrix'Range loop
         Free (Matrix (I));
      end loop;
   end Delete;

   -----------------------
   -- Unsupervised_Hebb --
   -----------------------

   function Unsupervised_Hebb (Input_Weights  : Real_Matrix;
                               Learning_Rate  : Long_Long_Float;
                               Input          : Real_Matrix;
                               Actual_Output  : Real_Matrix) return Real_Matrix
   is
   begin
      return Input_Weights +
             Learning_Rate * Actual_Output * Transpose (Input);
   end Unsupervised_Hebb;

   -----------
   -- Delta --
   -----------

   function Δ (Left  : Long_Long_Float;
               Right : Long_Long_Float) return Long_Long_Float
   is
   begin
      return abs (Left - Right);
   end Δ;

   --------------------
   -- Eucledian_Norm --
   --------------------

   function Eucledian_Norm (Input : Real_Matrix) return Long_Long_Float
   is
      Sum : Long_Long_Float := 0.0;
   begin
      for I in Input'Range (1) loop
         for J in Input'Range (2) loop
            Sum := Sum + Input (I, J)**2;
         end loop;
      end loop;
      return Sqrt (Sum);
   end Eucledian_Norm;

   -----------------------
   -- Positive_Definite --
   -----------------------

   function Positive_Definite (Input : Real_Matrix) return Boolean
   is
      Input_Eigenvalues : Real_Vector := Eigenvalues (Input);
   begin
      for I in Input_Eigenvalues'Range loop
         if Input_Eigenvalues (I) <= 0.0 then
            return False;
         end if;
      end loop;

      return True;
   end Positive_Definite;

   ---------------
   -- Symmetric --
   ---------------

   function Symmetric (Input : Real_Matrix) return Boolean
   is
   begin
      if Input = Transpose (Input) then
         return True;
      else
         return False;
      end if;
   end Symmetric;

   --------------
   -- Gradient --
   --------------

   function Gradient (Input : Real_Matrix;
                      Point : Real_Matrix) return Real_Matrix
   is
      Output : Real_Matrix (Point'Range (1), Point'Range (2));
   begin
      Output := (Output'Range (1) => (Output'Range (2) => 0.0));

      for I in Input'Range (1) loop
         for J in Input'Range (2) loop
            Output (I, Integer'First) := Output (I, Integer'First) +
                                         Input (I, J) *
                                         Point (J, Integer'First);
         end loop;
      end loop;

      return Output;
   end Gradient;

   ------------------------
   -- Conjugate_Gradient --
   ------------------------

   function Conjugate_Gradient
     (Input              : Real_Matrix;
      Initial_Guess      : Real_Matrix;
      Convergence_Window : Long_Long_Float := 0.00000001)
      return Real_Matrix
   is
      x      : Real_Matrix :=  Initial_Guess;
      Output : Real_Matrix
                 (Initial_Guess'Range (1),
                  Initial_Guess'Range (2))
                  := (others => (others => 0.0));
      g1     : Real_Matrix
                 (Initial_Guess'Range (1),
                  Initial_Guess'Range (2))
                  := (others => (others => 0.0));
      p1     : Real_Matrix
                  (Initial_Guess'Range (1),
                   Initial_Guess'Range (2))
                  := (others => (others => 0.0));
      Last   : Real_Matrix
                  (Initial_Guess'Range (1),
                   Initial_Guess'Range (2))
                  := (others => (others => 0.0));
   begin

      if not Symmetric (Input) then
         raise Matrix_Not_Symmetric;
      end if;

      if not Positive_Definite (Input) then
         raise Matrix_Not_Positive_Definite;
      end if;

<< Perform_Iteration >>

         -- Calculate the learning rate of the first iteration --
         declare
            g0 : Real_Matrix :=  Gradient (Input, Initial_Guess);
            p0 : Real_Matrix := -Gradient (Input, Initial_Guess);
            α  : Real_Matrix := (Transpose (-p0) * p0) /
                                (Transpose (p0) * Input * p0);
            -- [9.68] --
         begin
            -- Compute first step of conjugate gradient --
            -- [9.69] --
            x := x + abs (α (α'First (1), α'First (2))) * p0;

            -- Compute gradient at x1 --
            -- [9.70] --
            g1 := Gradient (Input, x);

            declare
               β : Real_Matrix := (Transpose (g1) * g1) /
                                  (Transpose (g0) * g0);
               -- [9.71] --
            begin
               -- Compute second search direction --
               -- [9.72] --
               p1 := -g1 + β (β'First (1), β'First (2)) * p0;

               -- Compute learning rate of next iteration --
               -- [9.73] --
               α := (Transpose (-g1) * p1) /
                    (Transpose (p1) * Input * p1);

               -- Compute next step of conjugate gradient --
               -- [9.74] --
               x := x + α (α'First (1), α'First (2)) * p1;
            end;
         end;

      -- Determine if our solution is inside the convergence window --
      for I in Last'Range (1) loop
         for J in Last'Range (2) loop
            if abs (Last (I, J) - x (I, J)) > Convergence_Window then
               -- Not inside the window --
               Last := x;
               goto Perform_Iteration;
            end if;
         end loop;
      end loop;

      return x;

   end Conjugate_Gradient;

   ------------------------------------
   -- Real_Matrix Division Operation --
   ------------------------------------

   function "/" (Left  : Real_Matrix;
                 Right : Real_Matrix) return Real_Matrix
   is
   begin
      return Left * Inverse (Right);
   end "/";

   -------------------------
   -- Random_Input_Weight --
   -------------------------

   function Random_Input_Weight
      return Long_Long_Float
   is
   begin
      return Long_Long_Float (Random (Float_Generator)) * 2.0 - 1.0;
   end Random_Input_Weight;

   -----------------
   -- Random_Bias --
   -----------------

   function Random_Bias
      return Long_Long_Float
   is
   begin
      return Long_Long_Float (Random (Float_Generator)) * 2.0 - 1.0;
   end Random_Bias;

   -------------------
   -- Squared_Error --
   -------------------

   function Squared_Error
     (Expected : Long_Long_Float;
      Actual   : Long_Long_Float)
      return Long_Long_Float
   is
   begin
      return 0.5 * (Expected - Actual)**2;
   end Squared_Error;

   -----------------------
   -- Widrow_Hoff_Delta --
   -----------------------

   function Widrow_Hoff_Delta
      (Input_Weights  : Real_Matrix;
       Learning_Rate  : Long_Long_Float;
       Input          : Real_Matrix;
       Desired_Output : Real_Matrix;
       Actual_Output  : Real_Matrix) return Real_Matrix
   is
   begin
      return Input_Weights +
             Learning_Rate * (Desired_Output - Actual_Output) *
             Transpose (Input);
   end Widrow_Hoff_Delta;

begin
   Reset (Float_Generator);
end NN.Math;
