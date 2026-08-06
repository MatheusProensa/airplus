package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class UnfreezeUser extends DefaultActionType
   {
      public function UnfreezeUser()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.UNFREEZE_USER;
      }
   }
}

