-----------------------------------------------------------------
--                                                             --
-- Neuron Specification                                        --
--                                                             --
-- Copyright (c) 2016, 2017 John Leimon                        --
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
with NN.Math;
   use NN.Math;
with Ada.Unchecked_Deallocation;
with Ada.Containers.Indefinite_Vectors;
   use Ada.Containers;

package NN.Neuron is

   use NN.Math.Super_Matrixes;

   type Transfer_Function_Array is
      array (Integer range <>) of Transfer_Function;
   type Transfer_Function_Array_Access is
      access all Transfer_Function_Array;

   procedure Free is new
      Ada.Unchecked_Deallocation
         (Transfer_Function_Array, Transfer_Function_Array_Access);

   type Neural_Layer is record
      Bias               : Real_Matrix_Access;
      Weights            : Real_Matrix_Access;
      Transfer_Functions : Transfer_Function_Array_Access;
   end record;

   type Neural_Network is array (Natural range <>) of Neural_Layer;

   type Hamming_Network is record
      Feedforward : Neural_Layer;
      Recurrent   : Neural_Layer;
   end record;

   function Create_Layer
      (Number_Of_Neurons : Natural;
       Number_Of_Inputs  : Natural;
       Transfer          : Transfer_Function;
       Input_Weights     : Real_Matrix_Access;
       Bias              : Long_Long_Float := 0.0) return Neural_Layer
   with
   Pre =>
      Number_Of_Neurons > 0
      and
      Number_Of_Inputs > 0,
   Post =>
      Create_Layer'Result.Weights'Length (1) =
      Create_Layer'Result.Bias'Length (1)
      and
      Create_Layer'Result.Weights'Length (1) =
      Create_Layer'Result.Transfer_Functions'Length
      and
      Create_Layer'Result.Weights'First (1) =
      Create_Layer'Result.Transfer_Functions'First;

   function Create_Layer_Random
      (Number_Of_Neurons : Natural;
       Number_Of_Inputs  : Natural;
       Transfer          : Transfer_Function) return Neural_Layer
   with
   Pre =>
      Number_Of_Neurons > 0
      and
      Number_Of_Inputs > 0,
   Post =>
      Create_Layer_Random'Result.Weights'Length (1) =
      Create_Layer_Random'Result.Bias'Length (1)
      and
      Create_Layer_Random'Result.Weights'Length (1) =
      Create_Layer_Random'Result.Transfer_Functions'Length
      and
      Create_Layer_Random'Result.Weights'First (1) =
      Create_Layer_Random'Result.Transfer_Functions'First;
   -- Creates a layer with neurons that have biases and weights --
   -- with random numbers between 0.0 and 0.99999               --

   function Create_Sensitivity_Matrix
     (Network : Neural_Network)
      return Real_Matrix_Access_Array;

   function Create_Hamming_Network
      (Number_Of_Neurons : Natural;
       Number_Of_Inputs  : Natural;
       Prototypes        : Real_Matrix_Access;
       Bias              : Long_Long_Float)
       return Hamming_Network;

   procedure Delete
      (Layer : in out Neural_Layer);
   procedure Delete
      (Network : in out Hamming_Network);

   function Fire
      (Layer  : Neural_Layer;
       Input  : Real_Matrix)
       return Real_Matrix
   with Pre =>
     Layer.Weights'Length (2) = Input'Length (1)
     -- Number of input weights (columns in Weights)       --
     -- shall be equal to number of inputs (rows in Input) --
     and
     Layer.Weights'Length (1) = Layer.Bias'Length (1)
     -- Number of neurons (rows in Weights) shall be equal --
     -- to number of bias values                           --
     and
     Layer.Weights'Length (1) =
     Layer.Transfer_Functions'Length
     -- Number of neurons (rows in Weights) shall be equal --
     -- to number of transfer functions                    --
     and
     Layer.Weights'First (1) = Layer.Transfer_Functions'First,
     -- First index of rows in weights shall be equal to   --
     -- first index of Transfer_Functions                  --
     Post =>
     Fire'Result'Length (1) = Layer.Weights'Length (1);
     -- The number of outputs (rows in result) shall be    --
     -- equal to the number of neurons (rows in Weights)   --

   function Fire
      (Network : Hamming_Network;
       Input   : Real_Matrix)
       return Real_Matrix;

   function Generate_Weight
       return Long_Long_Float;
   function Generate_Bias
       return Long_Long_Float renames Generate_Weight;

end NN.Neuron;
