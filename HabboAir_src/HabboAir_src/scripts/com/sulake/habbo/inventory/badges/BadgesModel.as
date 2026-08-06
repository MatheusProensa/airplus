package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.enum.BadgeRarity;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeInventoryData;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   
   public class BadgesModel implements IInventoryModel
   {
      public static const BADGES_ALL:int = -1;
      
      public static const BADGES_INACTIVE:int = 0;
      
      public static const BADGES_ACTIVE:int = 1;
      
      private var _controller:HabboInventory;
      
      private var UnknownVarFromBadgesModel_BadgesView_1:BadgesView;
      
      private var _badges:Vector.<Badge>;
      
      private var UnknownVarFromBadgesModel_Vector_1:Vector.<Badge>;
      
      private var UnknownVarFromBadgesModel_Map_1:Map;
      
      private var UnknownVarFromBadgesModel_Array_1:Array;
      
      private var _hasCommonBadgeRarityGroup:Boolean = false;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _disposed:Boolean = false;
      
      private const MAX_ACTIVE_BADGE_COUNT:int = 5;
      
      public function BadgesModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection)
      {
         super();
         _controller = param1;
         _windowManager = param2;
         _badges = new Vector.<Badge>(0);
         UnknownVarFromBadgesModel_Vector_1 = new Vector.<Badge>(0);
         UnknownVarFromBadgesModel_Array_1 = [];
         _hasCommonBadgeRarityGroup = false;
         _assets = param4;
         _communication = param3;
         UnknownVarFromBadgesModel_BadgesView_1 = new BadgesView(this,param2,param4);
         UnknownVarFromBadgesModel_Map_1 = new Map();
         initBadgeWindowAsset();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function initBadgeWindowAsset() : void
      {
         var _loc2_:ISoundAsset = _assets.getAssetByName("inventory_thumb_xml");
         var _loc1_:XmlAsset = XmlAsset(_loc2_);
         if(Badge.UnknownVarFromBadge_IWindowController_1_1 == null)
         {
            Badge.UnknownVarFromBadge_IWindowController_1_1 = _windowManager.buildFromXML(XML(_loc1_.content)) as IWindowController_1;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(Badge.UnknownVarFromBadge_IWindowController_1_1 != null)
         {
            Badge.UnknownVarFromBadge_IWindowController_1_1.dispose();
            Badge.UnknownVarFromBadge_IWindowController_1_1 = null;
         }
         _disposed = true;
         _controller = null;
         _windowManager = null;
         _badges = null;
         UnknownVarFromBadgesModel_Vector_1 = null;
         UnknownVarFromBadgesModel_Array_1 = null;
         _hasCommonBadgeRarityGroup = false;
         if(UnknownVarFromBadgesModel_Map_1)
         {
            UnknownVarFromBadgesModel_Map_1.dispose();
            UnknownVarFromBadgesModel_Map_1 = null;
         }
         if(UnknownVarFromBadgesModel_BadgesView_1 != null)
         {
            UnknownVarFromBadgesModel_BadgesView_1.dispose();
            UnknownVarFromBadgesModel_BadgesView_1 = null;
         }
         _assets = null;
         _communication = null;
      }
      
      public function requestInitialization() : void
      {
         _communication.connection.send(new GetBadgesComposer());
      }
      
      public function getMaxActiveCount() : int
      {
         return 5;
      }
      
      public function updateView() : void
      {
         if(UnknownVarFromBadgesModel_BadgesView_1 != null)
         {
            UnknownVarFromBadgesModel_BadgesView_1.updateAll(null);
         }
      }
      
      public function updateActionView() : void
      {
         UnknownVarFromBadgesModel_BadgesView_1.updateActionView();
      }
      
      private function startWearingBadge(param1:Badge) : void
      {
         UnknownVarFromBadgesModel_Vector_1.push(param1);
         param1.isInUse = true;
      }
      
      private function stopWearingBadge(param1:Badge) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromBadgesModel_Vector_1.length)
         {
            if(UnknownVarFromBadgesModel_Vector_1[_loc2_] == param1)
            {
               UnknownVarFromBadgesModel_Vector_1.splice(_loc2_,1);
               param1.isInUse = false;
               return;
            }
            _loc2_++;
         }
      }
      
      private function resetBadges() : void
      {
         if(UnknownVarFromBadgesModel_Map_1)
         {
            UnknownVarFromBadgesModel_Map_1.dispose();
            UnknownVarFromBadgesModel_Map_1 = null;
         }
         if(_badges != null)
         {
            for each(var _loc1_ in _badges)
            {
               _loc1_.dispose();
            }
            _badges = null;
         }
         if(UnknownVarFromBadgesModel_Vector_1 != null)
         {
            UnknownVarFromBadgesModel_Vector_1 = null;
         }
         UnknownVarFromBadgesModel_Array_1 = [];
         _hasCommonBadgeRarityGroup = false;
      }
      
      public function initBadges(param1:Map) : void
      {
         var _loc6_:BadgeInventoryData = null;
         var _loc5_:Boolean = false;
         var _loc4_:String = null;
         var _loc7_:String = null;
         var _loc2_:Badge = null;
         resetBadges();
         _badges = new Vector.<Badge>(0);
         UnknownVarFromBadgesModel_Vector_1 = new Vector.<Badge>(0);
         UnknownVarFromBadgesModel_Map_1 = new Map();
         for each(var _loc3_ in param1.getKeys())
         {
            _loc6_ = param1.getValue(_loc3_) as BadgeInventoryData;
            if(_loc6_ != null)
            {
               if(_loc6_.badgeId > 0)
               {
                  UnknownVarFromBadgesModel_Map_1.add(_loc3_,_loc6_.badgeId);
               }
               _loc5_ = _controller.unseenItemTracker.isUnseen(4,_loc6_.badgeId);
               _loc4_ = controller.localization.getBadgeName(_loc3_);
               _loc7_ = controller.localization.getBadgeDesc(_loc3_);
               _loc2_ = new Badge(this,_loc3_,_loc4_,_loc7_,_loc5_,_loc6_.ownerCount,_loc6_.badgeRarityId);
               if(_loc5_)
               {
                  _badges.unshift(_loc2_);
               }
               else
               {
                  _badges.push(_loc2_);
               }
            }
         }
         refreshAvailableRareBadgeRarityIds();
      }
      
      public function updateBadgeData(param1:BadgeInventoryData, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         updateBadge(param1.badgeCode,param2,param1.badgeId,param1.ownerCount,param1.badgeRarityId);
      }
      
      public function updateBadge(param1:String, param2:Boolean, param3:int, param4:int, param5:int) : void
      {
         var _loc9_:Boolean = false;
         var _loc8_:String = null;
         var _loc10_:String = null;
         var _loc6_:Badge = null;
         if(param3 > 0 && !UnknownVarFromBadgesModel_Map_1.hasKey(param1))
         {
            UnknownVarFromBadgesModel_Map_1.add(param1,param3);
         }
         var _loc7_:Badge = getBadge(param1);
         if(_loc7_ != null)
         {
            _loc7_.updateMetadata(param4,param5);
            if(_loc7_.isInUse != param2)
            {
               if(param2)
               {
                  startWearingBadge(_loc7_);
               }
               else
               {
                  stopWearingBadge(_loc7_);
               }
            }
         }
         else
         {
            _loc9_ = _controller.unseenItemTracker.isUnseen(4,param3);
            _loc8_ = controller.localization.getBadgeName(param1);
            _loc10_ = controller.localization.getBadgeDesc(param1);
            _loc6_ = new Badge(this,param1,_loc8_,_loc10_,_loc9_,param4,param5);
            if(_loc9_)
            {
               _badges.unshift(_loc6_);
            }
            else
            {
               _badges.push(_loc6_);
            }
            if(param2)
            {
               startWearingBadge(_loc6_);
            }
         }
         refreshAvailableRareBadgeRarityIds();
      }
      
      private function getBadge(param1:String) : Badge
      {
         var _loc3_:int = 0;
         var _loc2_:Badge = null;
         _loc3_ = 0;
         while(_loc3_ < _badges.length)
         {
            _loc2_ = _badges[_loc3_];
            if(_loc2_.badgeId == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function removeBadge(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Badge = null;
         _loc3_ = 0;
         while(_loc3_ < _badges.length)
         {
            _loc2_ = _badges[_loc3_];
            if(_loc2_.badgeId == param1)
            {
               _badges.splice(_loc3_,1);
               stopWearingBadge(_loc2_);
               refreshAvailableRareBadgeRarityIds();
               updateView();
               return;
            }
            _loc3_++;
         }
      }
      
      public function toggleBadgeWearing(param1:String) : void
      {
         var _loc2_:Badge = getBadge(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.isInUse)
            {
               stopWearingBadge(_loc2_);
            }
            else
            {
               startWearingBadge(_loc2_);
            }
            saveBadgeSelection();
         }
      }
      
      public function saveBadgeSelection() : void
      {
         var _loc4_:int = 0;
         var _loc2_:Badge = null;
         var _loc1_:SetActivatedBadgesComposer = new SetActivatedBadgesComposer();
         var _loc3_:Vector.<Badge> = getBadges(1);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc4_];
            _loc1_.addActivatedBadge(_loc2_.badgeId);
            _loc4_++;
         }
         _communication.connection.send(_loc1_);
      }
      
      public function setBadgeSelected(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Badge = null;
         _loc3_ = 0;
         while(_loc3_ < _badges.length)
         {
            _loc2_ = _badges[_loc3_] as Badge;
            if(_loc2_ != null)
            {
               _loc2_.isSelected = _loc2_.badgeId == param1;
            }
            _loc3_++;
         }
         updateActionView();
      }
      
      public function forceSelection() : void
      {
         var _loc1_:Badge = getSelectedBadge();
         if(_loc1_ != null)
         {
            return;
         }
         var _loc3_:Vector.<Badge> = getBadges(0);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc1_ = _loc3_[0] as Badge;
            setBadgeSelected(_loc1_.badgeId);
            return;
         }
         var _loc2_:Vector.<Badge> = getBadges(1);
         if(_loc2_ != null && _loc2_.length > 0)
         {
            _loc1_ = _loc2_[0] as Badge;
            setBadgeSelected(_loc1_.badgeId);
         }
      }
      
      public function getSelectedBadge(param1:int = -1) : Badge
      {
         var _loc4_:int = 0;
         var _loc3_:Badge = null;
         var _loc2_:Vector.<Badge> = getBadges(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.isSelected)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getBadges(param1:int = -1) : Vector.<Badge>
      {
         var _loc3_:* = undefined;
         switch(param1 - -1)
         {
            case 0:
               return _badges;
            case 1:
               _loc3_ = new Vector.<Badge>(0);
               for each(var _loc2_ in _badges)
               {
                  if(!_loc2_.isInUse)
                  {
                     _loc3_.push(_loc2_);
                  }
               }
               return _loc3_;
            case 2:
               return UnknownVarFromBadgesModel_Vector_1;
            default:
               Logger.log("Unexpected filter. Returning an empty array to maintain backward compatibility");
               return new Vector.<Badge>(0);
         }
      }
      
      public function getBadgeFromActive(param1:int) : Badge
      {
         return getItemInIndex(param1,1);
      }
      
      public function getBadgeFromInactive(param1:int) : Badge
      {
         return getItemInIndex(param1,0);
      }
      
      public function getItemInIndex(param1:int, param2:int = -1) : Badge
      {
         var _loc3_:Vector.<Badge> = getBadges(param2);
         if(param1 < 0 || param1 >= _loc3_.length)
         {
            return null;
         }
         return _loc3_[param1];
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return UnknownVarFromBadgesModel_BadgesView_1.getWindowContainer();
      }
      
      public function getAvailableRareBadgeRarityIds() : Array
      {
         return UnknownVarFromBadgesModel_Array_1 != null ? UnknownVarFromBadgesModel_Array_1.concat() : [];
      }
      
      public function hasCommonBadgeRarityGroup() : Boolean
      {
         return _hasCommonBadgeRarityGroup;
      }
      
      public function isUncommonBadgeRarityEnabled() : Boolean
      {
         return _controller != null && _controller.getBoolean("badge_rarity.uncommon");
      }
      
      public function isStandaloneBadgeRarity(param1:int) : Boolean
      {
         return BadgeRarity.isStandaloneTier(param1,isUncommonBadgeRarityEnabled());
      }
      
      public function closingInventoryView() : void
      {
         if(UnknownVarFromBadgesModel_BadgesView_1.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "badges" && _controller.isVisible)
         {
            _controller.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_BADGES"));
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function get controller() : HabboInventory
      {
         return _controller;
      }
      
      public function resetUnseenItems() : void
      {
         if(!_controller.isMainViewActive)
         {
            return;
         }
         _controller.unseenItemTracker.resetCategory(4);
         for each(var _loc1_ in _badges)
         {
            _loc1_.isUnseen = false;
         }
         updateView();
         _controller.updateUnseenItemCounts();
      }
      
      public function selectItemById(param1:String) : void
      {
         setBadgeSelected(param1);
      }
      
      public function removeSelections() : void
      {
         for each(var _loc1_ in _badges)
         {
            _loc1_.isSelected = false;
         }
      }
      
      private function refreshAvailableRareBadgeRarityIds() : void
      {
         UnknownVarFromBadgesModel_Array_1 = [];
         _hasCommonBadgeRarityGroup = false;
         if(_badges == null)
         {
            return;
         }
         var _loc1_:Array = [];
         for each(var _loc2_ in _badges)
         {
            if(_loc2_ != null)
            {
               if(!isStandaloneBadgeRarity(_loc2_.badgeRarityId))
               {
                  _hasCommonBadgeRarityGroup = true;
               }
               else if(!_loc1_[_loc2_.badgeRarityId])
               {
                  _loc1_[_loc2_.badgeRarityId] = true;
                  UnknownVarFromBadgesModel_Array_1.push(_loc2_.badgeRarityId);
               }
            }
         }
         UnknownVarFromBadgesModel_Array_1.sort(16);
      }
   }
}

