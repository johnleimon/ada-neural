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
with Ada.Numerics.Real_Arrays;          use Ada.Numerics.Real_Arrays;
with Ada.Unchecked_Deallocation;

package NN.Neuron is

   type Float_Array is array (Natural range <>) of Float;
   type Transfer_Function_Array is array (Natural range <>) of Transfer_Function;

   type Float_Array_Access is access all Float_Array;
   type Real_Matrix_Access is access all Real_Matrix;
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

   type Delay_Block is new Real_Matrix_Access;

   type Hamming_Network is record
      Feedforward : Neural_Layer;
      Recurrent   : Neural_Layer;
      Block       : Delay_Block;
   end record;

   function Create_Delay_Block (Number_Of_Neurons : Natural) return Delay_Block;

   function Create_Layer (Number_Of_Neurons : Natural;
                          Number_Of_Inputs  : Natural;
                          Transfer          : Transfer_Function;
                          Input_Weights     : Real_Matrix;
                          Bias              : Float := 0.0) return Neural_Layer
   with Pre => Number_Of_Neurons > 0 and
               Number_Of_Inputs > 0;

   procedure Delete_Layer (Layer : in out Neural_Layer);

   function Create_Hamming_Network (Number_Of_Neurons : Natural;
                                    Number_Of_Inputs  : Natural;
                                    Bias              : Float) return Hamming_Network;

   procedure Delete_Hamming_Network (Network : in out Hamming_Network);

   procedure Fire (Layer  : in  Neural_Layer;
                   Input  : in  Real_Matrix;
                   Output : out Real_Matrix)
                   with Pre => 
                        Output'Length = Layer.Weights'Length(2);

   procedure Fire (Network : in  Neural_Network;
                   Input   : in  Real_Matrix;
                   Output  : out Real_Matrix)
                   with Pre => 
                        Output'Length = Network(Network'First).Weights'Length(2);

   procedure Fire (Block  : in out Delay_Block;
                   Input  : in     Real_Matrix;
                   Output : out    Real_Matrix)
                   with Pre => 
                        Block'Length = Input'Length
                                    and
                        Input'Length = Output'Length;

   procedure Fire (Network : in  out Hamming_Network;
                   Input   : in      Real_Matrix;
                   Output  : out     Real_Matrix);

end NN.Neuron;
