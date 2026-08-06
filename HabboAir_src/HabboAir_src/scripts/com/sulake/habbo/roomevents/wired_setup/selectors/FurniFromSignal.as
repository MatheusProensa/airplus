package com.sulake.habbo.roomevents.wired_setup.selectors
{
   public class FurniFromSignal extends DefaultSelectorType
   {
      public function FurniFromSignal()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.FURNI_FROM_SIGNAL;
      }
   }
}

