package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRules;
   
   public class TradeRequirement
   {
      public static var UnknownVarFromTradeRequirement_Int_1:int = 0;
      
      public static var UnknownVarFromTradeRequirement_Int_2:int = 1;
      
      public static var UnknownVarFromTradeRequirement_Int_3:int = 2;
      
      public static var UnknownVarFromTradeRequirement_Int_4:int = 4;
      
      private var _type:int;
      
      private var _youGetText:String;
      
      private var _layoutType:String;
      
      private var _rules:TradeRequirementRules = null;
      
      public function TradeRequirement(param1:IMessageDataWrapper)
      {
         super();
         _type = param1.readInteger();
         _youGetText = param1.readString();
         _layoutType = param1.readString();
         if(_type == UnknownVarFromTradeRequirement_Int_4)
         {
            _rules = new TradeRequirementRules(param1);
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get youGetText() : String
      {
         return _youGetText;
      }
      
      public function get layoutType() : String
      {
         return _layoutType;
      }
      
      public function get rules() : TradeRequirementRules
      {
         return _rules;
      }
      
      public function isPaymentOnly() : Boolean
      {
         if(_type == UnknownVarFromTradeRequirement_Int_4)
         {
            return _rules.youGetRule == null || _rules.youGetRule.nodes.length == 0;
         }
         return true;
      }
   }
}

