package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.badges.*;
   
   public class CollectiblesGridView
   {
      private var UnknownVarFromCollectiblesGridView_CollectiblesView_1:CollectiblesView;
      
      private var UnknownVarFromCollectiblesGridView_IItemGridWindow_1:IItemGridWindow;
      
      private var _items:Vector.<CollectibleGroupedItem>;
      
      private var _passedItems:Vector.<CollectibleGroupedItem>;
      
      private var _pages:IItemListWindow;
      
      private var UnknownVarFromCollectiblesGridView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromCollectiblesGridView_Int_1:int = 200;
      
      private var UnknownVarFromCollectiblesGridView_Int_2:int = -1;
      
      private var _currentPageItems:Vector.<CollectibleGroupedItem>;
      
      private var UnknownVarFromCollectiblesGridView_String_1:String = "";
      
      private var UnknownVarFromCollectiblesGridView_Int_3:int = -1;
      
      public function CollectiblesGridView(param1:CollectiblesView, param2:IItemGridWindow, param3:IItemListWindow)
      {
         super();
         UnknownVarFromCollectiblesGridView_CollectiblesView_1 = param1;
         UnknownVarFromCollectiblesGridView_IItemGridWindow_1 = param2;
         UnknownVarFromCollectiblesGridView_IItemGridWindow_1.shouldRebuildGridOnResize = false;
         _items = new Vector.<CollectibleGroupedItem>(0);
         _passedItems = new Vector.<CollectibleGroupedItem>(0);
         _pages = param3;
         if(_pages)
         {
            UnknownVarFromCollectiblesGridView_IRegionWindow_1 = _pages.removeListItemAt(0) as IRegionWindow;
         }
      }
      
      public function get visibleCount() : int
      {
         return UnknownVarFromCollectiblesGridView_IItemGridWindow_1.numGridItems;
      }
      
      public function get currentPageItems() : Vector.<CollectibleGroupedItem>
      {
         return _currentPageItems;
      }
      
      private function get pageCount() : int
      {
         return _passedItems.length / UnknownVarFromCollectiblesGridView_Int_1 + 1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromCollectiblesGridView_IItemGridWindow_1 = null;
         _items = null;
      }
      
      public function clearGrid() : void
      {
         if(UnknownVarFromCollectiblesGridView_IItemGridWindow_1 != null)
         {
            UnknownVarFromCollectiblesGridView_IItemGridWindow_1.removeGridItems();
         }
         UnknownVarFromCollectiblesGridView_IItemGridWindow_1.destroyGridItems();
      }
      
      public function setFilter(param1:int, param2:String) : void
      {
         UnknownVarFromCollectiblesGridView_String_1 = param2 == null ? "" : param2.toLowerCase();
         UnknownVarFromCollectiblesGridView_Int_3 = param1;
         update();
      }
      
      public function itemWasUpdated(param1:CollectibleGroupedItem) : void
      {
         if(passFilter(param1))
         {
            update();
         }
      }
      
      public function getFirstThumb() : IWindowController_1
      {
         if(UnknownVarFromCollectiblesGridView_IItemGridWindow_1.numGridItems == 0)
         {
            return null;
         }
         return UnknownVarFromCollectiblesGridView_IItemGridWindow_1.getGridItemAt(0) as IWindowController_1;
      }
      
      public function setItems(param1:Vector.<CollectibleGroupedItem>) : void
      {
         _items = param1;
         update();
      }
      
      private function update() : void
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:Vector.<CollectibleGroupedItem> = new Vector.<CollectibleGroupedItem>(0);
         for each(_loc2_ in _items)
         {
            if(passFilter(_loc2_))
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length == _passedItems.length)
         {
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               if(_loc1_[_loc4_] != _passedItems[_loc4_])
               {
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               return;
            }
         }
         _passedItems = _loc1_;
         changeToPage(UnknownVarFromCollectiblesGridView_Int_2,true);
         updatePaging();
      }
      
      private function changeToPage(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:* = 0;
         if(param1 > -1)
         {
            if(UnknownVarFromCollectiblesGridView_Int_2 == param1 && !param2)
            {
               return;
            }
         }
         else
         {
            param1 = 0;
         }
         UnknownVarFromCollectiblesGridView_Int_2 = param1;
         if(UnknownVarFromCollectiblesGridView_Int_2 >= pageCount)
         {
            UnknownVarFromCollectiblesGridView_Int_2 = pageCount - 1;
         }
         UnknownVarFromCollectiblesGridView_Int_2 = Math.max(UnknownVarFromCollectiblesGridView_Int_2,0);
         _currentPageItems = new Vector.<CollectibleGroupedItem>(0);
         clearGrid();
         var _loc3_:int = UnknownVarFromCollectiblesGridView_Int_2 * UnknownVarFromCollectiblesGridView_Int_1;
         var _loc4_:int = _loc3_ + UnknownVarFromCollectiblesGridView_Int_1;
         _loc4_ = Math.min(_loc4_,_passedItems.length);
         _loc5_ = _loc3_;
         while(_loc5_ < _loc4_)
         {
            UnknownVarFromCollectiblesGridView_IItemGridWindow_1.addGridItem(_passedItems[_loc5_].window);
            _currentPageItems.push(_passedItems[_loc5_]);
            _loc5_++;
         }
      }
      
      private function updatePaging() : void
      {
         var _loc4_:IRegionWindow = null;
         var _loc3_:int = 0;
         var _loc2_:ITextWindow = null;
         if(!_pages)
         {
            return;
         }
         var _loc1_:int = pageCount;
         _pages.visible = _loc1_ > 1;
         if(UnknownVarFromCollectiblesGridView_Int_2 >= _loc1_)
         {
            UnknownVarFromCollectiblesGridView_Int_2 = _loc1_ - 1;
         }
         UnknownVarFromCollectiblesGridView_Int_2 = Math.max(UnknownVarFromCollectiblesGridView_Int_2,0);
         if(pageCount != _pages.numListItems)
         {
            for each(_loc4_ in _pages)
            {
               _loc4_.removeEventListener("WME_CLICK",onPageEventProc);
            }
            _pages.destroyListItems();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc4_ = UnknownVarFromCollectiblesGridView_IRegionWindow_1.clone() as IRegionWindow;
               _loc4_.addEventListener("WME_CLICK",onPageEventProc);
               _loc4_.addEventListener("WME_OVER",onPageEventProc);
               _loc4_.addEventListener("WME_OUT",onPageEventProc);
               _loc4_.id = _loc3_;
               _loc4_.name = "page_" + _loc3_;
               _pages.addListItem(_loc4_);
               _loc3_++;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = _pages.getListItemAt(_loc3_) as IRegionWindow;
            _loc2_ = _loc4_.findChildByTag("PAGE") as ITextWindow;
            _loc2_.caption = _loc3_.toString();
            if(_loc3_ == UnknownVarFromCollectiblesGridView_Int_2)
            {
               _loc2_.underline = true;
               _loc2_.textColor = 16711680;
            }
            else
            {
               _loc2_.underline = false;
               _loc2_.textColor = 0;
            }
            _loc3_++;
         }
      }
      
      private function onPageEventProc(param1:WindowMouseEvent) : void
      {
         var _loc3_:int = param1.window.id;
         var _loc2_:ITextWindow = (param1.target as IWindowController_1).findChildByTag("PAGE") as ITextWindow;
         switch(param1.type)
         {
            case "WME_CLICK":
               changeToPage(_loc3_);
               updatePaging();
               break;
            case "WME_OVER":
               _loc2_.textColor = 16711680;
               break;
            case "WME_OUT":
               if(_loc3_ != UnknownVarFromCollectiblesGridView_Int_2)
               {
                  _loc2_.textColor = 0;
               }
         }
      }
      
      private function passFilter(param1:CollectibleGroupedItem) : Boolean
      {
         var _loc2_:String = null;
         if(param1 == null || param1.name == null)
         {
            return false;
         }
         if(UnknownVarFromCollectiblesGridView_String_1.length > 0)
         {
            _loc2_ = param1.name.toLowerCase();
            if(_loc2_.indexOf(UnknownVarFromCollectiblesGridView_String_1) == -1)
            {
               return false;
            }
         }
         if(UnknownVarFromCollectiblesGridView_Int_3 != -1 && param1.renderableItem.productTypeId != UnknownVarFromCollectiblesGridView_Int_3)
         {
            return false;
         }
         return true;
      }
   }
}

