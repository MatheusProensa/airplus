package com.sulake.habbo.roomevents.wired_setup.addons
{
   public class FurniSelectorFilter extends SelectorFilter
   {
      public function FurniSelectorFilter()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.FURNI_SELECTOR_FILTER;
      }
   }
}

