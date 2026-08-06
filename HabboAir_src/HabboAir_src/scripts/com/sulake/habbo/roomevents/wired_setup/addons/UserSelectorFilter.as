package com.sulake.habbo.roomevents.wired_setup.addons
{
   public class UserSelectorFilter extends SelectorFilter
   {
      public function UserSelectorFilter()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.USER_SELECTOR_FILTER;
      }
   }
}

