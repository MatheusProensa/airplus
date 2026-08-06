package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   
   public class CatalogNodeRenderable extends CatalogNode
   {
      private static const ITEM_SELECTION_COLOR:Number = 4294967295;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromCatalogNodeRenderable_IItemListWindow_1:IItemListWindow;
      
      private var _isOpen:Boolean = false;
      
      private var _active:Boolean;
      
      private var _itemNormalColor:uint;
      
      private var _itemSelectedEtchingColor:uint;
      
      private var _renderDepth:int = -1;
      
      public function CatalogNodeRenderable(param1:ICatalogNavigator, param2:NodeData, param3:int, param4:ICatalogNode)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      override public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      override public function get visible() : Boolean
      {
         return true;
      }
      
      override public function dispose() : void
      {
         if(_isOpen)
         {
            close();
            deactivate();
         }
         _window = null;
         UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 = null;
         super.dispose();
      }
      
      public function addToList(param1:IItemListWindow, param2:Boolean = true) : void
      {
         if(_window == null || _renderDepth != depth)
         {
            createWindow(depth);
            setInactiveLook();
         }
         param1.addListItem(_window);
         if(isBranch)
         {
            if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 == null)
            {
               createChildList();
            }
            param1.addListItem(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1);
            refreshChildren();
         }
         param1.arrangeListItems();
      }
      
      public function addSearchResultToList(param1:IItemListWindow, param2:int) : void
      {
         if(_window == null || _renderDepth != param2)
         {
            createWindow(param2);
            setInactiveLook();
         }
         param1.addListItem(_window);
         param1.arrangeListItems();
      }
      
      public function removeFromList(param1:IItemListWindow) : void
      {
         param1.removeListItem(_window);
         if(isBranch)
         {
            param1.removeListItem(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1);
         }
      }
      
      override public function activate() : void
      {
         setActiveLook();
         _active = true;
      }
      
      override public function deactivate() : void
      {
         setInactiveLook();
         _active = false;
      }
      
      override public function open() : void
      {
         var _loc1_:IWindowModel = null;
         showChildren();
         _isOpen = true;
         if(isBranch && _window != null)
         {
            _loc1_ = _window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = 7;
            }
         }
      }
      
      override public function close() : void
      {
         var _loc1_:IWindowModel = null;
         removeChildren();
         _isOpen = false;
         if(isBranch && _window != null)
         {
            _loc1_ = _window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = 5;
            }
         }
      }
      
      private function refreshChildren() : void
      {
         var _loc1_:CatalogNodeRenderable = null;
         if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 == null)
         {
            return;
         }
         UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.removeListItems();
         for each(var _loc2_ in children)
         {
            _loc1_ = _loc2_ as CatalogNodeRenderable;
            if(_loc1_ != null)
            {
               if(_loc1_.visible)
               {
                  _loc1_.addToList(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1);
                  _loc1_.setInactiveLook();
               }
            }
         }
         UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.arrangeListItems();
      }
      
      private function showChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 == null)
         {
            createChildList();
         }
         refreshChildren();
         if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 != null)
         {
            UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.visible = true;
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.numListItems)
            {
               if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.getListItemAt(_loc2_).visible)
               {
                  _loc1_++;
               }
               _loc2_++;
            }
            UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.height = _loc1_ * 21;
         }
      }
      
      private function removeChildren() : void
      {
         if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 != null)
         {
            UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.removeListItems();
            UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.height = 0;
            UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.visible = false;
            UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.x = 0;
         }
      }
      
      private function createChildList() : void
      {
         UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 = navigator.listTemplate.clone() as IItemListWindow;
         removeChildren();
      }
      
      private function createWindow(param1:int) : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _renderDepth = param1;
         _window = navigator.getItemTemplate(param1).clone() as IWindowController_1;
         var _loc3_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         var _loc2_:IWindowModel = _window.findChildByTag("DOWNBTN");
         if(_loc3_ != null)
         {
            _loc3_.caption = localization;
            _itemNormalColor = _loc3_.textColor;
            _itemSelectedEtchingColor = _loc3_.etchingColor;
         }
         var _loc4_:IWindowModel = _window.findChildByTag("SELECTION_HILIGHT");
         if(_loc4_)
         {
            _loc4_.visible = false;
         }
         if(_loc2_ != null)
         {
            _loc2_.visible = !isLeaf;
         }
         IStaticBitmapWrapperWindow(_window.findChildByName("icon")).assetUri = navigator.catalog.imageGalleryHost + iconName + ".png";
         if(navigator.isDeepHierarchy)
         {
            if(param1 == 1)
            {
               _window.findChildByName("icon").visible = false;
               _window.findChildByTag("ITEM_TITLE").x = 0;
            }
            if(param1 > 3)
            {
               _window.findChildByName("icon").visible = true;
               _window.findChildByName("icon").x = 15 + 6 * (param1 - 3);
               _window.findChildByTag("ITEM_TITLE").x = 42 + 6 * (param1 - 3);
            }
         }
         _window.addEventListener("WME_CLICK",onButtonClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onButtonClicked);
         }
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         if(!_active)
         {
            setInactiveLook();
         }
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         if(!_active)
         {
            setActiveLook();
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
         navigator.activateNode(this);
      }
      
      public function updateChildListHeight() : void
      {
         var _loc2_:int = 0;
         if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 == null)
         {
            return;
         }
         UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.height = 0;
         if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.numListItems)
            {
               if(UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.getListItemAt(_loc2_).visible)
               {
                  UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.height += UnknownVarFromCatalogNodeRenderable_IItemListWindow_1.getListItemAt(_loc2_).height;
               }
               _loc2_++;
            }
         }
         var _loc1_:CatalogNodeRenderable = parent as CatalogNodeRenderable;
         if(_loc1_)
         {
            _loc1_.updateChildListHeight();
         }
      }
      
      override public function get offsetV() : int
      {
         return _window.y + 21;
      }
   }
}

