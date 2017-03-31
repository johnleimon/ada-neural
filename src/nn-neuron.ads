-----------------------------------------------------------------
--                                                             --
-- Neuron Specification                                        --
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
with Ada.Containers.Indefinite_Vectors; use Ada.Containers;
with Ada.Unchecked_Deallocation;
with NN.Math; use NN.Math;

package NN.Neuron is

   use NN.Math.Super_Matrixes;

   type Transfer_Function_Array is array (Integer range <>) of Transfer_Function;
   type Transfer_Function_Array_Access is access all Transfer_Function_Array;

   procedure Free is new Ada.Unchecked_Deallocation(Float_Array, Float_Array_Access);
   procedure Free is new Ada.Unchecked_Deallocation(Real_Matrix, Real_Matrix_Access);
   procedure Free is new Ada.Unchecked_Deallocation(Transfer_Function_Array, Transfer_Function_Array_Access);

   type Neural_Layer is record
      Bias               : Float_Array_Access;
      Weights            : Real_Matrix_Access;
      Transfer_Functions : Transfer_Function_Array_Access;
   end record;

   type Neural_Network is array (Natural range <>) of Neural_Layer;

   type Hamming_Network is record
      Feedforward : Neural_Layer;
      Recurrent   : Neural_Layer;
   end record;

   function Generate_Weight return Long_Long_Float;
   function Generate_Bias return Long_Long_Float renames Generate_Weight;

   function Create_Layer (Number_Of_Neurons : Natural;
                          Number_Of_Inputs  : Natural;
                          Transfer          : Transfer_Function;
                          Input_Weights     : Real_Matrix_Access;
                          Bias              : Long_Long_Float := 0.0) return Neural_Layer
                          with Pre => Number_Of_Neurons > 0 and
                                      Number_Of_Inputs > 0;

   function Create_Layer_Random (Number_Of_Neurons : Natural;
                                 Number_Of_Inputs  : Natural;
                                 Transfer          : Transfer_Function) return Neural_Layer
                                 with Pre => Number_Of_Neurons > 0 and
                                             Number_Of_Inputs > 0;
   -- Creates a layer with neurons that have biases and weights --
   -- with random numbers between 0.0 and 0.99999               --

   procedure Delete (Layer : in out Neural_Layer);

   function Create_Hamming_Network (Number_Of_Neurons : Natural;
                                    Number_Of_Inputs  : Natural;
                                    Prototypes        : Real_Matrix_Access;
                                    Bias              : Long_Long_Float) return Hamming_Network;

   procedure Delete (Network : in out Hamming_Network);

   function Fire (Layer  : Neural_Layer;
                  Input  : Real_Matrix) return Real_Matrix;

   function Fire (Network : Neural_Network;
                  Input   : Real_Matrix) return Real_Matrix;

   function Fire (Network : Hamming_Network;
                  Input   : Real_Matrix) return Real_Matrix;

end NN.Neuron;
