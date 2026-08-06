package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class BadgeAndPointLimit
   {
      private var _badgeId:String;
      
      private var _limit:int;
      
      public function BadgeAndPointLimit(param1:String, param2:IMessageDataWrapper)
      {
         super();
         _badgeId = "ACH_" + param1 + param2.readInteger();
         _limit = param2.readInteger();
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function get limit() : int
      {
         return _limit;
      }
   }
}

