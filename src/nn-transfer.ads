-----------------------------------------------------------------
--                                                             --
-- Neural Network Transfer Functions Specification             --
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
with NN.Math;

package NN.Transfer is

   use NN.Math.Super_Matrixes;

   function Hard_Limit (input : Long_Long_Float) return Long_Long_Float;
   function hardlim (input : Long_Long_Float) return Long_Long_Float renames Hard_Limit;
   
   function Symmetrical_Hard_Limit (input : Long_Long_Float) return Long_Long_Float;
   function hardlims (input : Long_Long_Float) return Long_Long_Float renames Symmetrical_Hard_Limit;
   
   function Linear (input : Long_Long_Float) return Long_Long_Float;
   function purelin (input : Long_Long_Float) return Long_Long_Float renames Linear;
   
   function Positive_Linear (input : Long_Long_Float) return Long_Long_Float;
   function poslin (input : Long_Long_Float) return Long_Long_Float renames Positive_Linear;

   function Saturating_Linear (input : Long_Long_Float) return Long_Long_Float;
   function satlin (input : Long_Long_Float) return Long_Long_Float renames Saturating_Linear;

   function Log_Sigmoid (input : Long_Long_Float) return Long_Long_Float;
   function logsig (input : Long_Long_Float) return Long_Long_Float renames Log_Sigmoid;

   function Hyperbolic_Tangent_Sigmoid (input : Long_Long_Float) return Long_Long_Float;
   function tansig (input : Long_Long_Float) return Long_Long_Float renames Hyperbolic_Tangent_Sigmoid;

end NN.Transfer;
