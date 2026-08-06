package com.sulake.habbo.roomevents.wired_setup.selectors
{
   public class UsersFromSignal extends DefaultSelectorType
   {
      public function UsersFromSignal()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_FROM_SIGNAL;
      }
   }
}

