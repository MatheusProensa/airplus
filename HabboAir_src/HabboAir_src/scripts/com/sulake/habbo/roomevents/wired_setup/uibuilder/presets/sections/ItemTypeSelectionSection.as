package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.ChestItemIconPreviewerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.ItemTypeSelectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class ItemTypeSelectionSection extends AbstractSectionPreset
   {
      private var UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1:ItemTypeSelectionPreset;
      
      private var UnknownVarFromItemTypeSelectionSection_ChestItemIconPreviewerPreset_1:ChestItemIconPreviewerPreset;
      
      public function ItemTypeSelectionSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1 = param2.createItemTypeSelectionPreset();
         UnknownVarFromItemTypeSelectionSection_ChestItemIconPreviewerPreset_1 = param2.createChestItemIconPreviewerPreset();
         var _loc4_:SectionParam = new SectionParam();
         _loc4_.addHeaderOption(UnknownVarFromItemTypeSelectionSection_ChestItemIconPreviewerPreset_1.floatVertically());
         initializeSection("${wiredcontracts.element.itemtype.selection}",UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1,_loc4_);
         UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1.addListener(onChangeItemType);
      }
      
      private function onChangeItemType(param1:ChestItemType) : void
      {
         UnknownVarFromItemTypeSelectionSection_ChestItemIconPreviewerPreset_1.item = param1;
      }
      
      public function get selectedItem() : ChestItemType
      {
         return UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1.selectedItem;
      }
      
      public function get furniDataForSelectedItem() : IFurnitureData
      {
         return UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1.furniDataForSelectedItem;
      }
      
      public function resetInteractions() : void
      {
         return UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1.resetInteractions();
      }
      
      public function set selectedItem(param1:ChestItemType) : void
      {
         UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1.selectedItem = param1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromItemTypeSelectionSection_ItemTypeSelectionPreset_1 = null;
         UnknownVarFromItemTypeSelectionSection_ChestItemIconPreviewerPreset_1 = null;
      }
   }
}

