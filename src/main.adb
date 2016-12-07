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
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Ada.Text_IO;              use Ada.Text_IO;
with NN.IO;                    use NN.IO;
with NN.Transfer;              use NN.Transfer;
with NN.Math;                  use NN.Math;
with NN.Neuron;                use NN.Neuron;

procedure Main is

   procedure Test_PseudoInverse
   is
      Input  : Real_Matrix :=  ( (  1.0,  1.0 ),
                                 ( -1.0,  1.0 ),
                                 ( -1.0, -1.0 ) );
      Output : Real_Matrix := PseudoInverse(Input);
   begin

      Put_Line("Test: PseudoInverse");

      Put_Line("   INPUT:  ");
      Put(Input);

      Put_Line("   OUTPUT: ");
      Put(Output);

      -- Evaluate Output --

      if Output = ( (  0.25, -0.50, -0.25 ),
                    (  0.25,  0.50, -0.25 ) )
      then
         Put_Line(GREEN & "   [ PASS ]" & DEFAULT);
      else
         Put_Line(RED   & "   [ FAIL ]" & DEFAULT);
      end if;

   end Test_PseudoInverse;

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

      Put_Line("   INPUTS:  ");
      Put(Input);

      Put_Line("   OUTPUTS: ");
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

      Prototypes : aliased Real_Matrix := ( ( 1.0, -1.0, -1.0 ),
                                            ( 1.0,  1.0, -1.0 ) );
      Input      : Real_Matrix         := ( ( Integer'First => -1.0 ),
                                            ( Integer'First => -1.0 ),
                                            ( Integer'First => -1.0 ) );
      Output     : Integer;
      Network    : Hamming_Network;
   begin

      Network := Create_Hamming_Network(Number_Of_Neurons => 2,
                                        Number_Of_Inputs  => 3,
                                        Prototypes        => Prototypes'Unchecked_Access,
                                        Bias              => 3.0);

      Put_Line("Test: Fire Hamming Network");

      Fire(Network, Input, Output);

      Put_Line("   INPUTS:  ");
      Put(Input);

      Put("   OUTPUT: ");
      Put_Line(Integer'Image(Output));

      -- Evaluate output --
      if Output = 0 then
         Put_Line(GREEN & "   [ PASS ]" & DEFAULT);
      else
         Put_Line(RED   & "   [ FAIL ]" & DEFAULT);
      end if;

   end Test_Fire_Hamming_Network;

begin
      
   Test_Fire_Neural_Layer;
   Test_Fire_Hamming_Network;
   Test_PseudoInverse;

end Main;
