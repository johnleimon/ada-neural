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
      Neuron_Index : constant := 1;
      Weight_Index : constant := 2;
      Output_Index : Natural  := Output'First;
   begin

put_line(natural'image(Layer.Weights'Length(Weight_Index)) & " x " &
         natural'image(Layer.Weights'Length(Neuron_Index)));

      for N in Layer.Weights'Range(Neuron_Index) loop
         for W in Layer.Weights'Range(Weight_Index) loop
            Put_Line(Natural'Image(Output_Index) & ": " & Float'Image(Layer.Weights(N, W)));
         end loop;
         Output_Index := Output_Index + 1;
      end loop;

   end Fire;

end NN.Neuron;
