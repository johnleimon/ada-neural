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

   type Fixed is delta 0.01 range -100.0..100.0;

   DEFAULT : constant String := Character'Val(16#1B#) & "[39m";
   GREEN   : constant String := Character'Val(16#1B#) & "[92m";
   RED     : constant String := Character'Val(16#1B#) & "[31m";

   ---------
   -- Put --
   ---------

   procedure Put (X : Real_Matrix)
   is
   begin
      for I in X'Range (1) loop
         for J in X'Range (2) loop
            Put (Fixed'Image (Fixed (X (I, J))));
         end loop;
      end loop;
      New_Line;
   end Put;

   ----------------------------
   -- Test_Fire_Neural_Layer --
   ----------------------------

   procedure Test_Fire_Neural_Layer
   is

      Bias     : aliased Float_Array :=  ( 0.1, -0.06 );
      -- Two Neurons, Three Weights --
      Weights  : aliased Real_Matrix := ( ( 0.5, 0.5, 0.5 ),
                                          ( 0.7, 0.1, 0.9 ) );
      Input    : Real_Matrix         :=  ( ( Integer'First => 0.1 ),
                                           ( Integer'First => 0.2 ),
                                           ( Integer'First => 0.3 ) );
      Output   : Real_Matrix         :=  ( ( Integer'First => 0.0 ),
                                           ( Integer'First => 0.0 ),
                                           ( Integer'First => 0.0 ) );
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

      Put_Line("Test: Fire Neural Network Layer");

      Put("   INPUTS:  ");
      Put(Input);

      Put("   OUTPUTS: ");
      Put(Output);

      -- Evaluate output --
      if Output(Output'First, Output'First)     = 0.4 and
         Output(Output'First + 1, Output'First) = 0.3
      then
         Put_Line(GREEN & "   [ PASS ]" & DEFAULT);
      else
         Put_Line(RED   & "   [ FAIL ]" & DEFAULT);
      end if;

   end Test_Fire_Neural_Layer;

   ---------------------------
   -- Demo_Fire_Delay_Block --
   ---------------------------

   procedure Demo_Fire_Delay_Block
   is
      Initial_Condition : aliased Real_Matrix := ( 1 => ( 1.0, 2.0 ) );
      Input             :         Real_Matrix := ( 1 => ( 7.7, 9.9 ) );
      Output_1          :         Real_Matrix := ( 1 => ( 0.0, 0.0 ) );
      Output_2          :         Real_Matrix := ( 1 => ( 0.0, 0.0 ) );
      Block             :         Delay_Block := Initial_Condition'unchecked_access;
   begin

      Fire(Block, Input, Output_1);
      Fire(Block, Input, Output_2);

      Put_Line("Demo: Fire Delay Block");

      Put("   INPUTS:  ");
      Put(Input);

      Put("   OUTPUT 1:");
      Put(Output_1);

      Put("   OUTPUT 2:");
      Put(Output_2);

   end Demo_Fire_Delay_Block;

   -------------------------------
   -- Test_Fire_Hamming_Network --
   -------------------------------

   procedure Test_Fire_Hamming_Network
   is
      Input   : Real_Matrix :=  ( ( Integer'First =>  1.0 ),
                                  ( Integer'First => -1.0 ),
                                  ( Integer'First => -1.0 ) );
      Output  : Real_Matrix :=  ( ( Integer'First =>  0.0 ),
                                  ( Integer'First =>  0.0 ),
                                  ( Integer'First =>  0.0 ) );
      Network : Hamming_Network;
   begin

      Network := Create_Hamming_Network(2, 3, 3.0);

      Put_Line("Test: Fire Neural Network Layer");

      Fire(Network, Input, Output);

      Put("   INPUTS:  ");
      Put(Input);

      Put("   OUTPUTS: ");
      Put(Output);

   end Test_Fire_Hamming_Network;

begin
      
   Test_Fire_Neural_Layer;
   Demo_Fire_Delay_Block;
   Test_Fire_Hamming_Network;

end Main;
