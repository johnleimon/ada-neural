-----------------------------------------------------------------
--                                                             --
-- Nerual Network Transfer Functions Specification             --
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

package NN.Transfer is

   function Hard_Limit (input : Float) return Float;
   function hardlim (input : Float) return Float renames Hard_Limit;
   
   function Symmetrical_Hard_Limit (input : Float) return Float;
   function hardlims (input : Float) return Float renames Symmetrical_Hard_Limit;
   
   function Linear (input : Float) return Float;
   function purelin (input : Float) return Float renames Linear;
   
   function Positive_Linear (input : Float) return Float;
   function poslin (input : Float) return Float renames Positive_Linear;

   function Saturating_Linear (input : Float) return Float;
   function satlin (input : Float) return Float renames Saturating_Linear;

   function Log_Sigmoid (input : float) return Float;
   function logsig (input : float) return Float renames Log_Sigmoid;

   function Hyperbolic_Tangent_Sigmoid (input : Float) return Float;
   function tansig (input : Float) return Float renames Hyperbolic_Tangent_Sigmoid;

end NN.Transfer;
