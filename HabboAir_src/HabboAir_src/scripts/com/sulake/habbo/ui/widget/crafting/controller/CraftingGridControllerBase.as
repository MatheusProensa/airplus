package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   
   public class CraftingGridControllerBase
   {
      protected var UnknownVarFromCraftingGridControllerBase_CraftingWidget_1:CraftingWidget;
      
      public function CraftingGridControllerBase(param1:CraftingWidget)
      {
         super();
         UnknownVarFromCraftingGridControllerBase_CraftingWidget_1 = param1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromCraftingGridControllerBase_CraftingWidget_1 = null;
      }
      
      public function get mainWindow() : IWindowController_1
      {
         return UnknownVarFromCraftingGridControllerBase_CraftingWidget_1.window;
      }
      
      public function getItemTemplate() : IWindowController_1
      {
         return UnknownVarFromCraftingGridControllerBase_CraftingWidget_1.itemTemplate;
      }
   }
}

