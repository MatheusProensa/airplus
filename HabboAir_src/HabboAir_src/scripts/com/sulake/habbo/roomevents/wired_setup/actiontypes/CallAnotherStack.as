package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class CallAnotherStack extends DefaultActionType
   {
      public function CallAnotherStack()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.CALL_ANOTHER_STACK;
      }
      
      override public function get negativeCode() : int
      {
         return ActionTypeCodes.NEG_CALL_ANOTHER_STACK;
      }
   }
}

