package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class Chase extends DefaultActionType
   {
      public function Chase()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.CHASE;
      }
   }
}

