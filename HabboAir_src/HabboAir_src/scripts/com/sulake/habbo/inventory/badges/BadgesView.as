package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.communication.enum.BadgeRarity;
   import com.sulake.habbo.groups.UnknownHabboGroups1;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class BadgesView implements IInventoryView
   {
      private static const GRID_UPDATE_DELAY_MS:int = 100;
      
      private static const GRID_ITEMS_PER_UPDATE:int = 25;
      
      private static const FILTER_ALL:int = 0;
      
      private static const FILTER_NORMAL_BADGES:int = 1;
      
      private static const FILTER_ACHIEVEMENTS:int = 2;
      
      private static const UnknownConstFromBadgesView_Int_1:int = -1;
      
      private static const UnknownConstFromBadgesView_Int_2:int = -2;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromBadgesView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromBadgesView_BadgesModel_1:BadgesModel;
      
      private var UnknownVarFromBadgesView_IItemGridWindow_1:IItemGridWindow;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromBadgesView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromBadgesView_BadgeGridView_1:BadgeGridView;
      
      private var UnknownVarFromBadgesView_Int_1:int = 0;
      
      private var _ignoreBadgeFilterEvents:Boolean = false;
      
      private var UnknownVarFromBadgesView_Int_2:int = -1;
      
      private var UnknownVarFromBadgesView_Array_1:Array = [-1];
      
      private var _ignoreBadgeRarityFilterEvents:Boolean = false;
      
      public function BadgesView(param1:BadgesModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super();
         UnknownVarFromBadgesView_BadgesModel_1 = param1;
         _windowManager = param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return UnknownVarFromBadgesView_IWindowController_1_1 && UnknownVarFromBadgesView_IWindowController_1_1.parent != null && UnknownVarFromBadgesView_IWindowController_1_1.visible;
      }
      
      public function isStandaloneBadgeRarity(param1:int) : Boolean
      {
         return UnknownVarFromBadgesView_BadgesModel_1 != null && UnknownVarFromBadgesView_BadgesModel_1.isStandaloneBadgeRarity(param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _windowManager = null;
         UnknownVarFromBadgesView_BadgesModel_1 = null;
         if(UnknownVarFromBadgesView_BadgeGridView_1 != null)
         {
            UnknownVarFromBadgesView_BadgeGridView_1.dispose();
            UnknownVarFromBadgesView_BadgeGridView_1 = null;
         }
         UnknownVarFromBadgesView_IItemGridWindow_1 = null;
         if(UnknownVarFromBadgesView_IWindowController_1_1)
         {
            UnknownVarFromBadgesView_IWindowController_1_1.dispose();
            UnknownVarFromBadgesView_IWindowController_1_1 = null;
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(!UnknownVarFromBadgesView_Boolean_1)
         {
            init();
         }
         if(UnknownVarFromBadgesView_IWindowController_1_1 == null || Boolean(UnknownVarFromBadgesView_IWindowController_1_1.disposed))
         {
            return null;
         }
         return UnknownVarFromBadgesView_IWindowController_1_1;
      }
      
      public function updateAll(param1:String) : void
      {
         if(!UnknownVarFromBadgesView_Boolean_1)
         {
            return;
         }
         UnknownVarFromBadgesView_BadgesModel_1.forceSelection();
         var _loc2_:String = param1 ?? getSearchTerm();
         updateFilterOptions();
         updateListViews(_loc2_);
         updateActionView();
      }
      
      public function updateActionView() : void
      {
         var _loc2_:* = undefined;
         if(!UnknownVarFromBadgesView_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromBadgesView_IWindowController_1_1 == null || Boolean(UnknownVarFromBadgesView_IWindowController_1_1.disposed))
         {
            return;
         }
         var _loc3_:UnknownICoreWindowComponents4 = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("wearBadge_button") as UnknownICoreWindowComponents4;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Badge = UnknownVarFromBadgesView_BadgesModel_1.getSelectedBadge();
         if(_loc1_ == null)
         {
            _loc3_.caption = "${inventory.badges.wearbadge}";
            _loc3_.disable();
            clearSelectedBadgeDetails();
            setBadgeImageVisible(false);
         }
         else
         {
            if(_loc1_.isInUse)
            {
               _loc3_.caption = "${inventory.badges.clearbadge}";
            }
            else
            {
               _loc3_.caption = "${inventory.badges.wearbadge}";
            }
            updateSelectedBadgeDetails(_loc1_);
            IBadgeImageWidget(IWidgetWindowController(UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("badge_image")).widget).badgeId = _loc1_.badgeId;
            setBadgeImageVisible(true);
            _loc2_ = UnknownVarFromBadgesView_BadgesModel_1.getBadges(1);
            if(_loc2_ != null && _loc2_.length >= UnknownVarFromBadgesView_BadgesModel_1.getMaxActiveCount() && !_loc1_.isInUse)
            {
               _loc3_.disable();
            }
            else
            {
               _loc3_.enable();
            }
         }
      }
      
      private function clearSelectedBadgeDetails() : void
      {
         setBadgeName(null);
         setTextDetail("badgeDescription",null,false);
         setBadgeRarityDetail(0,false);
         setTextDetail("badgeOwnerCount",null,false);
      }
      
      private function updateSelectedBadgeDetails(param1:Badge) : void
      {
         setBadgeName(param1.badgeName);
         setTextDetail("badgeDescription",param1.badgeDescription,param1.badgeDescription != null && param1.badgeDescription != "");
         setBadgeRarityDetail(param1.badgeRarityId,true);
         setTextDetail("badgeOwnerCount",UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalizationWithParams("badge.owner_count","","count",UnknownHabboGroups1.formatOwnerCount(param1.ownerCount)),UnknownHabboGroups1.shouldShowOwnerCount(param1.ownerCount));
      }
      
      private function setBadgeImageVisible(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("badge_image");
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      private function init() : void
      {
         UnknownVarFromBadgesView_IWindowController_1_1 = UnknownVarFromBadgesView_BadgesModel_1.controller.view.getView("badges");
         UnknownVarFromBadgesView_IWindowController_1_1.procedure = windowEventProc;
         UnknownVarFromBadgesView_IWindowController_1_1.visible = false;
         var _loc3_:IWindowModel = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("wearBadge_button");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onWearBadgeClick);
         }
         var _loc1_:IItemGridWindow = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("inactive_items") as IItemGridWindow;
         var _loc2_:IItemListWindow = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("item_grid_pages") as IItemListWindow;
         UnknownVarFromBadgesView_BadgeGridView_1 = new BadgeGridView(this,_loc1_,_loc2_);
         UnknownVarFromBadgesView_IItemGridWindow_1 = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("active_items") as IItemGridWindow;
         UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("filter").caption = "";
         UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("clear_filter_button").visible = false;
         updateFilterOptions();
         UnknownVarFromBadgesView_Boolean_1 = true;
      }
      
      private function updateListViews(param1:String) : void
      {
         var _loc2_:Badge = null;
         var _loc3_:int = 0;
         if(!UnknownVarFromBadgesView_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromBadgesView_IWindowController_1_1 == null || Boolean(UnknownVarFromBadgesView_IWindowController_1_1.disposed))
         {
            return;
         }
         UnknownVarFromBadgesView_IItemGridWindow_1.removeGridItems();
         UnknownVarFromBadgesView_BadgeGridView_1.setFilter(UnknownVarFromBadgesView_Int_1,UnknownVarFromBadgesView_Int_2,param1);
         UnknownVarFromBadgesView_BadgeGridView_1.setItems(UnknownVarFromBadgesView_BadgesModel_1.getBadges(0));
         var _loc4_:Vector.<Badge> = UnknownVarFromBadgesView_BadgesModel_1.getBadges(1);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_] as Badge;
            UnknownVarFromBadgesView_IItemGridWindow_1.addGridItem(_loc2_.window);
            _loc3_++;
         }
      }
      
      private function setBadgeName(param1:String) : void
      {
         if(UnknownVarFromBadgesView_IWindowController_1_1 == null || Boolean(UnknownVarFromBadgesView_IWindowController_1_1.disposed))
         {
            return;
         }
         var _loc2_:ITextWindow = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("badgeName") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc2_.text = "";
         }
         else
         {
            _loc2_.text = "";
            _loc2_.text = param1;
         }
      }
      
      private function setTextDetail(param1:String, param2:String, param3:Boolean, param4:int = -1) : void
      {
         if(UnknownVarFromBadgesView_IWindowController_1_1 == null || Boolean(UnknownVarFromBadgesView_IWindowController_1_1.disposed))
         {
            return;
         }
         var _loc5_:ITextWindow = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName(param1) as ITextWindow;
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.visible = param3;
         _loc5_.text = "";
         if(!param3)
         {
            return;
         }
         if(param4 >= 0)
         {
            _loc5_.textColor = param4;
         }
         _loc5_.text = param2 ?? "";
      }
      
      private function setBadgeRarityDetail(param1:int, param2:Boolean) : void
      {
         if(UnknownVarFromBadgesView_IWindowController_1_1 == null || Boolean(UnknownVarFromBadgesView_IWindowController_1_1.disposed))
         {
            return;
         }
         var _loc5_:UnknownICoreWindowComponents6 = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("badgeRarityTag") as UnknownICoreWindowComponents6;
         var _loc4_:ITextWindow = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("badgeRarityBorder") as ITextWindow;
         var _loc3_:ITextWindow = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("badgeRarity") as ITextWindow;
         if(_loc5_ == null || _loc4_ == null || _loc3_ == null)
         {
            return;
         }
         _loc5_.visible = param2;
         _loc4_.visible = param2;
         _loc4_.text = "";
         _loc3_.visible = param2;
         _loc3_.text = "";
         if(!param2)
         {
            return;
         }
         _loc3_.textColor = 16777215;
         _loc3_.text = UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalizationWithParams("badge.rarity.badge","","rarity",getBadgeRarityText(param1));
         _loc4_.text = _loc3_.text;
         _loc5_.color = BadgeRarity.getWhiteBackgroundTagColor(param1,UnknownVarFromBadgesView_BadgesModel_1.isUncommonBadgeRarityEnabled());
      }
      
      private function getBadgeRarityText(param1:int) : String
      {
         var _loc2_:String = BadgeRarity.getLabelLocalizationKey(param1,UnknownVarFromBadgesView_BadgesModel_1.isUncommonBadgeRarityEnabled());
         return UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalization(_loc2_,_loc2_);
      }
      
      private function updateFilterOptions() : void
      {
         var _loc2_:IDropBaseController_1 = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:Array = [getBadgeFilterLabel(0),getBadgeFilterLabel(1),getBadgeFilterLabel(2)];
         _ignoreBadgeFilterEvents = true;
         try
         {
            _loc2_.populate(_loc1_);
            _loc2_.selection = UnknownVarFromBadgesView_Int_1;
         }
         finally
         {
            _ignoreBadgeFilterEvents = false;
         }
         updateRarityFilterOptions();
      }
      
      private function updateRarityFilterOptions() : void
      {
         var _loc2_:IDropBaseController_1 = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("filter.rarity") as IDropBaseController_1;
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromBadgesView_Array_1 = getAvailableBadgeRarityFilterIds();
         if(UnknownVarFromBadgesView_Array_1.indexOf(UnknownVarFromBadgesView_Int_2) == -1)
         {
            UnknownVarFromBadgesView_Int_2 = -1;
         }
         if(!isBadgeRarityFilterEnabled())
         {
            UnknownVarFromBadgesView_Int_2 = -1;
         }
         var _loc1_:Array = [];
         for each(var _loc3_ in UnknownVarFromBadgesView_Array_1)
         {
            _loc1_.push(getBadgeRarityFilterLabel(_loc3_));
         }
         _ignoreBadgeRarityFilterEvents = true;
         try
         {
            _loc2_.populate(_loc1_);
            _loc2_.selection = Math.max(0,UnknownVarFromBadgesView_Array_1.indexOf(UnknownVarFromBadgesView_Int_2));
         }
         finally
         {
            _ignoreBadgeRarityFilterEvents = false;
         }
         if(isBadgeRarityFilterEnabled())
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:WindowKeyboardEvent = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            var _loc6_:* = param2.name;
            if("clear_filter_button" === _loc6_)
            {
               UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("filter").caption = "";
               param2.visible = false;
               updateAll(null);
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc4_ = param1 as WindowKeyboardEvent;
            _loc6_ = param2.name;
            if("filter" === _loc6_)
            {
               UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc4_.keyCode == 27)
               {
                  param2.caption = "";
                  UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("clear_filter_button").visible = false;
                  updateAll(null);
               }
               else if(_loc4_.keyCode == 13)
               {
                  updateAll(param2.caption);
               }
            }
         }
         else if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "filter.options":
                  if(!_ignoreBadgeFilterEvents)
                  {
                     _loc5_ = getSelectedBadgeFilter(param2 as IDropBaseController_1);
                     if(_loc5_ != UnknownVarFromBadgesView_Int_1)
                     {
                        UnknownVarFromBadgesView_Int_1 = _loc5_;
                        updateAll(null);
                     }
                  }
                  break;
               case "filter.rarity":
                  if(!_ignoreBadgeRarityFilterEvents)
                  {
                     _loc3_ = getSelectedBadgeRarityFilter(param2 as IDropBaseController_1);
                     if(_loc3_ != UnknownVarFromBadgesView_Int_2)
                     {
                        UnknownVarFromBadgesView_Int_2 = _loc3_;
                        updateAll(null);
                     }
                     break;
                  }
            }
         }
      }
      
      private function onWearBadgeClick(param1:WindowEvent) : void
      {
         var _loc2_:Badge = UnknownVarFromBadgesView_BadgesModel_1.getSelectedBadge();
         if(_loc2_ != null)
         {
            UnknownVarFromBadgesView_BadgesModel_1.toggleBadgeWearing(_loc2_.badgeId);
         }
      }
      
      private function getSelectedBadgeFilter(param1:IDropBaseController_1) : int
      {
         if(param1 == null)
         {
            return 0;
         }
         var _loc2_:int = param1.selection;
         if(_loc2_ < 0 || _loc2_ > 2)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private function getBadgeFilterLabel(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalization("inventory.badges.filter.all");
            case 1:
               return UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalization("inventory.badges.filter.normal_badges");
            case 2:
               return UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalization("inventory.badges.filter.achievements");
            default:
               return "";
         }
      }
      
      private function getAvailableBadgeRarityFilterIds() : Array
      {
         var _loc1_:Array = UnknownVarFromBadgesView_BadgesModel_1.getAvailableRareBadgeRarityIds();
         if(UnknownVarFromBadgesView_BadgesModel_1.hasCommonBadgeRarityGroup())
         {
            _loc1_.unshift(-2);
         }
         _loc1_.unshift(-1);
         return _loc1_;
      }
      
      private function getSelectedBadgeRarityFilter(param1:IDropBaseController_1) : int
      {
         if(param1 == null || UnknownVarFromBadgesView_Array_1 == null || UnknownVarFromBadgesView_Array_1.length == 0)
         {
            return -1;
         }
         var _loc2_:int = param1.selection;
         if(_loc2_ < 0 || _loc2_ >= UnknownVarFromBadgesView_Array_1.length)
         {
            _loc2_ = 0;
         }
         return int(UnknownVarFromBadgesView_Array_1[_loc2_]);
      }
      
      private function isBadgeRarityFilterEnabled() : Boolean
      {
         return UnknownVarFromBadgesView_Array_1 != null && UnknownVarFromBadgesView_Array_1.length > 2;
      }
      
      private function getBadgeRarityFilterLabel(param1:int) : String
      {
         if(param1 == -1)
         {
            return UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalization("inventory.badges.filter.rarity.all");
         }
         if(param1 == -2)
         {
            return UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalization("inventory.badges.filter.rarity.common");
         }
         var _loc2_:String = BadgeRarity.getLocalizationKey(param1,UnknownVarFromBadgesView_BadgesModel_1.isUncommonBadgeRarityEnabled());
         return _loc2_.length > 0 ? UnknownVarFromBadgesView_BadgesModel_1.controller.localization.getLocalization(_loc2_,_loc2_) : "";
      }
      
      private function getSearchTerm() : String
      {
         if(UnknownVarFromBadgesView_IWindowController_1_1 == null || Boolean(UnknownVarFromBadgesView_IWindowController_1_1.disposed))
         {
            return "";
         }
         var _loc1_:ITextWindow = UnknownVarFromBadgesView_IWindowController_1_1.findChildByName("filter") as ITextWindow;
         return _loc1_ != null ? _loc1_.caption : "";
      }
   }
}

