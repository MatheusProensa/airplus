package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class BadgeGridView
   {
      private static const FILTER_ALL:int = 0;
      
      private static const FILTER_NORMAL_BADGES:int = 1;
      
      private static const FILTER_ACHIEVEMENTS:int = 2;
      
      private static const UnknownConstFromBadgeGridView_Int_1:int = -1;
      
      private static const UnknownConstFromBadgeGridView_Int_2:int = -2;
      
      private static const ACHIEVEMENT_PREFIX:String = "ACH_";
      
      private var UnknownVarFromBadgeGridView_BadgesView_1:BadgesView;
      
      private var UnknownVarFromBadgeGridView_IItemGridWindow_1:IItemGridWindow;
      
      private var _items:Vector.<Badge>;
      
      private var _passedItems:Vector.<Badge>;
      
      private var _pages:IItemListWindow;
      
      private var UnknownVarFromBadgeGridView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromBadgeGridView_Int_1:int = 200;
      
      private var UnknownVarFromBadgeGridView_Int_2:int = -1;
      
      private var _currentPageItems:Vector.<Badge>;
      
      private var UnknownVarFromBadgeGridView_String_1:String = "";
      
      private var UnknownVarFromBadgeGridView_Int_3:int = 0;
      
      private var UnknownVarFromBadgeGridView_Int_4:int = -1;
      
      public function BadgeGridView(param1:BadgesView, param2:IItemGridWindow, param3:IItemListWindow)
      {
         super();
         UnknownVarFromBadgeGridView_BadgesView_1 = param1;
         UnknownVarFromBadgeGridView_IItemGridWindow_1 = param2;
         UnknownVarFromBadgeGridView_IItemGridWindow_1.shouldRebuildGridOnResize = false;
         _items = new Vector.<Badge>(0);
         _passedItems = new Vector.<Badge>(0);
         _pages = param3;
         if(_pages)
         {
            UnknownVarFromBadgeGridView_IRegionWindow_1 = _pages.removeListItemAt(0) as IRegionWindow;
         }
      }
      
      public function get visibleCount() : int
      {
         return UnknownVarFromBadgeGridView_IItemGridWindow_1.numGridItems;
      }
      
      public function get currentPageItems() : Vector.<Badge>
      {
         return _currentPageItems;
      }
      
      private function get pageCount() : int
      {
         return _passedItems.length / UnknownVarFromBadgeGridView_Int_1 + 1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromBadgeGridView_IItemGridWindow_1 = null;
         _items = null;
      }
      
      public function clearGrid() : void
      {
         if(UnknownVarFromBadgeGridView_IItemGridWindow_1 != null)
         {
            UnknownVarFromBadgeGridView_IItemGridWindow_1.removeGridItems();
         }
         UnknownVarFromBadgeGridView_IItemGridWindow_1.destroyGridItems();
      }
      
      public function setFilter(param1:int, param2:int, param3:String) : void
      {
         UnknownVarFromBadgeGridView_Int_3 = param1;
         UnknownVarFromBadgeGridView_Int_4 = param2;
         UnknownVarFromBadgeGridView_String_1 = param3 == null ? "" : param3.toLowerCase();
         update();
      }
      
      public function itemWasUpdated(param1:Badge) : void
      {
         if(passFilter(param1))
         {
            update();
         }
      }
      
      public function getFirstThumb() : IWindowController_1
      {
         if(UnknownVarFromBadgeGridView_IItemGridWindow_1.numGridItems == 0)
         {
            return null;
         }
         return UnknownVarFromBadgeGridView_IItemGridWindow_1.getGridItemAt(0) as IWindowController_1;
      }
      
      public function setItems(param1:Vector.<Badge>) : void
      {
         _items = param1;
         update();
      }
      
      private function update() : void
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:Vector.<Badge> = new Vector.<Badge>(0);
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
         changeToPage(UnknownVarFromBadgeGridView_Int_2,true);
         updatePaging();
      }
      
      private function changeToPage(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:* = 0;
         if(param1 > -1)
         {
            if(UnknownVarFromBadgeGridView_Int_2 == param1 && !param2)
            {
               return;
            }
         }
         else
         {
            param1 = 0;
         }
         UnknownVarFromBadgeGridView_Int_2 = param1;
         if(UnknownVarFromBadgeGridView_Int_2 >= pageCount)
         {
            UnknownVarFromBadgeGridView_Int_2 = pageCount - 1;
         }
         UnknownVarFromBadgeGridView_Int_2 = Math.max(UnknownVarFromBadgeGridView_Int_2,0);
         _currentPageItems = new Vector.<Badge>(0);
         clearGrid();
         var _loc3_:int = UnknownVarFromBadgeGridView_Int_2 * UnknownVarFromBadgeGridView_Int_1;
         var _loc4_:int = _loc3_ + UnknownVarFromBadgeGridView_Int_1;
         _loc4_ = Math.min(_loc4_,_passedItems.length);
         _loc5_ = _loc3_;
         while(_loc5_ < _loc4_)
         {
            UnknownVarFromBadgeGridView_IItemGridWindow_1.addGridItem(_passedItems[_loc5_].window);
            _currentPageItems.push(_passedItems[_loc5_]);
            _loc5_++;
         }
      }
      
      private function updatePassedItems(param1:Badge) : void
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
         if(UnknownVarFromBadgeGridView_Int_2 >= _loc1_)
         {
            UnknownVarFromBadgeGridView_Int_2 = _loc1_ - 1;
         }
         UnknownVarFromBadgeGridView_Int_2 = Math.max(UnknownVarFromBadgeGridView_Int_2,0);
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
               _loc4_ = UnknownVarFromBadgeGridView_IRegionWindow_1.clone() as IRegionWindow;
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
            if(_loc3_ == UnknownVarFromBadgeGridView_Int_2)
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
               if(_loc3_ != UnknownVarFromBadgeGridView_Int_2)
               {
                  _loc2_.textColor = 0;
               }
         }
      }
      
      private function passFilter(param1:Badge) : Boolean
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(param1 == null || param1.badgeName == null || param1.badgeDescription == null)
         {
            return false;
         }
         var _loc3_:Boolean = param1.badgeId != null && param1.badgeId.indexOf("ACH_") == 0;
         if(UnknownVarFromBadgeGridView_Int_3 == 1 && _loc3_)
         {
            return false;
         }
         if(UnknownVarFromBadgeGridView_Int_3 == 2 && !_loc3_)
         {
            return false;
         }
         if(UnknownVarFromBadgeGridView_Int_4 == -2)
         {
            if(UnknownVarFromBadgeGridView_BadgesView_1.isStandaloneBadgeRarity(param1.badgeRarityId))
            {
               return false;
            }
         }
         else if(UnknownVarFromBadgeGridView_Int_4 != -1 && param1.badgeRarityId != UnknownVarFromBadgeGridView_Int_4)
         {
            return false;
         }
         if(UnknownVarFromBadgeGridView_String_1.length > 0)
         {
            _loc2_ = param1.badgeName.toLowerCase();
            _loc4_ = param1.badgeDescription.toLowerCase();
            if(_loc2_.indexOf(UnknownVarFromBadgeGridView_String_1) == -1 && _loc4_.indexOf(UnknownVarFromBadgeGridView_String_1) == -1)
            {
               return false;
            }
         }
         return true;
      }
   }
}

