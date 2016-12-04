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

package body NN.Neuron is

   ------------------
   -- Create_Layer --
   ------------------

   function Create_Layer (Number_Of_Inputs  : Natural;
                          Number_Of_Neurons : Natural;
                          Transfer          : Transfer_Function;
                          Input_Weight      : Float := 1.0;
                          Bias              : Float := 0.0) return Neuron_Layers.Vector
   is
      Input_Weights : Float_Vectors.Vector;
      Neuron        : Neuron_Type;
      Output        : Neuron_Layers.Vector;
   begin

      -- Create a input weight vector --
      for I in Natural range 1 .. Number_Of_Inputs loop
         Input_Weights.Append(Input_Weight);
      end loop;

      -- Create Neuron --
      Neuron.Bias          := Bias;
      Neuron.Input_Weights := Input_Weights;
      Neuron.Transfer      := Transfer;

      -- Create Layer --
      for I in Natural range 1 .. Number_Of_Inputs loop
         Output.Append(Neuron);
      end loop;

      return Output;

   end Create_Layer;

   ----------
   -- Fire --
   ----------
   
   function Fire (Neuron : Neuron_Type;
                  Input  : Float_Array) return Float
   is
      Sum          : Float   := Neuron.Bias;
      Vector_Index : Natural := 0;
      Weight       : Float;
   begin

      -- Sum the weighted inputs and the basis --
      for I in Input'First .. Input'Last loop
         Weight       := Neuron.Input_Weights(Vector_Index);
         Sum          := Sum + Input(I) * Weight;
         Vector_Index := Vector_Index + 1;
      end loop;

      -- Apply transfer function --
      return Neuron.Transfer(Sum);
   end Fire;

   ----------
   -- Fire --
   ----------

   function Fire (Layer  : Neuron_Layers.Vector;
                  Input  : Float_Array) return Float_Array
   is
      Vector_Index : Natural := 0;
      Output       : Float_Array (Input'First .. Input'Last);
   begin
      for I in Input'First .. Input'Last loop
         Output(I)    := Fire(Layer(Vector_Index), Input);
         Vector_Index := Vector_Index + 1;
      end loop;
      return Output;
   end Fire;

   ----------
   -- Fire --
   ----------

   function Fire (Network : Multi_Layer_Neural_Network.Vector;
                  Input   : Float_Array) return Float_Array
   is
      Output : Float_Array (1 .. Integer(Network.Length));
   begin

      if Network.Length = 0 then
         return Output;
      end if;

      -- Fire first layer with input array --
      Output := Fire(Network(0), Input);

      -- Fire remaining layers using output from --
      -- previous layers                         --
      for I in Natural range 1 .. Integer(Network.Length - 1) loop
         Output := Fire(Network(I), Output);
      end loop;

      return Output;
   end Fire;

end NN.Neuron;
