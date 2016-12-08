-----------------------------------------------------------------
--                                                             --
-- Mathematics Specification                                   --
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
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

package NN.Math is

   function PseudoInverse (Input : Real_Matrix) return Real_Matrix;
   function Create_Real_Matrix (Rows : Natural; 
                             Columns : Natural ) return Real_Matrix;

   function Widrow_Hoff_Delta (Input_Weights  : Real_Matrix;
                               Learning_Rate  : Float;
                               Input          : Real_Matrix;
                               Desired_Output : Real_Matrix;
                               Actual_Output  : Real_Matrix) return Real_Matrix
                               with Pre =>
                                    Input_Weights'Length(1) = Input'Length(1) and
                                    Learning_Rate < 0.0 and
                                    Input_Weights'Length(2) = Input'Length(1);

   function Unsupervised_Hebb (Input_Weights  : Real_Matrix;
                               Learning_Rate  : Float;
                               Input          : Real_Matrix;
                               Actual_Output  : Real_Matrix) return Real_Matrix
                               with Pre =>
                                    Input_Weights'Length(1) = Input'Length(1) and
                                    Learning_Rate < 0.0 and
                                    Input_Weights'Length(2) = Input'Length(1);


end NN.Math;
