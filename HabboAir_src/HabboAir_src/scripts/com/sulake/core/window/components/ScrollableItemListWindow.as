package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class ScrollableItemListWindow extends WindowController implements IScrollableWindow, IScrollableListWindow
   {
      private var UnknownVarFromScrollableItemListWindow_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1:IScrollbarWindow;
      
      private var _autoHideScrollBar:Boolean = true;
      
      public function ScrollableItemListWindow(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         _scrollBar.scrollable = _itemList;
         if(_scrollBar.testStateFlag(32) && _autoHideScrollBar)
         {
            hideScrollBar();
         }
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1)
         {
            UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1.removeEventListener("WE_ENABLED",scrollBarEventProc);
            UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1.removeEventListener("WE_DISABLED",scrollBarEventProc);
            UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1 = null;
         }
         if(UnknownVarFromScrollableItemListWindow_IItemListWindow_1)
         {
            UnknownVarFromScrollableItemListWindow_IItemListWindow_1 = null;
         }
         super.dispose();
      }
      
      protected function get _itemList() : IItemListWindow
      {
         if(!UnknownVarFromScrollableItemListWindow_IItemListWindow_1)
         {
            UnknownVarFromScrollableItemListWindow_IItemListWindow_1 = findChildByTag("_ITEMLIST") as IItemListWindow;
         }
         return UnknownVarFromScrollableItemListWindow_IItemListWindow_1;
      }
      
      public function scrollWithWheel(param1:Number, param2:Boolean) : Boolean
      {
         return _itemList.scrollWithWheel(param1,param2);
      }
      
      public function get scrollableWindow() : IWindowModel
      {
         return _itemList;
      }
      
      protected function get _scrollBar() : IScrollbarWindow
      {
         if(!UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1)
         {
            UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1 = findChildByTag("_SCROLLBAR") as IScrollbarWindow;
            if(UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1)
            {
               UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1.addEventListener("WE_ENABLED",scrollBarEventProc);
               UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1.addEventListener("WE_DISABLED",scrollBarEventProc);
            }
         }
         return UnknownVarFromScrollableItemListWindow_IScrollbarWindow_1;
      }
      
      private function scrollBarEventProc(param1:WindowEvent) : void
      {
         if(param1.type == "WE_ENABLED")
         {
            showScrollBar();
         }
         else if(param1.type == "WE_DISABLED" && _autoHideScrollBar)
         {
            hideScrollBar();
         }
      }
      
      private function hideScrollBar() : void
      {
         if(_scrollBar.visible)
         {
            _scrollBar.visible = false;
            _itemList.width = _width;
         }
      }
      
      private function showScrollBar() : void
      {
         if(!_scrollBar.visible)
         {
            _scrollBar.visible = true;
            _itemList.width = _width - _scrollBar.width;
         }
      }
      
      private function updateScrollBarVisibility(param1:Boolean = false) : void
      {
         if(_autoHideScrollBar)
         {
            if(_scrollBar.testStateFlag(32))
            {
               if(_scrollBar.visible)
               {
                  hideScrollBar();
               }
            }
         }
         else if(param1 || Boolean(_scrollBar.visible))
         {
            showScrollBar();
         }
      }
      
      public function get isScrollBarVisible() : Boolean
      {
         return _scrollBar.visible;
      }
      
      protected function isConstructionReady() : Boolean
      {
         return _itemList && _scrollBar;
      }
      
      public function set autoHideScrollBar(param1:Boolean) : void
      {
         _autoHideScrollBar = param1;
         updateScrollBarVisibility(true);
      }
      
      public function get autoHideScrollBar() : Boolean
      {
         return _autoHideScrollBar;
      }
      
      public function get iterator() : IIterator
      {
         return isConstructionReady() ? _itemList.iterator : null;
      }
      
      public function get scrollH() : Number
      {
         return _itemList.scrollH;
      }
      
      public function get scrollV() : Number
      {
         return _itemList.scrollV;
      }
      
      public function set scrollH(param1:Number) : void
      {
         _itemList.scrollH = param1;
      }
      
      public function set scrollV(param1:Number) : void
      {
         _itemList.scrollV = param1;
      }
      
      public function get maxScrollH() : int
      {
         return _itemList.maxScrollH;
      }
      
      public function get maxScrollV() : int
      {
         return _itemList.maxScrollV;
      }
      
      public function get visibleRegion() : Rectangle
      {
         return _itemList.visibleRegion;
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return _itemList.scrollableRegion;
      }
      
      public function get spacing() : int
      {
         return _itemList.spacing;
      }
      
      public function set spacing(param1:int) : void
      {
         _itemList.spacing = param1;
      }
      
      public function get scaleToFitItems() : Boolean
      {
         return _itemList.scaleToFitItems;
      }
      
      public function set scaleToFitItems(param1:Boolean) : void
      {
         _itemList.scaleToFitItems = param1;
      }
      
      public function get autoArrangeItems() : Boolean
      {
         return _itemList.autoArrangeItems;
      }
      
      public function set autoArrangeItems(param1:Boolean) : void
      {
         _itemList.autoArrangeItems = param1;
      }
      
      public function set resizeOnItemUpdate(param1:Boolean) : void
      {
         _itemList.resizeOnItemUpdate = param1;
      }
      
      public function get resizeOnItemUpdate() : Boolean
      {
         return _itemList.resizeOnItemUpdate;
      }
      
      public function get numListItems() : int
      {
         return _itemList.numListItems;
      }
      
      public function addListItem(param1:IWindowModel) : IWindowModel
      {
         return _itemList.addListItem(param1);
      }
      
      public function addListItemAt(param1:IWindowModel, param2:uint) : IWindowModel
      {
         return _itemList.addListItemAt(param1,param2);
      }
      
      public function getListItemAt(param1:uint) : IWindowModel
      {
         return _itemList.getListItemAt(param1);
      }
      
      public function getListItemByID(param1:uint) : IWindowModel
      {
         return _itemList.getListItemByID(param1);
      }
      
      public function getListItemByName(param1:String) : IWindowModel
      {
         return _itemList.getListItemByName(param1);
      }
      
      public function getListItemByTag(param1:String) : IWindowModel
      {
         return _itemList.getListItemByTag(param1);
      }
      
      public function getListItemIndex(param1:IWindowModel) : int
      {
         return _itemList.getListItemIndex(param1);
      }
      
      public function removeListItem(param1:IWindowModel) : IWindowModel
      {
         return _itemList.removeListItem(param1);
      }
      
      public function removeListItemAt(param1:int) : IWindowModel
      {
         return _itemList.removeListItemAt(param1);
      }
      
      public function setListItemIndex(param1:IWindowModel, param2:int) : void
      {
         _itemList.setListItemIndex(param1,param2);
      }
      
      public function swapListItems(param1:IWindowModel, param2:IWindowModel) : void
      {
         _itemList.swapListItems(param1,param2);
      }
      
      public function swapListItemsAt(param1:int, param2:int) : void
      {
         _itemList.swapListItemsAt(param1,param2);
      }
      
      public function groupListItemsWithID(param1:uint, param2:Array, param3:int = 0) : uint
      {
         return _itemList.groupListItemsWithID(param1,param2,param3);
      }
      
      public function groupListItemsWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         return _itemList.groupListItemsWithTag(param1,param2,param3);
      }
      
      public function removeListItems() : void
      {
         _itemList.removeListItems();
      }
      
      public function destroyListItems() : void
      {
         _itemList.destroyListItems();
      }
      
      public function arrangeListItems() : void
      {
         _itemList.arrangeListItems();
      }
      
      public function get isPartOfGridWindow() : Boolean
      {
         return _itemList.isPartOfGridWindow;
      }
      
      public function set isPartOfGridWindow(param1:Boolean) : void
      {
         _itemList.isPartOfGridWindow = param1;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",spacing));
         _loc1_.push(createProperty("auto_arrange_items",autoArrangeItems));
         _loc1_.push(createProperty("scale_to_fit_items",scaleToFitItems));
         _loc1_.push(createProperty("resize_on_item_update",resizeOnItemUpdate));
         _loc1_.push(createProperty("inverse_resize_on_item_update",inverseResizeOnItemUpdate));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  spacing = _loc2_.value as int;
                  break;
               case "scale_to_fit_items":
                  scaleToFitItems = _loc2_.value as Boolean;
                  break;
               case "resize_on_item_update":
                  resizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case "inverse_resize_on_item_update":
                  inverseResizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case "auto_arrange_items":
                  autoArrangeItems = _loc2_.value as Boolean;
                  break;
            }
         }
         super.properties = param1;
      }
      
      public function get inverseResizeOnItemUpdate() : Boolean
      {
         return _itemList.inverseResizeOnItemUpdate;
      }
      
      public function set inverseResizeOnItemUpdate(param1:Boolean) : void
      {
         _itemList.inverseResizeOnItemUpdate = param1;
      }
   }
}

