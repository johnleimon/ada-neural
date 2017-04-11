-----------------------------------------------------------------
--                                                             --
-- Input Output Specification                                  --
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
with Ada.Text_IO; use Ada.Text_IO;
with NN.Math;     use NN.Math;
with NN.Neuron;   use NN.Neuron;

package NN.IO is

   use NN.Math.Super_Matrixes;

   package Float_Text_IO is new Float_IO (Long_Long_Float);

   DEFAULT : constant String := Character'Val (16#1B#) & "[39m";
   GREEN   : constant String := Character'Val (16#1B#) & "[92m";
   RED     : constant String := Character'Val (16#1B#) & "[31m";

   procedure Put (Input : Float_Array);
   procedure Put (Layer : Neural_Layer);
   procedure Put (Matrix : Real_Matrix);
   procedure Put (Matrix_Array : Real_Matrix_Access_Array);
   procedure Put_Float (Input : Long_Long_Float);

end NN.IO;
