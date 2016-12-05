-----------------------------------------------------------------
--                                                             --
-- Neuron                                                      --
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
with Ada.Text_IO;              use Ada.Text_IO;
with NN.Transfer;              use NN.Transfer;
with NN.Neuron;                use NN.Neuron;

procedure Main is

   Bias    : aliased Float_Array := (0.0, 0.0, 0.0);
   Weights : aliased Real_Matrix := ((0.0, 0.0, 0.0),
                                     (0.0, 0.0, 0.0));

   Input  : Float_Array := (0.0, 0.0, 0.0);
   Output : Float_Array := (0.0, 0.0, 0.0);

   T : aliased Transfer_Function_Array := (satlin'access, satlin'access);

begin
   
   declare
      Layer : Neural_Layer;
   begin
      Layer.Bias               := Bias'Unchecked_Access;
      Layer.Weights            := Weights'Unchecked_Access;
      Layer.Transfer_Functions := T'Unchecked_Access;
   
      Fire(Layer, Input, Output);
   end;

end Main;
