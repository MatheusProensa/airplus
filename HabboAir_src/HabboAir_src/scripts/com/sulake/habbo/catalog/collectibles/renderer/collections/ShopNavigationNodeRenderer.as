package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.tabs.ShopTab;
   
   public class ShopNavigationNodeRenderer implements IComponentInterfaceQueue
   {
      private var UnknownVarFromShopNavigationNodeRenderer_ShopTab_1:ShopTab;
      
      private var _category:String;
      
      private var _window:IWindowController_1;
      
      private var _active:Boolean;
      
      private var _itemNormalColor:uint;
      
      private var _itemSelectedEtchingColor:uint;
      
      private var UnknownVarFromShopNavigationNodeRenderer_Boolean_1:Boolean = false;
      
      public function ShopNavigationNodeRenderer(param1:ShopTab, param2:String)
      {
         super();
         UnknownVarFromShopNavigationNodeRenderer_ShopTab_1 = param1;
         _category = param2;
         createWindow();
      }
      
      private function createWindow() : void
      {
         _window = UnknownVarFromShopNavigationNodeRenderer_ShopTab_1.navigationItemTemplate.clone() as IWindowController_1;
         var _loc1_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.caption = _category;
            _itemNormalColor = _loc1_.textColor;
            _itemSelectedEtchingColor = _loc1_.etchingColor;
         }
         var _loc2_:IWindowModel = _window.findChildByTag("SELECTION_HILIGHT");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
         _window.addEventListener("WME_CLICK",onButtonClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function activate() : void
      {
         _active = true;
         updateLook();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateLook();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromShopNavigationNodeRenderer_Boolean_1 = false;
         updateLook();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromShopNavigationNodeRenderer_Boolean_1 = true;
         updateLook();
      }
      
      private function updateLook() : void
      {
         if(_active || UnknownVarFromShopNavigationNodeRenderer_Boolean_1)
         {
            setActiveLook();
         }
         else
         {
            setInactiveLook();
         }
      }
      
      private function setInactiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:IWindowModel = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = _itemNormalColor;
               _loc1_.etchingColor = 0;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
      }
      
      private function setActiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:IWindowController_1 = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = 4294967295;
               _loc1_.etchingColor = _itemSelectedEtchingColor;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT") as IWindowController_1;
            if(_loc2_ != null)
            {
               _loc2_.visible = true;
            }
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromShopNavigationNodeRenderer_ShopTab_1.activateCategory(this);
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get category() : String
      {
         return _category;
      }
   }
}

