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
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

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

end NN.Math;
