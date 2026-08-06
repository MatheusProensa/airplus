package com.sulake.habbo.communication.messages.parser.vault
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardNotificationMessageEventParser implements IMessageParser
   {
      private var _rewardCategory:int;
      
      public function IncomeRewardNotificationMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _rewardCategory = param1.readByte();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get rewardCategory() : int
      {
         return _rewardCategory;
      }
   }
}

