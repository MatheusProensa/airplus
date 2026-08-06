package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class CanPerformMove extends DefaultConditionType
   {
      public function CanPerformMove()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.CAN_PERFORM_MOVE;
      }
   }
}

