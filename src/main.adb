-----------------------------------------------------------------
--                                                             --
-- Ada Neural Network Test Program                             --
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
with NN;          use NN;
with NN.IO;       use NN.IO;
with NN.Math;     use NN.Math;
with NN.Neuron;   use NN.Neuron;
with NN.Transfer; use NN.Transfer;

procedure Main is

   use NN.Math.Super_Matrixes;

   DEFAULT : constant String := Character'Val(16#1B#) & "[39m";
   GREEN   : constant String := Character'Val(16#1B#) & "[92m";
   RED     : constant String := Character'Val(16#1B#) & "[31m";

   DEBUG   : constant Boolean := False; -- Prints full debug info --

   --------------------------
   -- Register_Test_Result --
   --------------------------

   procedure Register_Test_Result (Test_Name : String;
                                   Pass      : Boolean;
                                   Input     : Real_Matrix;
                                   Output    : Real_Matrix)
   is
   begin
      if Pass then
         Put_Line(Test_Name & GREEN & " [ PASS ]" & DEFAULT);
      else
         Put_Line(Test_Name & RED & " [ FAIL ]" & DEFAULT);
      end if;
      if DEBUG then
         Put_Line("   INPUT:  ");
         Put(Input);
         Put_Line("   OUTPUT: ");
         Put(Output);
      end if;
   end Register_Test_Result;
   
   ----------------------------
   --    Test_Create_Layer   --
   ----------------------------
   
   procedure Test_Create_Layer
   is
      Number_Of_Neurons : Natural             := 2;
      Number_Of_Inputs  : Natural             := 3;
      Transfer          : Transfer_Function   := satlin'access;
      Input_Weights     : aliased Real_Matrix := Create_Real_Matrix(Number_Of_Neurons, Number_Of_Inputs);
      Bias              : Long_Long_Float     := 0.0;
      Input             : Real_Matrix         := Create_Real_Matrix(Number_Of_Inputs, 1);
      Test_Name         : String              := "Test_Create_Layer";
      Test_Result       : Boolean             := False;                           
      Test_Layer        : Neural_Layer;
   begin

      -- Setup neuron layer --
      for I in Input_Weights'Range(1) loop
         for J in Input_Weights'Range(2) loop
            Input_Weights(I, J) := 0.5;
         end loop;
      end loop;

      for I in Input'Range(1) loop
         for J in Input'Range(2) loop
            Input(I, J) := 0.5;
         end loop;
      end loop;

      Test_Layer := Create_Layer(Number_Of_Neurons => Number_Of_Neurons,
                                 Number_Of_Inputs  => Number_Of_Inputs,
                                 Transfer          => Transfer,
                                 Input_Weights     => Input_Weights'Unchecked_access,
                                 Bias              => Bias);
                                  
      -- Fire neuron layer --
      declare
         Output : Real_Matrix := Fire(Test_Layer, Input);
      begin
         -- Evaluate output --
         if Output(Output'First,     Output'First) = 0.75 and
            Output(Output'First + 1, Output'First) = 0.75
         then
            Test_Result := True;
         end if;
      
         Register_Test_Result(Test_Name, Test_Result, Input, Output);
      end;
      
   end Test_Create_Layer;

   ------------------------
   -- Test_PseudoInverse --
   ------------------------

   procedure Test_PseudoInverse
   is
      Input       : Real_Matrix :=  ( (  1.0,  1.0 ),
                                      ( -1.0,  1.0 ),
                                      ( -1.0, -1.0 ) );
      Output      : Real_Matrix := PseudoInverse(Input);
      Test_Name   : String      := "Test_PseudoInverse";
      Test_Result : Boolean     := False;  
   begin

      -- Evaluate Output --
      if Output = ( (  0.25, -0.50, -0.25 ),
                    (  0.25,  0.50, -0.25 ) )
      then
         Test_Result := True;
      end if;

      Register_Test_Result(Test_Name, Test_Result, Input, Output);

   end Test_PseudoInverse;

   ----------------------------
   -- Test_Fire_Neural_Layer --
   ----------------------------

   procedure Test_Fire_Neural_Layer
   is
      Bias        : aliased Float_Array :=  ( 0.1, -0.06 );
      -- Two Neurons, Three Weights --
      Weights     : aliased Real_Matrix := ( ( 0.5, 0.5, 0.5 ),
                                             ( 0.7, 0.1, 0.9 ) );
      Input       : Real_Matrix         := ( ( Integer'First => 0.1 ),
                                             ( Integer'First => 0.2 ),
                                             ( Integer'First => 0.3 ) );
      Transfer    : aliased Transfer_Function_Array := ( satlin'access,
                                                         satlin'access );
      Layer       : Neural_Layer;
      Test_Name   : String              := "Fire Neural Network Layer";
      Test_Result : Boolean             := False;
   begin

      --   Number of Inputs:  3                    --
      --   Number of Neurons: 2                    --
      --                                           --
      --   INPUTS    WEIGHTS   NEURON    OUTPUT    --
      --                        BIAS               --
      --                                           --
      --    0.1        0.5                         --
      --               0.7                         --
      --                        0.1       0.4      --
      --    0.2        0.5                         --
      --               0.1                         --
      --                       -0.06      0.3      --
      --    0.3        0.5                         --
      --               0.9                         --
      --                                           --

      -- Setup neuron layer --
      Layer.Bias               := Bias'Unchecked_access;
      Layer.Weights            := Weights'Unchecked_access;
      Layer.Transfer_Functions := Transfer'Unchecked_access;

      -- Fire neuron layer --
      declare
         Output : Real_Matrix := Fire(Layer, Input);
      begin
         -- Evaluate output --
         if Output(Output'First, Output'First)     = 0.4 and
            Output(Output'First + 1, Output'First) = 0.3
         then
            Test_Result := True;
         end if;
      
         Register_Test_Result(Test_Name, Test_Result, Input, Output);
      end;

      if DEBUG then
         Put_Line("WEIGHTS");
         Put(Weights);
      end if;

   end Test_Fire_Neural_Layer;

   -------------------------------
   -- Test_Fire_Hamming_Network --
   -------------------------------

   procedure Test_Fire_Hamming_Network
   is
      -- Prototype Definitions:          --
      --                                 --
      --          |  1 |          |  1 | --
      --          |    |          |    | --
      -- Orange = | -1 |  Apple = |  1 | --
      --          |    |          |    | --
      --          | -1 |          | -1 | --

      Prototypes  : aliased Real_Matrix := ( ( 1.0, -1.0, -1.0 ),
                                             ( 1.0,  1.0, -1.0 ) );
      Input       : Real_Matrix         := ( ( Integer'First => -1.0 ),
                                             ( Integer'First => -1.0 ),
                                             ( Integer'First => -1.0 ) );
      Network     : Hamming_Network;
      Test_Name   : String              := "Fire Hamming Network";
      Test_Result : Boolean             := False;
   begin

      -- Setup Hamming Network layers --
      Network := Create_Hamming_Network(Number_Of_Neurons => 2,
                                        Number_Of_Inputs  => 3,
                                        Prototypes        => Prototypes'Unchecked_Access,
                                        Bias              => 3.0);
                                 
      -- Fire Hamming Network layers --
      declare
         Output : Real_Matrix := Fire(Network, Input);
      begin
         if Output(Integer'First + 0, Integer'First) > 0.0 and
            Output(Integer'First + 1, Integer'First) = 0.0
         then
            Test_Result := True;
         end if;

         Register_Test_Result(Test_Name, Test_Result, Input, Output);
      end;

   end Test_Fire_Hamming_Network;

   -------------------
   -- Test_Gradient --
   -------------------

   procedure Test_Gradient
   is
      Input : Real_Matrix := ( ( 2.0, 1.0 ),
                               ( 1.0, 2.0 ) );
      Point : Real_Matrix := ( ( Integer'First =>  0.8  ),
                               ( Integer'First => -0.25 ) );
   begin

      declare
         Output : Real_Matrix := Gradient(Input, Point);
      begin

         if Output(Integer'First, Integer'First) = 1.35 and
            Output(Integer'First + 1, Integer'First) = 0.3
         then
            Register_Test_Result("Test_Gradient",
                                 True,
                                 Input,
                                 Output);
         else
            Register_Test_Result("Test_Gradient",
                                 False,
                                 Input,
                                 Output);
         end if;

      end;
   end Test_Gradient;

   -----------------------------
   -- Test_Conjugate_Gradient --
   -----------------------------

   procedure Test_Conjugate_Gradient
   is
      Input : Real_Matrix := ( ( 2.0, 1.0 ),
                               ( 1.0, 2.0 ) );
      Point : Real_Matrix := ( ( Integer'First => 20.0  ),
                               ( Integer'First => -1.25 ) );
   begin
      declare
         Output : Real_Matrix := Conjugate_Gradient(Input, Point);
      begin

         if Δ(Output(Integer'First,     Integer'First), 0.0) < 0.00000000000001 and
            Δ(Output(Integer'First + 1, Integer'First), 0.0) < 0.00000000000001
         then
            Register_Test_Result("Test_Conjugate_Gradient",
                                 True,
                                 Input,
                                 Output);
         else
            Register_Test_Result("Test_Conjugate_Gradient",
                                 False,
                                 Input,
                                 Output);
         end if;

      end;
   end Test_Conjugate_Gradient;

begin

   Test_Create_Layer;
   Test_Fire_Neural_Layer;
   Test_Fire_Hamming_Network;
   Test_PseudoInverse;
   Test_Gradient;
   Test_Conjugate_Gradient;

end Main;
