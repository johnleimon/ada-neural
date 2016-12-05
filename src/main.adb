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

   procedure Demo_Fire_Neural_Layer
   is

      Bias     : aliased Float_Array :=  (1.0, 1.0, 1.0);
      -- Two Neurons, Three Weights --
      Weights  : aliased Real_Matrix := ((0.5, 0.5, 0.5),
                                         (0.7, 0.1, 0.9));
      Input    : Float_Array         :=  (0.1, 0.2, 0.3);
      Output   : Float_Array(0 .. 1);
      Transfer : aliased Transfer_Function_Array := (satlin'access,
                                                     satlin'access,
                                                     satlin'access);
      Layer    : Neural_Layer;
   begin

      -- Setup neuron layer --
      Layer.Bias               := Bias'Unchecked_access;
      Layer.Weights            := Weights'Unchecked_access;
      Layer.Transfer_Functions := Transfer'Unchecked_access;

      -- Fire neuron layer --
      Fire(Layer, Input, Output);

      Put_Line("Demo: Fire Neural Network Layer");

      Put("   INPUTS: ");
      for Index in Input'Range loop
         Put(Float'image(Input(Index)) & " ");
      end loop;
      New_Line;

      Put("   OUTPUTS: ");
      for Index in Output'Range loop
         Put(Float'Image(Output(Index)) & " ");
      end loop;
      New_Line;

   end Demo_Fire_Neural_Layer;

begin
   
   Demo_Fire_Neural_Layer;

end Main;
