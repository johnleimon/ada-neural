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

package NN.Neuron is

   type Float_Array is array (Natural range <>) of Float;
   type Transfer_Function_Array is array (Natural range <>) of Transfer_Function;

   type Float_Array_Access is access all Float_Array;
   type Real_Matrix_Access is access all Real_Matrix;
   type Transfer_Function_Array_Access is access all Transfer_Function_Array;

   type Neural_Layer is record
      Bias               : Float_Array_Access;
      Weights            : Real_Matrix_Access;
      Transfer_Functions : Transfer_Function_Array_Access;
   end record;

   type Neural_Network is array (Natural range <>) of Neural_Layer;

   type Delay_Block is new Float_Array;

   procedure Fire (Layer  : in  Neural_Layer;
                   Input  : in  Float_Array;
                   Output : out Float_Array)
   with Pre => Output'Length = Layer.Weights'Length(2);

   procedure Fire (Network : in  Neural_Network;
                   Input   : in  Float_Array;
                   Output  : out Float_Array)
   with Pre => Output'Length = Network(Network'First).Weights'Length(2);

   procedure Fire (Block  : in out Delay_Block;
                   Input  : in     Float_Array;
                   Output : out    Float_Array)
   with Pre => Block'Length = Input'Length and
               Input'Length = Output'Length;

end NN.Neuron;
