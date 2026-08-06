package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class TradeRequirementRules
   {
      private var UnknownVarFromTradeRequirementRules_TradeRequirementRulesDefinition_1:TradeRequirementRulesDefinition;
      
      private var _type:int;
      
      private var _multiplier:int = 1;
      
      private var _autoMultiplierMax:int = 1;
      
      public function TradeRequirementRules(param1:IMessageDataWrapper)
      {
         super();
         UnknownVarFromTradeRequirementRules_TradeRequirementRulesDefinition_1 = TradeRequirementRulesDefinition.readFromMessage(param1);
         _type = param1.readInteger();
         if(_type == UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1.UnknownVarFromUnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1_Int_2)
         {
            _multiplier = param1.readInteger();
         }
         else if(_type == UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1.UnknownVarFromUnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1_Int_3)
         {
            _autoMultiplierMax = param1.readInteger();
         }
      }
      
      public function get youGiveRule() : Vector.<TradeRequirementRule>
      {
         return UnknownVarFromTradeRequirementRules_TradeRequirementRulesDefinition_1.youGiveRule;
      }
      
      public function get youGetRule() : TradeRequirementRule
      {
         return UnknownVarFromTradeRequirementRules_TradeRequirementRulesDefinition_1.youGetRule;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get multiplier() : int
      {
         return _multiplier;
      }
      
      public function get autoMultiplierMax() : int
      {
         return _autoMultiplierMax;
      }
   }
}

