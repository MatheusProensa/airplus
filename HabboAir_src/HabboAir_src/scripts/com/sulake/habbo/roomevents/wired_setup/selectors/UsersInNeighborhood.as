package com.sulake.habbo.roomevents.wired_setup.selectors
{
   public class UsersInNeighborhood extends InNeighborhood
   {
      public function UsersInNeighborhood()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_IN_NEIGHBORHOOD;
      }
   }
}

