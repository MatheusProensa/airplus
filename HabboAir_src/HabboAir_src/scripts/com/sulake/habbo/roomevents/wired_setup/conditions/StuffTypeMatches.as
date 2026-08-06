package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class StuffTypeMatches extends DefaultConditionType
   {
      public function StuffTypeMatches()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.STUFF_TYPE_MATCHES;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_STUFF_TYPE_MATCHES;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.match." + param1;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

