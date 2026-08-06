package com.sulake.habbo.roomevents.wired_setup.selectors
{
   public class UsersOnFurni extends DefaultSelectorType
   {
      public function UsersOnFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_ON_FURNI;
      }
   }
}

