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
with Ada.Text_IO; use Ada.Text_IO;

package body NN.Neuron is

   ------------------
   -- Create_Layer --
   ------------------

   function Create_Layer (Number_Of_Neurons : Natural;
                          Number_Of_Inputs  : Natural;
                          Transfer          : Transfer_Function;
                          Bias              : Float := 0.0;
                          Input_Weights     : Float := 1.0) return Neural_Layer
   is
      Bias_Array         : Float_Array_Access := new Float_Array(1 .. Number_Of_Neurons);
      Input_Weight_Array : Real_Matrix_Access := new Real_Matrix(Integer'First .. Integer'First + Number_Of_Neurons - 1,
                                                                 Integer'First .. Integer'First + Number_Of_Inputs - 1);
      Transfer_Array     : Transfer_Function_Array_Access := new Transfer_Function_Array(1 .. Number_Of_Neurons);
      Output             : Neural_Layer;
   begin
      Output.Bias               := Bias_Array;
      Output.Weights            := Input_Weight_Array;
      Output.Transfer_Functions := Transfer_Array;

      return Output;
   end Create_Layer;

   ----------
   -- Fire --
   ----------

   procedure Fire (Layer  : in  Neural_Layer;
                   Input  : in  Float_Array;
                   Output : out Float_Array)
   is
      Input_Index  : Natural;
      Neuron_Index : Natural;
      Weight       : Float;
      Sum          : Float; 
   begin

      Neuron_Index := 0;
      
      for Neuron in Layer.Weights'Range(1) loop
         Sum         := 0.0;
         Input_Index := 0;

         for Input_Weight in Layer.Weights'Range(2) loop
            Weight      := Layer.Weights(Neuron, Input_Weight);
            Sum         := Sum + Input(Input_Index) * Weight;
            Input_Index := Input_Index + 1;
         end loop;
         
         Sum                  := Sum + Layer.Bias(Neuron_Index);
         Output(Neuron_Index) := Layer.Transfer_Functions(Neuron_Index)(Sum);
         Neuron_Index         := Neuron_Index + 1;
      end loop;
   end Fire;

   ----------
   -- Fire --
   ----------

   procedure Fire (Network : in  Neural_Network;
                   Input   : in  Float_Array;
                   Output  : out Float_Array)
   is
      Next_Input : Float_Array(Input'First .. Input'Last);
   begin
      Next_Input := Input;
      for Layer in Network'Range loop
         Fire(Network(Layer), Next_Input, Output);
         Next_Input := Output;
      end loop;
   end Fire;

   ----------
   -- Fire --
   ----------

   procedure Fire (Block  : in out Delay_Block;
                   Input  : in     Float_Array;
                   Output : out    Float_Array)
   is
   begin
      Output := Float_Array(Block);
      Block  := Delay_Block(Input);
   end Fire;
end NN.Neuron;
