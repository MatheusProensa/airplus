package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingInventoryItemRenderer extends FurniThumbnailRendererBase
   {
      public function CraftingInventoryItemRenderer(param1:CraftingFurnitureItem, param2:IWindowController_1, param3:CraftingWidget)
      {
         super(param1,param2,param3);
      }
      
      override protected function onTriggered() : void
      {
         if(!UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1 || UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.craftingInProgress || UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.inventoryDirty)
         {
            return;
         }
         if(!UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.mixerCtrl.canAdd())
         {
            return;
         }
         var _loc1_:int = content.getItemToMixer();
         if(_loc1_ == 0)
         {
            return;
         }
         UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.showSecretRecipeView();
         UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.mixerCtrl.addItemToMixer(content,_loc1_);
         UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.inventoryCtrl.updateItemCounts();
      }
      
      override public function updateItemCount() : void
      {
         if(content)
         {
            updateGroupItemCount(content.countInInventory);
            updateBitmapBlend(content.countInInventory > 0);
         }
      }
   }
}

