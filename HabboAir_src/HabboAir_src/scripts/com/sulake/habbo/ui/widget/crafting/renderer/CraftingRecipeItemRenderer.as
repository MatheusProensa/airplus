package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingRecipeItemRenderer extends FurniThumbnailRendererBase
   {
      public function CraftingRecipeItemRenderer(param1:CraftingFurnitureItem, param2:IWindowController_1, param3:CraftingWidget)
      {
         super(param1,param2,param3);
         hideItemCount();
      }
      
      override protected function onTriggered() : void
      {
         if(!UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1 || !content || UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.craftingInProgress)
         {
            return;
         }
         UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.showCraftableProduct(content);
      }
   }
}

