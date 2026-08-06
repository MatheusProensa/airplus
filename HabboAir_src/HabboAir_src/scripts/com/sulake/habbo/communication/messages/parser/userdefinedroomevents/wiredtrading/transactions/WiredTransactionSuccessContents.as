package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   
   public class WiredTransactionSuccessContents
   {
      public static const UnknownConstFromWiredTransactionSuccessContents_Int_1:int = 2;
      
      private var _internalId:int;
      
      private var _transactionSuccessTypeId:int;
      
      private var _rewardContents:TradeRequirementRule;
      
      private var _rewardText:String;
      
      private var _openByDefault:Boolean;
      
      public function WiredTransactionSuccessContents(param1:int, param2:IMessageDataWrapper)
      {
         super();
         _internalId = param1;
         _transactionSuccessTypeId = param2.readInteger();
         if(_transactionSuccessTypeId == 2 && param2.bytesAvailable > 0)
         {
            _rewardContents = TradeRequirementRule.readFromMessage(param2);
            _rewardText = param2.readString();
            _openByDefault = param2.readBoolean();
         }
      }
      
      public function get internalId() : int
      {
         return _internalId;
      }
      
      public function get transactionSuccessTypeId() : int
      {
         return _transactionSuccessTypeId;
      }
      
      public function get rewardContents() : TradeRequirementRule
      {
         return _rewardContents;
      }
      
      public function get rewardText() : String
      {
         return _rewardText;
      }
      
      public function get openByDefault() : Boolean
      {
         return _openByDefault;
      }
   }
}

