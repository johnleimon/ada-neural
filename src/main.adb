with nn.transfer; use nn.transfer;
with nn.neuron;   use nn.neuron;
with Ada.Containers.Indefinite_Vectors; use Ada.Containers;
with ada.text_io; use ada.text_io;

procedure main is
   use Neuron_Input_Vectors;
   N      : Neuron_Type;
   Result : Float;
begin
   N.Transfer := satlin'access;

   -- Configure neuron for two inputs --
   N.Input_Weights.Append(1.0);
   N.Input_Weights.Append(0.5);
   N.Bias := 0.0;

   Result := Fire(N, (0.1, 0.2));

   Put_Line("Result : " & Float'image(Result));

end main;
