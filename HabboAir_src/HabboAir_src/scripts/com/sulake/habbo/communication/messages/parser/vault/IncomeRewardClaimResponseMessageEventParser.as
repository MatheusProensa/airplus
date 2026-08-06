package com.sulake.habbo.communication.messages.parser.vault
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardClaimResponseMessageEventParser implements IMessageParser
   {
      private var _rewardCategory:int;
      
      private var _result:Boolean;
      
      public function IncomeRewardClaimResponseMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _rewardCategory = param1.readByte();
         _result = param1.readBoolean();
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
      
      public function get result() : Boolean
      {
         return _result;
      }
   }
}

