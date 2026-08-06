package com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers
{
   import com.sulake.core.communication.util.Short;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractContentsMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRulesDefinition;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.TradeRuleEditorPreset;
   import com.sulake.habbo.roomevents.wired_trading.contracts.WiredContractController;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.util.AbstractContract;
   
   public class RewardContract extends AbstractContract
   {
      private var UnknownVarFromRewardContract_TradeRuleEditorPreset_1:TradeRuleEditorPreset;
      
      private var UnknownVarFromRewardContract_DropdownPreset_1:DropdownPreset;
      
      private var UnknownVarFromRewardContract_SectionPreset_1:SectionPreset;
      
      private var UnknownVarFromRewardContract_TextAreaPreset_1:TextAreaPreset;
      
      private var _showByDefault:CheckboxGroupPreset;
      
      public function RewardContract(param1:WiredContractController, param2:PresetManager)
      {
         super(param1,param2);
         UnknownVarFromRewardContract_TradeRuleEditorPreset_1 = param2.createRuleEditorPreset("${wiredcontracts.reward_rule}",param1.addEditContractElement.onEdit,param1.addEditContractElement.onAdd,null,onRulesChange);
         var _loc4_:SectionPreset = param2.createSection("${wiredcontracts.reward_requirements}",UnknownVarFromRewardContract_TradeRuleEditorPreset_1);
         UnknownVarFromRewardContract_TextAreaPreset_1 = param2.createTextArea(new TextAreaParam(52,-1,3,-1,200,"","${wiredcontracts.reward_contract.reward_popup.text.tooltip}"));
         _showByDefault = param2.createCheckboxGroup([new CheckboxOptionParam("${wiredcontracts.reward_contract.reward_popup.show_by_default}")]);
         var _loc5_:SimpleListViewPreset = param2.createSimpleListView(true,[UnknownVarFromRewardContract_TextAreaPreset_1,_showByDefault]);
         var _loc6_:SectionPreset = param2.createSection("${wiredcontracts.reward_contract.reward_popup}",_loc5_);
         var _loc3_:Vector.<ExpandableDropdownOption> = new <ExpandableDropdownOption>[new ExpandableDropdownOption(11,"${wiredfurni.params.earnings_category.11}"),new ExpandableDropdownOption(13,"${wiredfurni.params.earnings_category.13}")];
         UnknownVarFromRewardContract_DropdownPreset_1 = param2.createDropdown(new DropdownParam("${wiredcontracts.reward_contract.earnings_category}",_loc3_));
         UnknownVarFromRewardContract_SectionPreset_1 = param2.createSection("${wiredcontracts.reward_contract.earnings_category}",UnknownVarFromRewardContract_DropdownPreset_1,SectionParam.COLLAPSED);
         framePreset = param2.createFramePreset([_loc4_,_loc6_,UnknownVarFromRewardContract_SectionPreset_1,footerPreset],onCloseClicked);
         framePreset.resizeToWidth(262);
         framePreset.title = "${wiredcontracts.reward_contract.title}";
      }
      
      private function onRulesChange() : void
      {
         UnknownVarFromRewardContract_SectionPreset_1.disabled = !hasCreditNode();
      }
      
      private function hasCreditNode() : Boolean
      {
         var _loc2_:TradeRequirementRule = UnknownVarFromRewardContract_TradeRuleEditorPreset_1.finalizeRule();
         for each(var _loc1_ in _loc2_.nodes)
         {
            if(_loc1_.type == TradeRequirementNode.TYPE_COIN)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function createNewDefinitionFromUI() : TradeRequirementRulesDefinition
      {
         return new TradeRequirementRulesDefinition(null,UnknownVarFromRewardContract_TradeRuleEditorPreset_1.finalizeRule());
      }
      
      override public function show(param1:WiredContractContentsMessageParser) : void
      {
         if(param1.contractType != contractType() || param1.definition.youGetRule == null)
         {
            return;
         }
         super.show(param1);
         UnknownVarFromRewardContract_TradeRuleEditorPreset_1.rule = param1.definition.youGetRule;
         _showByDefault.get(0).selected = param1.showDialog;
         UnknownVarFromRewardContract_DropdownPreset_1.selectedId = param1.rewardCategory;
         UnknownVarFromRewardContract_TextAreaPreset_1.text = param1.rewardText;
         showFrame();
      }
      
      override public function addContentsToComposer(param1:Array) : void
      {
         super.addContentsToComposer(param1);
         param1.push(new Short(UnknownVarFromRewardContract_DropdownPreset_1.selectedId));
         param1.push(_showByDefault.get(0).selected);
         param1.push(UnknownVarFromRewardContract_TextAreaPreset_1.text);
      }
      
      override public function contractType() : int
      {
         return 2;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromRewardContract_TradeRuleEditorPreset_1 = null;
         super.dispose();
      }
   }
}

