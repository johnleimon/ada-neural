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

with NN.Transfer;                       use NN.Transfer;
with NN.Neuron;                         use NN.Neuron;
with Ada.Containers.Indefinite_Vectors; use Ada.Containers;
with Ada.Text_IO;                       use Ada.Text_IO;

procedure Main is

   -------------------------------
   -- Demo_Single_Neuron_Firing --
   -------------------------------

   procedure Demo_Single_Neuron_Firing is
      Neuron : Neuron_Type;
      Result : Float;
   begin
      Put("Single Neuron -- Weights: [1.0, 0.5] Inputs: [0.1, 0.2] ");
      Neuron.Transfer := satlin'access;

      -- Configure neuron for two inputs --
      Neuron.Input_Weights.Append(1.0);
      Neuron.Input_Weights.Append(0.5);
      Neuron.Bias := 0.0;

      Result := Fire(Neuron, (0.1, 0.2));

      Put_Line("Result : " & Float'image(Result));
   end Demo_Single_Neuron_Firing;

   -------------------------------------
   -- Demo_Multi_Layer_Network_Firing --
   -------------------------------------

   procedure Demo_Multi_Layer_Network_Firing is
      Network : Multi_Layer_Neural_Network.Vector;
   begin

      Put("Multi-layer -- ");

      -- Create a two layer neural network with two --
      -- neurons per layer.                         --
      Network.Append(Create_Layer(Number_Of_Inputs  => 2,
                                  Number_Of_Neurons => 2,
                                  Transfer          => satlin'access,
                                  Input_Weight      => 1.0,
                                  Bias              => 0.0));
      Network.Append(Create_Layer(Number_Of_Inputs  => 2,
                                  Number_Of_Neurons => 2,
                                  Transfer          => satlin'access,
                                  Input_Weight      => 1.0,
                                  Bias              => 0.0));

      declare
         Result : Float_Array := Fire(Network, (0.1, 0.2));
      begin
         Put_Line("Result : " &
                  Float'image(Result(1)) & ", " &
                  Float'image(Result(2)));
      end;

   end Demo_Multi_Layer_Network_Firing;

begin

   Demo_Single_Neuron_Firing;
   Demo_Multi_Layer_Network_Firing;

end Main;
