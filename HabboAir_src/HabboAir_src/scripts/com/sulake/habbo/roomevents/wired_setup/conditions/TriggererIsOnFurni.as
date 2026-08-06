package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class TriggererIsOnFurni extends DefaultConditionType
   {
      public function TriggererIsOnFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.TRIGGERER_IS_ON_FURNI;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_TRIGGERER_IS_ON_FURNI;
      }
   }
}

