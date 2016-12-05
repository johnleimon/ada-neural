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

   procedure Fire (Layer  : in  Neural_Layer;
                   Input  : in  Float_Array;
                   Output : out Float_Array)
   is
      Input_Index  : Natural  := 0;
      Neuron_Index : Natural  := 0;
      Weight       : Float;
      Sum          : Float; 
   begin
      
      for N in Layer.Weights'Range(1) loop
         
         Sum         := 0.0;
         Input_Index := 0;

         for I in Layer.Weights'Range(2) loop
            Weight      := Layer.Weights(N,I);
            Sum         := Sum + Input(Input_Index) * Weight;
            Input_Index := Input_Index + 1;
         end loop;
         
         Sum                  := Sum + Layer.Bias(Neuron_Index);
         Sum                  := Layer.Transfer_Functions(Neuron_Index)(Sum);
         Output(Neuron_Index) := Sum;
         Neuron_Index         := Neuron_Index + 1;
         
      end loop;
      
   end Fire;
end NN.Neuron;
