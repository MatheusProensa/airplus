package com.sulake.habbo.roomevents.misc
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ItemTypeSelectionSection;
   import com.sulake.habbo.roomevents.wired_trading.AbstractUbuntuWiredUI;
   
   public class SelfDonationToolView extends AbstractUbuntuWiredUI
   {
      public static const MAX_AMOUNT:int = 500;
      
      private var UnknownVarFromSelfDonationToolView_SelfDonationTool_1:SelfDonationTool;
      
      private var UnknownVarFromSelfDonationToolView_NumberInputPreset_1:NumberInputPreset;
      
      private var UnknownVarFromSelfDonationToolView_ItemTypeSelectionSection_1:ItemTypeSelectionSection;
      
      public function SelfDonationToolView(param1:SelfDonationTool, param2:PresetManager)
      {
         super(param1.roomEvents,param2);
         UnknownVarFromSelfDonationToolView_SelfDonationTool_1 = param1;
         UnknownVarFromSelfDonationToolView_NumberInputPreset_1 = param2.createNumberInput(new NumberInputParam(1,1,500,80));
         var _loc3_:SectionPreset = param2.createSection(localization.getLocalization("selfdonation.amount","Amount"),UnknownVarFromSelfDonationToolView_NumberInputPreset_1);
         UnknownVarFromSelfDonationToolView_ItemTypeSelectionSection_1 = param2.createItemTypeSelectionSection();
         footerPreset.saveButtonCaption = localization.getLocalization("selfdonation.donate","Donate");
         footerPreset.splitterVisible = true;
         var _loc4_:SimpleListViewPreset = param2.createSimpleListView(true,[_loc3_,UnknownVarFromSelfDonationToolView_ItemTypeSelectionSection_1,footerPreset]);
         framePreset = param2.createFramePreset([_loc4_],onCloseClicked);
         framePreset.resizeToWidth(420);
         framePreset.title = localization.getLocalization("selfdonation.title","Sandbox donation tool");
      }
      
      override protected function get isBoundToParentRect() : Boolean
      {
         return true;
      }
      
      public function showTool() : void
      {
         UnknownVarFromSelfDonationToolView_NumberInputPreset_1.value = 1;
         UnknownVarFromSelfDonationToolView_ItemTypeSelectionSection_1.resetInteractions();
         showFrame();
      }
      
      override public function onSaveClicked() : void
      {
         UnknownVarFromSelfDonationToolView_SelfDonationTool_1.onDonate(UnknownVarFromSelfDonationToolView_ItemTypeSelectionSection_1.selectedItem,UnknownVarFromSelfDonationToolView_NumberInputPreset_1.value);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromSelfDonationToolView_SelfDonationTool_1 = null;
         UnknownVarFromSelfDonationToolView_NumberInputPreset_1 = null;
         UnknownVarFromSelfDonationToolView_ItemTypeSelectionSection_1 = null;
         super.dispose();
      }
   }
}

