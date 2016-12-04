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

package body NN.Neuron is

   ----------
   -- Fire --
   ----------
   
   function Fire (Neuron : Neuron_Type;
                  Input  : Float_Array) return Float
   is
      Sum          : Float   := Neuron.Bias;
      Vector_Index : Natural := 0;
      Weight       : Float;
   begin

      -- Sum the weighted inputs and the basis --
      for I in Input'First .. Input'Last loop
         Weight       := Neuron.Input_Weights(Vector_Index);
         Sum          := Sum + Input(I) * Weight;
         Vector_Index := Vector_Index + 1;
      end loop;

      -- Apply transfer function --
      return Neuron.Transfer(Sum);
   end Fire;

   ----------
   -- Fire --
   ----------

   function Fire (Layer  : Neuron_Layers.Vector;
                  Input  : Float_Array) return Float_Array
   is
      Vector_Index : Natural := 0;
      Output       : Float_Array (Input'First .. Input'Last);
   begin
      for I in Input'First .. Input'Last loop
         Output(I)    := Fire(Layer(Vector_Index), Input);
         Vector_Index := Vector_Index + 1;
      end loop;
      return Output;
   end Fire;

end NN.Neuron;
