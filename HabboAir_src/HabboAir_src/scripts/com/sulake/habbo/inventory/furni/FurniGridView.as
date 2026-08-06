package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.wired_trading.requirements.WiredTradeRequirementsModel;
   
   public class FurniGridView
   {
      private var UnknownVarFromFurniGridView_IItemGridWindow_1:IItemGridWindow;
      
      private var _items:Vector.<GroupItem>;
      
      private var _passedItems:Vector.<GroupItem>;
      
      private var _pages:IItemListWindow;
      
      private var UnknownVarFromFurniGridView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromFurniGridView_Int_1:int = 200;
      
      private var UnknownVarFromFurniGridView_Int_2:int = -1;
      
      private var _currentPageItems:Vector.<GroupItem>;
      
      private var UnknownVarFromFurniGridView_String_1:String = "";
      
      private var _showingRentedItems:Boolean = false;
      
      private var UnknownVarFromFurniGridView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFurniGridView_Boolean_2:Boolean = true;
      
      private var UnknownVarFromFurniGridView_String_2:String = "all";
      
      private var UnknownVarFromFurniGridView_String_3:String = "any";
      
      private var UnknownVarFromFurniGridView_WiredTradeRequirementsModel_1:WiredTradeRequirementsModel;
      
      public function FurniGridView(param1:IItemGridWindow, param2:IItemListWindow)
      {
         super();
         UnknownVarFromFurniGridView_IItemGridWindow_1 = param1;
         UnknownVarFromFurniGridView_IItemGridWindow_1.shouldRebuildGridOnResize = false;
         _items = new Vector.<GroupItem>(0);
         _passedItems = new Vector.<GroupItem>(0);
         _pages = param2;
         if(_pages)
         {
            UnknownVarFromFurniGridView_IRegionWindow_1 = _pages.removeListItemAt(0) as IRegionWindow;
         }
      }
      
      public function get visibleCount() : int
      {
         return UnknownVarFromFurniGridView_IItemGridWindow_1.numGridItems;
      }
      
      public function get currentPageItems() : Vector.<GroupItem>
      {
         return _currentPageItems;
      }
      
      private function get pageCount() : int
      {
         return _passedItems.length / UnknownVarFromFurniGridView_Int_1 + 1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromFurniGridView_IItemGridWindow_1 = null;
         _items = null;
      }
      
      public function clearGrid() : void
      {
         if(UnknownVarFromFurniGridView_IItemGridWindow_1 != null)
         {
            UnknownVarFromFurniGridView_IItemGridWindow_1.removeGridItems();
         }
         UnknownVarFromFurniGridView_IItemGridWindow_1.destroyGridItems();
      }
      
      public function setFilter(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:String, param6:Boolean) : void
      {
         UnknownVarFromFurniGridView_String_2 = param1;
         UnknownVarFromFurniGridView_String_3 = param2;
         _showingRentedItems = param3;
         UnknownVarFromFurniGridView_Boolean_1 = param4;
         UnknownVarFromFurniGridView_Boolean_2 = param6;
         UnknownVarFromFurniGridView_String_1 = param5.toLowerCase();
         UnknownVarFromFurniGridView_WiredTradeRequirementsModel_1 = null;
         update();
      }
      
      public function setFilterByWired(param1:String, param2:String, param3:String, param4:WiredTradeRequirementsModel) : void
      {
         UnknownVarFromFurniGridView_String_2 = param1;
         UnknownVarFromFurniGridView_String_3 = param2;
         _showingRentedItems = false;
         UnknownVarFromFurniGridView_Boolean_1 = true;
         UnknownVarFromFurniGridView_Boolean_2 = false;
         UnknownVarFromFurniGridView_String_1 = param3.toLowerCase();
         UnknownVarFromFurniGridView_WiredTradeRequirementsModel_1 = param4;
         update();
      }
      
      public function itemWasUpdated(param1:GroupItem) : void
      {
         if(passFilter(param1))
         {
            update();
         }
      }
      
      public function itemsWereUpdated(param1:Array) : void
      {
         var _loc2_:Boolean = false;
         for each(var _loc3_ in param1)
         {
            if(passFilter(_loc3_))
            {
               _loc2_ = true;
               break;
            }
         }
         if(_loc2_)
         {
            update();
         }
      }
      
      public function getFirstThumb() : IWindowController_1
      {
         if(UnknownVarFromFurniGridView_IItemGridWindow_1.numGridItems == 0)
         {
            return null;
         }
         return UnknownVarFromFurniGridView_IItemGridWindow_1.getGridItemAt(0) as IWindowController_1;
      }
      
      public function setItems(param1:Vector.<GroupItem>) : void
      {
         _items = param1;
         update();
      }
      
      private function update() : void
      {
         var item:GroupItem;
         var changes:Boolean;
         var i:int;
         var currentItems:Vector.<GroupItem> = new Vector.<GroupItem>(0);
         for each(item in _items)
         {
            if(passFilter(item))
            {
               currentItems.push(item);
            }
         }
         if(!UnknownVarFromFurniGridView_Boolean_1 && _showingRentedItems)
         {
            currentItems = currentItems.sort(function(param1:GroupItem, param2:GroupItem):Number
            {
               var _loc5_:FurnitureItem = param1.peek();
               var _loc4_:FurnitureItem = param2.peek();
               var _loc3_:int = int(_loc4_.hasRentPeriodStarted) - int(_loc5_.hasRentPeriodStarted);
               return _loc3_ != 0 ? _loc3_ : _loc5_.secondsToExpiration - _loc4_.secondsToExpiration;
            });
         }
         if(currentItems.length == _passedItems.length)
         {
            changes = false;
            i = 0;
            while(i < currentItems.length)
            {
               if(currentItems[i] != _passedItems[i])
               {
                  changes = true;
                  break;
               }
               i++;
            }
            if(!changes)
            {
               return;
            }
         }
         _passedItems = currentItems;
         changeToPage(UnknownVarFromFurniGridView_Int_2,true);
         updatePaging();
      }
      
      private function changeToPage(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:* = 0;
         if(param1 > -1)
         {
            if(UnknownVarFromFurniGridView_Int_2 == param1 && !param2)
            {
               return;
            }
         }
         else
         {
            param1 = 0;
         }
         UnknownVarFromFurniGridView_Int_2 = param1;
         if(UnknownVarFromFurniGridView_Int_2 >= pageCount)
         {
            UnknownVarFromFurniGridView_Int_2 = pageCount - 1;
         }
         UnknownVarFromFurniGridView_Int_2 = Math.max(UnknownVarFromFurniGridView_Int_2,0);
         _currentPageItems = new Vector.<GroupItem>(0);
         clearGrid();
         var _loc3_:int = UnknownVarFromFurniGridView_Int_2 * UnknownVarFromFurniGridView_Int_1;
         var _loc4_:int = _loc3_ + UnknownVarFromFurniGridView_Int_1;
         _loc4_ = Math.min(_loc4_,_passedItems.length);
         _loc5_ = _loc3_;
         while(_loc5_ < _loc4_)
         {
            UnknownVarFromFurniGridView_IItemGridWindow_1.addGridItem(_passedItems[_loc5_].window);
            _currentPageItems.push(_passedItems[_loc5_]);
            _loc5_++;
         }
      }
      
      private function updatePassedItems(param1:GroupItem) : void
      {
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
         if(UnknownVarFromFurniGridView_Int_2 >= _loc1_)
         {
            UnknownVarFromFurniGridView_Int_2 = _loc1_ - 1;
         }
         UnknownVarFromFurniGridView_Int_2 = Math.max(UnknownVarFromFurniGridView_Int_2,0);
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
               _loc4_ = UnknownVarFromFurniGridView_IRegionWindow_1.clone() as IRegionWindow;
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
            if(_loc3_ == UnknownVarFromFurniGridView_Int_2)
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
               if(_loc3_ != UnknownVarFromFurniGridView_Int_2)
               {
                  _loc2_.textColor = 0;
               }
         }
      }
      
      private function passFilter(param1:GroupItem) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         if(!passMainFilter(param1))
         {
            return false;
         }
         if(!passTypeFilter(param1))
         {
            return false;
         }
         if(!UnknownVarFromFurniGridView_Boolean_1 && _showingRentedItems != param1.isRented)
         {
            return false;
         }
         if(!UnknownVarFromFurniGridView_Boolean_2 && param1.isNft())
         {
            return false;
         }
         if(UnknownVarFromFurniGridView_String_1.length > 0)
         {
            _loc3_ = param1.name.toLowerCase();
            _loc4_ = param1.description.toLowerCase();
            _loc2_ = param1.stuffData.chestName.toLowerCase();
            if(_loc3_.indexOf(UnknownVarFromFurniGridView_String_1) == -1 && _loc4_.indexOf(UnknownVarFromFurniGridView_String_1) == -1 && (_loc2_ == "" || _loc2_.indexOf(UnknownVarFromFurniGridView_String_1) == -1))
            {
               return false;
            }
         }
         if(UnknownVarFromFurniGridView_WiredTradeRequirementsModel_1 != null && !UnknownVarFromFurniGridView_WiredTradeRequirementsModel_1.canOfferFurni(param1))
         {
            return false;
         }
         return true;
      }
      
      private function passMainFilter(param1:GroupItem) : Boolean
      {
         switch(UnknownVarFromFurniGridView_String_2)
         {
            case "all":
               return true;
            case "floor_items":
               return !param1.isWallItem;
            case "wall_items":
               return param1.isWallItem && !InventoryFilterTypeHelper.isRoomLayout(param1);
            case "room_layout":
               return InventoryFilterTypeHelper.isRoomLayout(param1);
            default:
               return true;
         }
      }
      
      private function passTypeFilter(param1:GroupItem) : Boolean
      {
         switch(UnknownVarFromFurniGridView_String_3)
         {
            case "any":
               return true;
            case "sittable":
               return InventoryFilterTypeHelper.isSittable(param1);
            case "layable":
               return InventoryFilterTypeHelper.isLayable(param1);
            case "tiles_or_rugs":
               return InventoryFilterTypeHelper.isTilesOrRugs(param1);
            case "ltd":
               return InventoryFilterTypeHelper.isLtd(param1);
            case "wired":
               return InventoryFilterTypeHelper.isWired(param1);
            case "credit_furni":
               return InventoryFilterTypeHelper.isCreditFurni(param1);
            case "clothes":
               return InventoryFilterTypeHelper.isClothes(param1);
            case "pet_food":
               return InventoryFilterTypeHelper.isPetFood(param1);
            case "collectibles":
               return InventoryFilterTypeHelper.isCollectible(param1);
            case "tradable":
               return InventoryFilterTypeHelper.isTradable(param1);
            case "non_tradable":
               return InventoryFilterTypeHelper.isNonTradable(param1);
            case "recyclable":
               return InventoryFilterTypeHelper.isRecyclable(param1);
            case "windows":
               return InventoryFilterTypeHelper.isWindow(param1);
            case "dimmers":
               return InventoryFilterTypeHelper.isDimmer(param1);
            case "stickies":
               return InventoryFilterTypeHelper.isStickie(param1);
            case "paintings":
               return InventoryFilterTypeHelper.isPainting(param1);
            case "floors":
               return InventoryFilterTypeHelper.isFloor(param1);
            case "wallpapers":
               return InventoryFilterTypeHelper.isWallpaper(param1);
            case "landscape":
               return InventoryFilterTypeHelper.isLandscape(param1);
            default:
               return true;
         }
      }
   }
}

