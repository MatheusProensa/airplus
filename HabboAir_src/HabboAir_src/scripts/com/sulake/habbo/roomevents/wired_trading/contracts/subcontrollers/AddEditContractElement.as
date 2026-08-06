package com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.HorizontalSectionListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.TradeRuleEditorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ItemTypeSelectionSection;
   import com.sulake.habbo.roomevents.wired_trading.AbstractUbuntuWiredUI;
   import com.sulake.habbo.roomevents.wired_trading.contracts.WiredContractController;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class AddEditContractElement extends AbstractUbuntuWiredUI
   {
      public static const MAX_COINS:int = 100000;
      
      public static const MAX_FURNI:int = 500;
      
      private var UnknownVarFromAddEditContractElement_WiredContractController_1:WiredContractController;
      
      private var UnknownVarFromAddEditContractElement_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromAddEditContractElement_NumberInputPreset_1:NumberInputPreset;
      
      private var UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1:ItemTypeSelectionSection;
      
      private var _isEditMode:Boolean = false;
      
      private var UnknownVarFromAddEditContractElement_TradeRuleEditorPreset_1:TradeRuleEditorPreset;
      
      private var UnknownVarFromAddEditContractElement_Int_1:int = -1;
      
      public function AddEditContractElement(param1:WiredContractController, param2:PresetManager)
      {
         super(param1.roomEvents,param2);
         UnknownVarFromAddEditContractElement_WiredContractController_1 = param1;
         UnknownVarFromAddEditContractElement_RadioGroupPreset_1 = param2.createRadioGroup([new RadioButtonParam(0,"${wiredcontracts.element.type.0}"),new RadioButtonParam(1,"${wiredcontracts.element.type.1}")],onElementTypeChange);
         var _loc4_:SectionPreset = param2.createSection("${wiredcontracts.element.type}",UnknownVarFromAddEditContractElement_RadioGroupPreset_1);
         UnknownVarFromAddEditContractElement_NumberInputPreset_1 = param2.createNumberInput(new NumberInputParam(1,1,100000,80));
         var _loc5_:SectionPreset = param2.createSection("${wiredcontracts.element.amount}",UnknownVarFromAddEditContractElement_NumberInputPreset_1);
         var _loc3_:HorizontalSectionListPreset = param2.createHorizontalSectionListPreset([_loc4_,_loc5_]);
         UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1 = param2.createItemTypeSelectionSection();
         framePreset = param2.createFramePreset([_loc3_,UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1,footerPreset],onCloseClicked);
         framePreset.resizeToWidth(420);
      }
      
      override protected function get isRememberLocation() : Boolean
      {
         return true;
      }
      
      override protected function get isBoundToParentRect() : Boolean
      {
         return true;
      }
      
      override public function get xOffsetFromCenter() : int
      {
         return 375;
      }
      
      private function onElementTypeChange(param1:int) : void
      {
         UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1.disabled = param1 != TradeRequirementNode.TYPE_FURNI;
      }
      
      public function set isEditMode(param1:Boolean) : void
      {
         _isEditMode = param1;
         framePreset.title = _isEditMode ? "${wiredcontracts.edit_element.title}" : "${wiredcontracts.add_element.title}";
      }
      
      public function onEdit(param1:TradeRuleEditorPreset, param2:int, param3:TradeRequirementNode) : void
      {
         isEditMode = true;
         UnknownVarFromAddEditContractElement_TradeRuleEditorPreset_1 = param1;
         UnknownVarFromAddEditContractElement_Int_1 = param2;
         footerPreset.saveButtonDisabled = !roomEvents.wiredMenu.hasWritePermission;
         UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1.resetInteractions();
         UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1.selectedItem = param3.itemType;
         UnknownVarFromAddEditContractElement_RadioGroupPreset_1.selected = param3.type;
         UnknownVarFromAddEditContractElement_NumberInputPreset_1.value = param3.amount;
         onElementTypeChange(param3.type);
         showFrame();
      }
      
      public function onAdd(param1:TradeRuleEditorPreset) : void
      {
         isEditMode = false;
         UnknownVarFromAddEditContractElement_TradeRuleEditorPreset_1 = param1;
         UnknownVarFromAddEditContractElement_Int_1 = -1;
         footerPreset.saveButtonDisabled = !roomEvents.wiredMenu.hasWritePermission;
         UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1.resetInteractions();
         UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1.selectedItem = null;
         UnknownVarFromAddEditContractElement_RadioGroupPreset_1.selected = TradeRequirementNode.TYPE_COIN;
         UnknownVarFromAddEditContractElement_NumberInputPreset_1.value = 1;
         onElementTypeChange(TradeRequirementNode.TYPE_COIN);
         showFrame();
      }
      
      private function createNode() : TradeRequirementNode
      {
         return new TradeRequirementNode(UnknownVarFromAddEditContractElement_RadioGroupPreset_1.selected,UnknownVarFromAddEditContractElement_NumberInputPreset_1.value,UnknownVarFromAddEditContractElement_RadioGroupPreset_1.selected == TradeRequirementNode.TYPE_FURNI ? UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1.selectedItem : null);
      }
      
      override public function onSaveClicked() : void
      {
         var _loc1_:String = validate();
         if(_loc1_ != null)
         {
            roomEvents.windowManager.alert("${wiredfurni.error.title}",_loc1_,0,null);
            return;
         }
         if(_isEditMode)
         {
            UnknownVarFromAddEditContractElement_TradeRuleEditorPreset_1.updateNode(UnknownVarFromAddEditContractElement_Int_1,createNode());
         }
         else
         {
            UnknownVarFromAddEditContractElement_TradeRuleEditorPreset_1.addNode(createNode());
         }
         UnknownVarFromAddEditContractElement_TradeRuleEditorPreset_1 = null;
         UnknownVarFromAddEditContractElement_Int_1 = -1;
         hideFrame();
      }
      
      private function validate() : String
      {
         var _loc1_:IFurnitureData = null;
         if(UnknownVarFromAddEditContractElement_RadioGroupPreset_1.selected == TradeRequirementNode.TYPE_FURNI && UnknownVarFromAddEditContractElement_NumberInputPreset_1.value > 500)
         {
            return localization.getLocalizationWithParams("wiredcontracts.element.too_many_items","","amount",500);
         }
         if(UnknownVarFromAddEditContractElement_RadioGroupPreset_1.selected == TradeRequirementNode.TYPE_FURNI)
         {
            _loc1_ = UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1.furniDataForSelectedItem;
            if(_loc1_ == null || !_loc1_.tradeable)
            {
               return "${wiredcontracts.element.item_not_allowed}";
            }
         }
         return null;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromAddEditContractElement_RadioGroupPreset_1 = null;
         UnknownVarFromAddEditContractElement_NumberInputPreset_1 = null;
         UnknownVarFromAddEditContractElement_ItemTypeSelectionSection_1 = null;
         UnknownVarFromAddEditContractElement_TradeRuleEditorPreset_1 = null;
         UnknownVarFromAddEditContractElement_WiredContractController_1 = null;
         super.dispose();
      }
   }
}

