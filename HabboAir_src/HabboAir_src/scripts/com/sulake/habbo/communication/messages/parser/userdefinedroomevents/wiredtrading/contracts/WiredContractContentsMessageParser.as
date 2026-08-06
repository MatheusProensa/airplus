package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRulesDefinition;
   
   [SecureSWF(rename="true")]
   public class WiredContractContentsMessageParser implements IMessageParser
   {
      public static const UnknownConstFromWiredContractContentsMessageParser_Int_1:int = 0;
      
      public static const UnknownConstFromWiredContractContentsMessageParser_Int_2:int = 1;
      
      public static const UnknownConstFromWiredContractContentsMessageParser_Int_3:int = 2;
      
      public static const UnknownConstFromWiredContractContentsMessageParser_Int_4:int = 0;
      
      public static const UnknownConstFromWiredContractContentsMessageParser_Int_5:int = 1;
      
      private var _contractId:int;
      
      private var _contractType:int;
      
      private var _definition:TradeRequirementRulesDefinition;
      
      private var _paymentMode:int;
      
      private var _receiveText:String;
      
      private var _layoutType:String;
      
      private var _rewardCategory:int;
      
      private var _showDialog:Boolean;
      
      private var _rewardText:String;
      
      public function WiredContractContentsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _contractId = 0;
         _contractType = 0;
         _definition = null;
         _paymentMode = 0;
         _receiveText = null;
         _rewardCategory = 0;
         _showDialog = false;
         _rewardText = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _contractId = param1.readInteger();
         _contractType = param1.readShort();
         _definition = TradeRequirementRulesDefinition.readFromMessage(param1);
         if(_contractType == 0)
         {
            _paymentMode = param1.readShort();
            _receiveText = param1.readString();
            _layoutType = param1.readString();
         }
         if(_contractType == 2)
         {
            _rewardCategory = param1.readShort();
            _showDialog = param1.readBoolean();
            _rewardText = param1.readString();
         }
         return true;
      }
      
      public function get contractId() : int
      {
         return _contractId;
      }
      
      public function get contractType() : int
      {
         return _contractType;
      }
      
      public function get definition() : TradeRequirementRulesDefinition
      {
         return _definition;
      }
      
      public function get paymentMode() : int
      {
         return _paymentMode;
      }
      
      public function get receiveText() : String
      {
         return _receiveText;
      }
      
      public function get layoutType() : String
      {
         return _layoutType;
      }
      
      public function get rewardCategory() : int
      {
         return _rewardCategory;
      }
      
      public function get showDialog() : Boolean
      {
         return _showDialog;
      }
      
      public function get rewardText() : String
      {
         return _rewardText;
      }
   }
}

