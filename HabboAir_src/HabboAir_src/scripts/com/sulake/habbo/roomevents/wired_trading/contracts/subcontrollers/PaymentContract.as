package com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers
{
   import com.sulake.core.communication.util.Short;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractContentsMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRulesDefinition;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.TradeRuleListEditorPreset;
   import com.sulake.habbo.roomevents.wired_trading.contracts.WiredContractController;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.util.AbstractContract;
   
   public class PaymentContract extends AbstractContract
   {
      private static const LAYOUT_TYPES:Array = ["generic","games"];
      
      private var UnknownVarFromPaymentContract_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromPaymentContract_TextInputPreset_1:TextInputPreset;
      
      private var UnknownVarFromPaymentContract_TradeRuleListEditorPreset_1:TradeRuleListEditorPreset;
      
      private var UnknownVarFromPaymentContract_SectionPreset_1:SectionPreset;
      
      private var UnknownVarFromPaymentContract_DropdownPreset_1:DropdownPreset;
      
      public function PaymentContract(param1:WiredContractController, param2:PresetManager)
      {
         super(param1,param2);
         UnknownVarFromPaymentContract_RadioGroupPreset_1 = param2.createRadioGroup([new RadioButtonParam(0,"${wiredcontracts.payment_contract.mode.0}"),new RadioButtonParam(1,"${wiredcontracts.payment_contract.mode.1}")],onPaymentModeChange);
         var _loc4_:SectionPreset = param2.createSection("${wiredcontracts.payment_contract.mode}",UnknownVarFromPaymentContract_RadioGroupPreset_1);
         UnknownVarFromPaymentContract_TextInputPreset_1 = param2.createTextInput(new TextInputParam("",60));
         var _loc5_:SectionPreset = param2.createSection("${wiredcontracts.payment_contract.receive_text}",UnknownVarFromPaymentContract_TextInputPreset_1);
         UnknownVarFromPaymentContract_TradeRuleListEditorPreset_1 = param2.createRuleListEditorPreset(param1.addEditContractElement.onEdit,param1.addEditContractElement.onAdd);
         UnknownVarFromPaymentContract_SectionPreset_1 = param2.createSection("${wiredcontracts.payment_requirements}",UnknownVarFromPaymentContract_TradeRuleListEditorPreset_1);
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc3_.push(new ExpandableDropdownOption(0,"${wiredcontracts.payment_contract.layout_type.0}"));
         _loc3_.push(new ExpandableDropdownOption(1,"${wiredcontracts.payment_contract.layout_type.1}"));
         UnknownVarFromPaymentContract_DropdownPreset_1 = param2.createDropdown(new DropdownParam("${wiredcontracts.payment_contract.layout_type}",_loc3_));
         var _loc6_:SectionPreset = param2.createSection("${wiredcontracts.payment_contract.layout_type}",UnknownVarFromPaymentContract_DropdownPreset_1,SectionParam.COLLAPSED);
         framePreset = param2.createFramePreset([_loc4_,_loc5_,UnknownVarFromPaymentContract_SectionPreset_1,_loc6_,footerPreset],onCloseClicked);
         framePreset.resizeToWidth(262);
         framePreset.title = "${wiredcontracts.payment_contract.title}";
      }
      
      private function onPaymentModeChange(param1:int) : void
      {
         UnknownVarFromPaymentContract_SectionPreset_1.disabled = param1 != 1;
      }
      
      override protected function createNewDefinitionFromUI() : TradeRequirementRulesDefinition
      {
         return new TradeRequirementRulesDefinition(UnknownVarFromPaymentContract_TradeRuleListEditorPreset_1.finalizeRules(),null);
      }
      
      override public function show(param1:WiredContractContentsMessageParser) : void
      {
         if(param1.contractType != contractType() || param1.definition.youGiveRule == null)
         {
            return;
         }
         super.show(param1);
         UnknownVarFromPaymentContract_RadioGroupPreset_1.selected = param1.paymentMode;
         UnknownVarFromPaymentContract_TextInputPreset_1.text = param1.receiveText;
         UnknownVarFromPaymentContract_DropdownPreset_1.selectedId = LAYOUT_TYPES.indexOf(param1.layoutType);
         UnknownVarFromPaymentContract_TradeRuleListEditorPreset_1.rules = param1.definition.youGiveRule;
         onPaymentModeChange(param1.paymentMode);
         UnknownVarFromPaymentContract_SectionPreset_1.updateDisabledState();
         showFrame();
      }
      
      override public function addContentsToComposer(param1:Array) : void
      {
         super.addContentsToComposer(param1);
         param1.push(new Short(UnknownVarFromPaymentContract_RadioGroupPreset_1.selected));
         param1.push(UnknownVarFromPaymentContract_TextInputPreset_1.text);
         var _loc2_:int = UnknownVarFromPaymentContract_DropdownPreset_1.selectedId;
         if(_loc2_ < 0 || _loc2_ >= LAYOUT_TYPES.length)
         {
            _loc2_ = 0;
         }
         param1.push(LAYOUT_TYPES[_loc2_]);
      }
      
      override public function contractType() : int
      {
         return 0;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromPaymentContract_RadioGroupPreset_1 = null;
         UnknownVarFromPaymentContract_TextInputPreset_1 = null;
         UnknownVarFromPaymentContract_TradeRuleListEditorPreset_1 = null;
         super.dispose();
      }
   }
}

