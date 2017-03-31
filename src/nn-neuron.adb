-----------------------------------------------------------------
--                                                             --
-- Neuron                                                      --
--                                                             --
-- Copyright (c) 2016, John Leimon, Adam Schwem                --
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
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;                  use Ada.Text_IO;
with NN.IO;                        use NN.IO;
with NN.Math;                      USE NN.Math;
with NN.Transfer;                  use NN.Transfer;

package body NN.Neuron is

   Weight_And_Bias_Floor   : constant :=      0;
   Weight_And_Bias_Ceiling : constant :=  99999;

   type Weight_And_Bias_Range is range Weight_And_Bias_Floor .. Weight_And_Bias_Ceiling;

   package Random is new Ada.Numerics.Discrete_Random (Weight_And_Bias_Range);

   ---------------------
   -- Generate_Weight --
   ---------------------

   function Generate_Weight return Long_Long_Float is
      Seed : Random.Generator;
   begin
      Random.Reset(Seed);
      return Long_Long_Float(Random.Random(Seed)) / Long_Long_Float(Weight_And_Bias_Ceiling);
   end Generate_Weight;

   --------------------------
   -- Identify_Convergence --
   --------------------------

   procedure Identify_Convergence (Neuron_Outputs : in  Real_Matrix;
                                   Has_Converged  : out Boolean;
                                   Neuron_Fired   : out Integer)
   is
      Non_Zero_Count : Natural := 0;
   begin

      -- A Hamming Network has converged when all neuron --
      -- outputs except exactly one are zero.            --

      -- Count neurons with zero output --
      for I in Neuron_Outputs'Range(1) loop
         for J in Neuron_Outputs'Range(2) loop
            if Neuron_Outputs(I, J) /= 0.0 then
               Neuron_Fired   := I;
               Non_Zero_Count := Non_Zero_Count + 1;
            end if;
            if Non_Zero_Count > 1 then
               Has_Converged := False;
               Neuron_Fired  := 0;
               return;
            end if;
         end loop;
      end loop;

      if Non_Zero_Count = 1 then
         Has_Converged := True;
      else
         Has_Converged := False;
      end if;

   end Identify_Convergence;

   ------------------
   -- Create_Layer --
   ------------------

   function Create_Layer (Number_Of_Neurons : Natural;
                          Number_Of_Inputs  : Natural;
                          Transfer          : Transfer_Function;
                          Input_Weights     : Real_Matrix_Access;
                          Bias              : Long_Long_Float := 0.0) return Neural_Layer
   is
      Bias_Array     : Float_Array_Access             := new Float_Array(Integer'First .. Integer'First + Number_Of_Neurons - 1);
      Transfer_Array : Transfer_Function_Array_Access := new Transfer_Function_Array(Integer'First .. Integer'First + Number_Of_Neurons - 1);
      Output         : Neural_Layer;
   begin

      Bias_Array.all     := (others => Bias);
      Transfer_Array.all := (others => Transfer);

      Output.Bias               := Bias_Array;
      Output.Weights            := Input_Weights;
      Output.Transfer_Functions := Transfer_Array;

      return Output;
   end Create_Layer;

   -------------------------
   -- Create_Layer_Random --
   -------------------------

   function Create_Layer_Random
     (Number_Of_Neurons : Natural;
      Number_Of_Inputs  : Natural;
      Transfer          : Transfer_Function) return Neural_Layer
   is
      Bias_Array     : Float_Array_Access             := new Float_Array(Integer'First .. Integer'First + Number_Of_Neurons - 1);
      Transfer_Array : Transfer_Function_Array_Access := new Transfer_Function_Array(Integer'First .. Integer'First + Number_Of_Neurons - 1);
      Input_Weights  : Real_Matrix_Access             := new Real_Matrix (Integer'First .. Integer'First + Number_Of_Inputs -1,
                                                                          Integer'First .. Integer'First);
      Output         : Neural_Layer;
   begin

      Input_Weights.all  := (others => (others => Random_Input_Weight));
      Bias_Array.all     := (others => Random_Bias);
      Transfer_Array.all := (others => Transfer);

      Output.Bias               := Bias_Array;
      Output.Weights            := Input_Weights;
      Output.Transfer_Functions := Transfer_Array;

      return Output;
   end Create_Layer_Random;

   -----------
   -- Delete--
   -----------

   procedure Delete(Layer : in out Neural_Layer)
   is
   begin
      Free(Layer.Bias);
      Free(Layer.Weights);
      Free(Layer.Transfer_Functions);
   end Delete;

   ----------------------------
   -- Create_Hamming_Network --
   ----------------------------

   function Create_Hamming_Network (Number_Of_Neurons : Natural;
                                    Number_Of_Inputs  : Natural;
                                    Prototypes        : Real_Matrix_Access;
                                    Bias              : Long_Long_Float) return Hamming_Network
   is
      ε                       : constant := 0.5;
      Output                  : Hamming_Network;
      Recurrent_Input_Weights : Real_Matrix_Access := new Real_Matrix (Integer'First .. Integer'First + Number_Of_Neurons - 1,
                                                                       Integer'First .. Integer'First + Number_Of_Neurons - 1);
   begin

      -- Our recurrent input weights matrix for a 2 x 2 matrix --
      -- would be:                                             --
      --               |  1   -ε  |                            --
      --               | -ε    1  |                            --

      -- Build recurrent input weights matrix --
      for I in Recurrent_Input_Weights'Range(1) loop
         for J in Recurrent_Input_Weights'Range(2) loop
            if Abs(I - J) + 1 = Recurrent_Input_Weights'Length(1) then
               Recurrent_Input_Weights(I, J) := -ε;
            else
               Recurrent_Input_Weights(I, J) := 1.0;
            end if;
         end loop;
      end loop;

      Output.Feedforward := Create_Layer(Number_Of_Neurons,
                                         Number_Of_Inputs,
                                         Linear'Access,
                                         Prototypes,
                                         Bias);
      Output.Recurrent   := Create_Layer(Number_Of_Neurons,
                                         Number_Of_Inputs,
                                         Positive_Linear'Access,
                                         Recurrent_Input_Weights,
                                         Bias);

      return Output;

   end Create_Hamming_Network;

   ------------
   -- Delete --
   ------------

   procedure Delete (Network : in out Hamming_Network)
   is
   begin
      Delete (Network.Feedforward);
      Delete (Network.Recurrent);
   end Delete;

   ----------
   -- Fire --
   ----------

   function Fire (Layer  : in  Neural_Layer;
                  Input  : in  Real_Matrix) return Real_Matrix
   is
      Weight             : Long_Long_Float;
      Sum                : Long_Long_Float;
      Output             : Real_Matrix (Integer'First .. Integer'First + Layer.Transfer_Functions'Length - 1,
                                        Integer'First .. Integer'First);
   begin

      for Neuron_Index in Integer'First .. Integer'First + Layer.Transfer_Functions'Length - 1 loop
         Sum := 0.0;

         for Input_Index in Layer.Weights'Range(2) loop
            Weight := Layer.Weights(Neuron_Index, Input_Index);
            Sum    := Sum + Input(Input_Index, Integer'First) * Weight;
         end loop;

         Sum                                 := Sum + Layer.Bias(Neuron_Index); 
         Output(Neuron_Index, Integer'First) := Layer.Transfer_Functions(Neuron_Index)(Sum);
      end loop;

      return Output;

   end Fire;

   --------------------
   -- Recursive_Fire --
   --------------------

   function Recursive_Fire (Network : Neural_Network;
                            Input   : Real_Matrix;
                            Layer   : Integer) return Real_Matrix
   is
   begin
      if Layer = Network'Last + 1 then
         return Input;
      end if;

      return Recursive_Fire(Network, Fire(Network(Layer), Input), Layer + 1);
   end Recursive_Fire;

   ----------
   -- Fire --
   ----------

   function Fire (Network : in  Neural_Network;
                  Input   : in  Real_Matrix) return Real_Matrix
   is
   begin
      return Recursive_Fire(Network, Input, Network'First);
   end Fire;

   ----------------------------
   -- Recursive_Hamming_Fire --
   ----------------------------

   function Recursive_Hamming_Fire (Network : Neural_Layer;
                                    Input   : Real_Matrix) return Real_Matrix
   is
      Has_Converged      : Boolean;
      Neuron_Fired       : Integer;
   begin
      Identify_Convergence(Input, Has_Converged, Neuron_Fired);

      if Has_Converged then
         return Input;
      else
         return Recursive_Hamming_Fire(Network, Fire(Network, Input));
      end if;
   end Recursive_Hamming_Fire;

   ----------
   -- Fire --
   ----------

   function Fire (Network : Hamming_Network;
                  Input   : Real_Matrix) return Real_Matrix
   is
   begin
      declare
         Feedforward_Output : Real_Matrix := Fire(Network.Feedforward, Input);
      begin
         return Recursive_Hamming_Fire(Network.Recurrent, Feedforward_Output);
      end;
   end Fire;

end NN.Neuron;
