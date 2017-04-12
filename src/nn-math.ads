-----------------------------------------------------------------
--                                                             --
-- Mathematics Specification                                   --
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
with Ada.Numerics.Generic_Real_Arrays;
with Ada.Unchecked_Deallocation;

package NN.Math is

   package Super_Matrixes is new
           Ada.Numerics.Generic_Real_Arrays (Long_Long_Float);
   use Super_Matrixes;

   type Float_Array is array (Integer range <>) of Long_Long_Float;
   type Float_Array_Access is access all Float_Array;
   type Real_Matrix_Access is access all Real_Matrix;

   type Real_Matrix_Access_Array is array (Natural range <>)
        of Real_Matrix_Access;

   procedure Free is new Ada.Unchecked_Deallocation
                         (Float_Array, Float_Array_Access);
   procedure Free is new Ada.Unchecked_Deallocation
                         (Real_Matrix, Real_Matrix_Access);

   Matrix_Not_Positive_Definite : exception;
   Matrix_Not_Symmetric         : exception;

   function Create_Real_Matrix
      (Rows    : Natural;
       Columns : Natural)
       return Real_Matrix_Access;
   function Create_Real_Matrix
      (Rows    : Natural;
       Columns : Natural)
       return Real_Matrix;

   procedure Delete (Matrix : in out Real_Matrix_Access_Array);

   function PseudoInverse
      (Input : Real_Matrix)
       return Real_Matrix;

   function Unsupervised_Hebb
      (Input_Weights  : Real_Matrix;
       Learning_Rate  : Long_Long_Float;
       Input          : Real_Matrix;
       Actual_Output  : Real_Matrix) return Real_Matrix
       with Pre =>
            Input_Weights'Length (1) = Input'Length (1) and
            Learning_Rate < 0.0 and
            Input_Weights'Length (2) = Input'Length (1);

   function Δ
      (Left  : Long_Long_Float;
       Right : Long_Long_Float)
       return Long_Long_Float;

   function Eucledian_Norm
      (Input : Real_Matrix)
       return Long_Long_Float;

   function Positive_Definite
      (Input : Real_Matrix)
       return Boolean;

   function Symmetric
      (Input : Real_Matrix)
       return Boolean;

   function Gradient
      (Input : Real_Matrix;
       Point : Real_Matrix) return Real_Matrix
       with Pre =>
            Input'Length (1) = Input'Length (2) and
            Input'Length (1) = Point'Length (1);

   function Conjugate_Gradient
      (Input              : Real_Matrix;
       Initial_Guess      : Real_Matrix;
       Convergence_Window : Long_Long_Float := 0.00000001)
       return Real_Matrix;

   function "/" (Left  : Real_Matrix;
                 Right : Real_Matrix) return Real_Matrix;

   function Random_Input_Weight return Long_Long_Float;
   -- Return number between -1.0 and 1.0 --
   function Random_Bias return Long_Long_Float;
   -- Return number between -1.0 and 1.0 --

   function Squared_Error
     (Expected : Long_Long_Float;
      Actual   : Long_Long_Float)
      return Long_Long_Float;

   function Widrow_Hoff_Delta
      (Input_Weights  : Real_Matrix;
       Learning_Rate  : Long_Long_Float;
       Input          : Real_Matrix;
       Desired_Output : Real_Matrix;
       Actual_Output  : Real_Matrix) return Real_Matrix
       with Pre =>
            Input_Weights'Length (1) = Input'Length (1) and
            Learning_Rate < 0.0 and
            Input_Weights'Length (2) = Input'Length (1);

end NN.Math;
