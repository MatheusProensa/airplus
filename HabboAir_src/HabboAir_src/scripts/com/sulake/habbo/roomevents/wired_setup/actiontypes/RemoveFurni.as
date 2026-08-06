package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class RemoveFurni extends DefaultActionType
   {
      public function RemoveFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.REMOVE_FURNI;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

