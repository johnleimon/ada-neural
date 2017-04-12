-----------------------------------------------------------------
--                                                             --
-- Neural Network Transfer Functions                           --
--                                                             --
-- Copyright (c) 2016 John Leimon                              --
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
with Ada.Numerics;
with Ada.Numerics.Generic_Elementary_Functions;

package body NN.Transfer is

   Euler : constant := Ada.Numerics.e;

   package Elementary_Functions is new
           Ada.Numerics.Generic_Elementary_Functions (Long_Long_Float);
   use Elementary_Functions;

   ----------------
   -- Hard_Limit --
   ----------------

   function Hard_Limit
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      if input >= 0.0 then
         return 1.0;
      else
         return 0.0;
      end if;
   end Hard_Limit;

   ----------------------------
   -- Symmetrical_Hard_Limit --
   ----------------------------

   function Symmetrical_Hard_Limit
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      if input >= 0.0 then
         return 1.0;
      else
         return -1.0;
      end if;
   end Symmetrical_Hard_Limit;

   ------------
   -- Linear --
   ------------

   function Linear
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      return input;
   end Linear;

   -----------------------
   -- Saturating_Linear --
   -----------------------

   function Saturating_Linear
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      if input > 1.0 then
         return 1.0;
      elsif input < 0.0 then
         return 0.0;
      else
         return input;
      end if;
   end Saturating_Linear;

   ---------------------------------
   -- Symmetric_Saturating_Linear --
   ---------------------------------

   function Symmetric_Saturating_Linear
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      if input > 1.0 then
         return 1.0;
      elsif input < -1.0 then
         return -1.0;
      else
         return input;
      end if;
   end Symmetric_Saturating_Linear;

   -----------------
   -- Log_Sigmoid --
   -----------------

   function Log_Sigmoid
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      return 1.0 / (1.0 + Euler** (-input));
   end Log_Sigmoid;

   --------------------------------
   -- Hyperbolic_Tangent_Sigmoid --
   --------------------------------

   function Hyperbolic_Tangent_Sigmoid
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      return (Euler**input - Euler** (-input))
                           /
             (Euler**input + Euler** (-input));
   end Hyperbolic_Tangent_Sigmoid;

   ---------------------
   -- Positive_Linear --
   ---------------------

   function Positive_Linear
      (input : Long_Long_Float)
       return Long_Long_Float is
   begin
      if input < 0.0 then
         return 0.0;
      else
         return input;
      end if;
   end Positive_Linear;

begin
   null;
end NN.Transfer;
