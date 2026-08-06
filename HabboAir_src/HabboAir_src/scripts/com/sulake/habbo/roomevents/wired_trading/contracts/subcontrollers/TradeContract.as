package com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractContentsMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRulesDefinition;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.TradeRuleEditorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.TradeRuleListEditorPreset;
   import com.sulake.habbo.roomevents.wired_trading.contracts.WiredContractController;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.util.AbstractContract;
   
   public class TradeContract extends AbstractContract
   {
      private var UnknownVarFromTradeContract_TradeRuleListEditorPreset_1:TradeRuleListEditorPreset;
      
      private var UnknownVarFromTradeContract_TradeRuleEditorPreset_1:TradeRuleEditorPreset;
      
      public function TradeContract(param1:WiredContractController, param2:PresetManager)
      {
         super(param1,param2);
         UnknownVarFromTradeContract_TradeRuleListEditorPreset_1 = param2.createRuleListEditorPreset(param1.addEditContractElement.onEdit,param1.addEditContractElement.onAdd);
         var _loc3_:SectionPreset = param2.createSection("${wiredcontracts.payment_requirements}",UnknownVarFromTradeContract_TradeRuleListEditorPreset_1);
         UnknownVarFromTradeContract_TradeRuleEditorPreset_1 = param2.createRuleEditorPreset("${wiredcontracts.reward_rule}",param1.addEditContractElement.onEdit,param1.addEditContractElement.onAdd);
         var _loc4_:SectionPreset = param2.createSection("${wiredcontracts.reward_requirements}",UnknownVarFromTradeContract_TradeRuleEditorPreset_1);
         framePreset = param2.createFramePreset([_loc3_,_loc4_,footerPreset],onCloseClicked);
         framePreset.resizeToWidth(262);
         framePreset.title = "${wiredcontracts.trade_contract.title}";
      }
      
      override protected function createNewDefinitionFromUI() : TradeRequirementRulesDefinition
      {
         return new TradeRequirementRulesDefinition(UnknownVarFromTradeContract_TradeRuleListEditorPreset_1.finalizeRules(),UnknownVarFromTradeContract_TradeRuleEditorPreset_1.finalizeRule());
      }
      
      override public function show(param1:WiredContractContentsMessageParser) : void
      {
         if(param1.contractType != contractType() || param1.definition.youGiveRule == null || param1.definition.youGetRule == null)
         {
            return;
         }
         super.show(param1);
         UnknownVarFromTradeContract_TradeRuleListEditorPreset_1.rules = param1.definition.youGiveRule;
         UnknownVarFromTradeContract_TradeRuleEditorPreset_1.rule = param1.definition.youGetRule;
         showFrame();
      }
      
      override public function contractType() : int
      {
         return 1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromTradeContract_TradeRuleListEditorPreset_1 = null;
         UnknownVarFromTradeContract_TradeRuleEditorPreset_1 = null;
         super.dispose();
      }
   }
}

