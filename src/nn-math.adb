-----------------------------------------------------------------
--                                                             --
-- Mathematics                                                 --
--                                                             --
-- Copyright (c) 2016, John Leimon                             --
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
with Ada.Numerics.Real_Arrays;          use Ada.Numerics.Real_Arrays;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body NN.Math is

   -------------------
   -- PseudoInverse --
   -------------------

   function PseudoInverse (Input : Real_Matrix) return Real_Matrix
   is
      Input_Transpose : Real_Matrix := Transpose(Input);
   begin
      return Inverse(Input_Transpose * Input) * Input_Transpose;
   end PseudoInverse; 

   ------------------------
   -- Create_Real_Matrix --
   ------------------------
   
   function Create_Real_Matrix (Rows    : Natural;
                                Columns : Natural) return Real_Matrix
   is
      Output : Real_Matrix(Integer'First .. Integer'First + Rows - 1,
                           Integer'First .. Integer'First + Columns - 1);
      Pragma Warnings(Off, Output);
   begin
      return Output;
   end Create_Real_Matrix;

   -----------------------
   -- Widrow_Hoff_Delta --
   -----------------------

   function Widrow_Hoff_Delta (Input_Weights  : Real_Matrix;
                               Learning_Rate  : Float;
                               Input          : Real_Matrix;
                               Desired_Output : Real_Matrix;
                               Actual_Output  : Real_Matrix) return Real_Matrix
   is
   begin
      return Input_Weights + Learning_Rate * (Desired_Output - Actual_Output) * Transpose(Input);
   end Widrow_Hoff_Delta;

   -----------------------
   -- Unsupervised_Hebb --
   -----------------------

   function Unsupervised_Hebb (Input_Weights  : Real_Matrix;
                               Learning_Rate  : Float;
                               Input          : Real_Matrix;
                               Actual_Output  : Real_Matrix) return Real_Matrix
   is
   begin
      return Input_Weights + Learning_Rate * Actual_Output * Transpose(Input);
   end Unsupervised_Hebb;

   --------------------
   -- Eucledian_Norm --
   --------------------

   function Eucledian_Norm (Input : Real_Matrix) return Float
   is
      Sum : Float := 0.0;
   begin
      for I in Input'Range(1) loop
         for J in Input'Range(2) loop
            Sum := Sum + Input(I, J)**2;
         end loop;
      end loop;
      return Sqrt(Sum);
   end Eucledian_Norm;

end NN.Math;
