package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingMixerItemRenderer extends FurniThumbnailRendererBase
   {
      private var _inventoryId:int;
      
      public function CraftingMixerItemRenderer(param1:CraftingFurnitureItem, param2:IWindowController_1, param3:CraftingWidget)
      {
         super(param1,param2,param3);
      }
      
      override protected function onTriggered() : void
      {
         if(!UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1 || UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.craftingInProgress || UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.inventoryDirty)
         {
            return;
         }
         if(_inventoryId == 0)
         {
            UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.setInfoState(9,furnitureData);
            return;
         }
         if(UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.inSecretRecipeMode)
         {
            UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.mixerCtrl.removeListItem(this);
         }
      }
      
      public function returnItemToInventory() : void
      {
         if(_inventoryId != 0)
         {
            _content.returnItemToInventory(_inventoryId);
         }
         this.dispose();
      }
      
      override public function updateItemCount() : void
      {
         updateBitmapBlend(_inventoryId != 0);
      }
      
      public function get inventoryId() : int
      {
         return _inventoryId;
      }
      
      public function set inventoryId(param1:int) : void
      {
         _inventoryId = param1;
         updateItemCount();
      }
   }
}

