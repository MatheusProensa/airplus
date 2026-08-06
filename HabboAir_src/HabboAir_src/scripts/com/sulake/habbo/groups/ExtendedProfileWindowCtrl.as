package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.enum.BadgeRarity;
   import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileData;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
   import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfo;
   import com.sulake.habbo.communication.messages.incoming.users.SelectedBadgeData;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.DeselectFavouriteHabboGroupMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.SelectFavouriteHabboGroupMessageComposer;
   import com.sulake.habbo.friendlist.RelationshipStatusEnum;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.geom.Rectangle;
   
   public class ExtendedProfileWindowCtrl implements IComponentInterfaceQueue, ILinkEventTracker
   {
      private var UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_Int_1:int;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_GroupDetailsCtrl_1:GroupDetailsCtrl;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1:ExtendedProfileData;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_Boolean_1:Boolean;
      
      private var _badgeUpdateExpected:Boolean = false;
      
      private var _playGlowOnNextBadgeUpdate:Boolean = true;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_Array_1:Array = [];
      
      private var _badgeDetails:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromExtendedProfileWindowCtrl_Map_1:Map = new Map();
      
      private var _relationshipUpdateExpected:Boolean = false;
      
      public function ExtendedProfileWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1 = param1;
         UnknownVarFromExtendedProfileWindowCtrl_GroupDetailsCtrl_1 = new GroupDetailsCtrl(param1,false);
      }
      
      public function dispose() : void
      {
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1 = null;
         UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1 = null;
         UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1 = null;
         disposeBadgeDetails();
         clearBadgeGlowEffects();
         if(UnknownVarFromExtendedProfileWindowCtrl_Map_1)
         {
            UnknownVarFromExtendedProfileWindowCtrl_Map_1.dispose();
            UnknownVarFromExtendedProfileWindowCtrl_Map_1 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromExtendedProfileWindowCtrl_GroupDetailsCtrl_1)
         {
            UnknownVarFromExtendedProfileWindowCtrl_GroupDetailsCtrl_1.dispose();
            UnknownVarFromExtendedProfileWindowCtrl_GroupDetailsCtrl_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1 == null;
      }
      
      private function prepareWindow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IWindowModel = null;
         if(_window != null)
         {
            return;
         }
         if(UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_1 == null)
         {
            UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_1 = IWindowController_1(UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.getXmlWindow("group_entry"));
         }
         if(UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_2 == null)
         {
            UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_2 = IWindowController_1(UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.getXmlWindow("no_groups"));
            UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_2.findChildByName("view_groups_button").procedure = onViewGroups;
         }
         _window = IFrameController(UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.getXmlWindow("new_extended_profile"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("addasfriend_button").procedure = onAddAsFriend;
         _window.findChildByName("rooms_button").procedure = onRooms;
         UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1 = IItemListWindow(_window.findChildByName("groups_list"));
         _window.center();
         _window.findChildByName("change_looks").procedure = onChangeLooks;
         _window.findChildByName("change_badges").procedure = onChangeBadges;
         _window.findChildByName("badgeCountRegion").procedure = onBadgeCountClicked;
         _window.findChildByName("user_activity_points").visible = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.isActivityDisplayEnabled;
         _window.findChildByName("block_button").procedure = onBlock;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = _window.findChildByName("badge_" + _loc1_);
            if(_loc2_ != null)
            {
               _loc2_.addEventListener("WME_OVER",showBadgeInfo);
               _loc2_.addEventListener("WME_OUT",hideBadgeInfo);
            }
            _loc1_++;
         }
         for each(var _loc3_ in RelationshipStatusEnum.displayableStatuses)
         {
            _window.findChildByName(RelationshipStatusEnum.statusAsString(_loc3_) + "_friend_name_link_region").procedure = onRelationshipLink;
         }
      }
      
      public function onProfileChanged(param1:int) : void
      {
         if(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1 != null && UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId == param1 && _window != null && Boolean(_window.visible))
         {
            UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new GetExtendedProfileMessageComposer(param1));
            UnknownVarFromExtendedProfileWindowCtrl_Boolean_1 = true;
         }
      }
      
      public function onProfile(param1:ExtendedProfileData) : void
      {
         var _loc2_:Boolean = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1 != null && UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId == param1.userId && _window != null && Boolean(_window.visible);
         UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1 = param1;
         var _loc3_:HabboGroupEntryData = getSelectedGroup();
         if(_loc3_ == null)
         {
            if(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds.length > 0)
            {
               UnknownVarFromExtendedProfileWindowCtrl_Int_1 = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds[0].groupId;
               _loc3_ = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds[0];
            }
            else
            {
               UnknownVarFromExtendedProfileWindowCtrl_Int_1 = 0;
            }
         }
         if(UnknownVarFromExtendedProfileWindowCtrl_Int_1 > 0)
         {
            UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new GetHabboGroupDetailsMessageComposer(UnknownVarFromExtendedProfileWindowCtrl_Int_1,false));
         }
         refresh(_loc2_);
         _window.visible = true;
         if(!UnknownVarFromExtendedProfileWindowCtrl_Boolean_1)
         {
            _window.activate();
         }
         UnknownVarFromExtendedProfileWindowCtrl_Boolean_1 = false;
      }
      
      private function getSelectedGroup() : HabboGroupEntryData
      {
         for each(var _loc1_ in UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds)
         {
            if(_loc1_.groupId == UnknownVarFromExtendedProfileWindowCtrl_Int_1)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function refresh(param1:Boolean = false) : void
      {
         prepareWindow();
         if(!param1)
         {
            clearSelectedBadges();
         }
         _playGlowOnNextBadgeUpdate = !param1;
         _relationshipUpdateExpected = true;
         _badgeUpdateExpected = true;
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new GetRelationshipStatusInfoMessageComposer(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId));
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new GetSelectedBadgesMessageComposer(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId));
         refreshHeader();
         refreshGroupList();
      }
      
      private function clearSelectedBadges() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IBadgeImageWidget = null;
         if(_window == null)
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_Array_1 = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = IBadgeImageWidget(IWidgetWindowController(_window.findChildByName("badge_" + _loc2_)).widget);
            _loc1_.type = "normal";
            _loc1_.badgeId = "";
            _loc2_++;
         }
      }
      
      private function refreshGroupList() : void
      {
         var _loc1_:IWindowController_1 = null;
         var _loc2_:IBadgeImageWidget = null;
         var _loc4_:IWindowController_1 = null;
         var _loc3_:* = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId == UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.avatarId;
         UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1.visible = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds.length > 0;
         UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1.destroyListItems();
         for each(var _loc5_ in UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds)
         {
            _loc1_ = IWindowController_1(UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_1.clone());
            _loc1_.id = _loc5_.groupId;
            _loc1_.findChildByName("bg_region").procedure = onSelectGroup;
            _loc1_.findChildByName("bg_region").id = _loc5_.groupId;
            _loc1_.findChildByName("clear_favourite").procedure = onClearFavourite;
            _loc1_.findChildByName("clear_favourite").visible = _loc5_.favourite && _loc3_;
            _loc1_.findChildByName("clear_favourite").id = _loc5_.groupId;
            _loc1_.findChildByName("make_favourite").procedure = onMakeFavourite;
            _loc1_.findChildByName("make_favourite").visible = !_loc5_.favourite && _loc3_;
            _loc1_.findChildByName("make_favourite").id = _loc5_.groupId;
            _loc2_ = IBadgeImageWidget(IWidgetWindowController(_loc1_.findChildByName("group_pic_bitmap")).widget);
            _loc2_.type = "group";
            _loc2_.badgeId = _loc5_.badgeCode;
            _loc2_.groupId = _loc5_.groupId;
            UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1.addListItem(_loc1_);
         }
         refreshGroupListSelection();
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.registerParameter("extendedprofile.groups.count","count",UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds.length.toString());
         if(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.guilds.length < 1)
         {
            _loc4_ = IWindowController_1(_window.findChildByName("group_cont"));
            _loc4_.removeChildAt(0);
            _loc4_.addChild(UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_2);
            UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_2.findChildByName("no_groups_caption").caption = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getLocalization(_loc3_ ? "extendedprofile.nogroups.me" : "extendedprofile.nogroups.user");
            UnknownVarFromExtendedProfileWindowCtrl_IWindowController_1_2.findChildByName("view_groups_button").visible = true;
         }
      }
      
      private function refreshGroupListSelection() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IWindowController_1 = null;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1.numListItems)
         {
            _loc1_ = IWindowController_1(UnknownVarFromExtendedProfileWindowCtrl_IItemListWindow_1.getListItemAt(_loc2_));
            _loc1_.findChildByName("bg_selected_bitmap").visible = UnknownVarFromExtendedProfileWindowCtrl_Int_1 == _loc1_.id;
            _loc1_.findChildByName("bg_unselected_bitmap").visible = UnknownVarFromExtendedProfileWindowCtrl_Int_1 != _loc1_.id;
            _loc2_++;
         }
      }
      
      private function refreshHeader() : void
      {
         var _loc1_:* = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId == UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.avatarId;
         var _loc2_:Boolean = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isHidden && !_loc1_;
         _window.findChildByName("motto_txt").caption = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.motto;
         _window.findChildByName("status_txt").visible = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isFriend || _loc1_;
         _window.findChildByName("friend_request_sent_txt").visible = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isFriendRequestSent;
         _window.findChildByName("online_icon").visible = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.onlineStatus == 1;
         _window.findChildByName("offline_icon").visible = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.onlineStatus == 0;
         _window.findChildByName("hidden_icon").visible = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.onlineStatus == 2;
         _window.findChildByName("status").invalidate();
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.registerParameter("extendedprofile.username","username",UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userName);
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.registerParameter("extendedprofile.created","created",UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.creationDate);
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.registerParameter("extendedprofile.activitypoints","activitypoints",UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.achievementScore.toString());
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.registerParameter("extendedprofile.last.login","lastlogin",UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.lastAccessSinceInSeconds == -1 ? "-" : FriendlyTime.getFriendlyTime(UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization,UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.lastAccessSinceInSeconds,".ago"));
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.registerParameter("extendedprofile.friends.count","count",UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.friendCount == -1 ? "-" : UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.friendCount.toString());
         _window.findChildByName("bottom").visible = !_loc2_;
         _window.findChildByName("full_profile_hidden").visible = _loc2_;
         refreshAvatarImage();
         var _loc4_:Boolean = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isFriend || _loc1_;
         _window.findChildByName("addasfriend_button").visible = !UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isFriend && !UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isFriendRequestSent && !_loc1_ && UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.friendlist.canBeAskedForAFriend(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId);
         _window.findChildByName("ok_icon").visible = _loc4_;
         _window.findChildByName("status_txt").visible = _loc4_;
         _window.findChildByName("status_txt").caption = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getLocalization(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isFriend ? "extendedprofile.friend" : "extendedprofile.me");
         _window.findChildByName("change_own_attributes").visible = _loc1_;
         _window.findChildByName("levelValue").caption = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.accountLevel.toString();
         _window.findChildByName("badgeCount").caption = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.totalBadges.toString();
         var _loc3_:IWindowModel = _window.findChildByName("badgeRank");
         if(_loc3_ != null)
         {
            _loc3_.visible = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.totalBadgesRank >= 0;
            if(_loc3_.visible)
            {
               _loc3_.caption = "(#" + UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.totalBadgesRank.toString() + ")";
            }
         }
         _window.findChildByName("blocked_container").visible = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.sessionDataManager.isBlocked(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId);
         _window.findChildByName("block_button").visible = !_loc1_;
      }
      
      private function refreshRelationships() : void
      {
         var _loc1_:Boolean = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.getBoolean("relationship.status.enabled");
         if(_loc1_ && _window)
         {
            _window.findChildByName("rel_status_label_txt").visible = true;
            for each(var _loc2_ in RelationshipStatusEnum.displayableStatuses)
            {
               setRelationshipDetails(_loc2_);
            }
         }
      }
      
      private function setRelationshipDetails(param1:int) : void
      {
         var _loc4_:RelationshipStatusInfo = UnknownVarFromExtendedProfileWindowCtrl_Map_1.getValue(param1);
         var _loc5_:String = RelationshipStatusEnum.statusAsString(param1);
         var _loc6_:IWindowModel = _window.findChildByName(_loc5_ + "_txt");
         var _loc3_:IWindowModel = _window.findChildByName(_loc5_ + "_friend_name_link_text");
         var _loc2_:IWidgetWindowController = IWidgetWindowController(_window.findChildByName(_loc5_ + "_head"));
         if(_loc4_ && _loc4_.friendCount > 0)
         {
            _loc3_.caption = _loc4_.randomFriendName;
            _loc2_.visible = true;
            IAvatarImageWidget(_loc2_.widget).figure = _loc4_.randomFriendFigure;
            if(_loc4_.friendCount > 1)
            {
               _loc6_.visible = true;
               _loc6_.invalidate();
               _loc6_.caption = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getLocalizationWithParams("extendedprofile.relstatus.others." + _loc5_,"","count","" + (_loc4_.friendCount - 1));
            }
            else
            {
               _loc6_.visible = false;
            }
         }
         else
         {
            _loc2_.visible = false;
            _loc3_.caption = "${extendedprofile.add.friends}";
            _loc6_.caption = "${extendedprofile.no.friends.in.this.category}";
            _loc6_.visible = true;
         }
      }
      
      public function onGroupDetails(param1:HabboGroupDetailsData) : void
      {
         var _loc2_:IWindowController_1 = null;
         if(UnknownVarFromExtendedProfileWindowCtrl_Int_1 == param1.groupId)
         {
            _loc2_ = IWindowController_1(_window.findChildByName("group_cont"));
            _loc2_.removeChildAt(0);
            _loc2_.invalidate();
            UnknownVarFromExtendedProfileWindowCtrl_GroupDetailsCtrl_1.onGroupDetails(_loc2_,param1);
         }
      }
      
      public function onRelationshipStatusInfo(param1:int, param2:Map) : void
      {
         if(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1 && relationshipUpdateExpected)
         {
            UnknownVarFromExtendedProfileWindowCtrl_Map_1 = param2.clone();
            refreshRelationships();
            relationshipUpdateExpected = false;
         }
      }
      
      public function onUserBadges(param1:int, param2:Array) : void
      {
         var _loc3_:Boolean = false;
         if(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1 && badgeUpdateExpected && _window != null && UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId == param1)
         {
            param2 = param2 == null ? [] : param2;
            _loc3_ = _playGlowOnNextBadgeUpdate;
            _playGlowOnNextBadgeUpdate = true;
            clearSelectedBadges();
            for each(var _loc4_ in param2)
            {
               if(!(_loc4_ == null || _loc4_.slotIndex < 0 || _loc4_.slotIndex > 4))
               {
                  UnknownVarFromExtendedProfileWindowCtrl_Array_1[_loc4_.slotIndex] = _loc4_;
                  setSelectedBadge(_loc4_.slotIndex,_loc4_,_loc3_);
               }
            }
            badgeUpdateExpected = false;
         }
      }
      
      private function setSelectedBadge(param1:int, param2:SelectedBadgeData, param3:Boolean) : void
      {
         var _loc5_:IWidgetWindowController = IWidgetWindowController(_window.findChildByName("badge_" + param1));
         var _loc4_:IBadgeImageWidget = _loc5_.widget as IBadgeImageWidget;
         var _loc6_:Boolean = isUncommonBadgeRarityEnabled();
         _loc4_.type = "normal";
         _loc4_.badgeId = param2.badgeCode;
         _loc4_.glowColor = BadgeRarity.isStandaloneTier(param2.badgeRarityId,_loc6_) ? int(BadgeRarity.getGlowColor(param2.badgeRarityId,_loc6_)) : -1;
         if(param3 && _loc4_.glowColor >= 0)
         {
            _loc4_.playGlow(uint(_loc4_.glowColor));
         }
      }
      
      private function isUncommonBadgeRarityEnabled() : Boolean
      {
         return UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1 != null && UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.getBoolean("badge_rarity.uncommon");
      }
      
      private function showBadgeInfo(param1:WindowMouseEvent) : void
      {
         if(param1.window == null)
         {
            return;
         }
         var _loc5_:int = int(param1.window.name.replace("badge_",""));
         if(_loc5_ < 0 || _loc5_ > 4)
         {
            return;
         }
         var _loc4_:SelectedBadgeData = UnknownVarFromExtendedProfileWindowCtrl_Array_1[_loc5_] as SelectedBadgeData;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:IBadgeImageWidget = IWidgetWindowController(param1.window).widget as IBadgeImageWidget;
         if(_loc2_ != null && _loc2_.glowColor >= 0)
         {
            _loc2_.playGlow(uint(_loc2_.glowColor));
         }
         populateBadgeDetails(UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getBadgeName(_loc4_.badgeCode),UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getBadgeDesc(_loc4_.badgeCode),_loc4_);
         if(_badgeDetails.desktop != null)
         {
            _badgeDetails.desktop.addChild(_badgeDetails);
         }
         _badgeDetails.activate();
         var _loc3_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc3_);
         _badgeDetails.x = _loc3_.left + _loc3_.width;
         _badgeDetails.y = _loc3_.top + (_loc3_.height - _badgeDetails.height) / 2;
      }
      
      private function hideBadgeInfo(param1:WindowMouseEvent) : void
      {
         disposeBadgeDetails();
      }
      
      private function createBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            return;
         }
         _badgeDetails = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.getXmlWindow("extended_profile_badge_details") as UnknownICoreWindowComponents6;
         if(_badgeDetails == null)
         {
            throw new Error("Failed to construct extended profile badge details window from XML!");
         }
      }
      
      private function populateBadgeDetails(param1:String, param2:String, param3:SelectedBadgeData) : void
      {
         createBadgeDetails();
         var _loc5_:IItemListWindow = _badgeDetails.findChildByName("details_list") as IItemListWindow;
         var _loc8_:ITextWindow = _badgeDetails.findChildByName("name") as ITextWindow;
         var _loc9_:ITextWindow = _badgeDetails.findChildByName("description") as ITextWindow;
         var _loc6_:UnknownICoreWindowComponents6 = _badgeDetails.findChildByName("rarity_tag") as UnknownICoreWindowComponents6;
         var _loc4_:ITextWindow = _badgeDetails.findChildByName("rarity_border") as ITextWindow;
         var _loc11_:ITextWindow = _badgeDetails.findChildByName("rarity") as ITextWindow;
         var _loc7_:ITextWindow = _badgeDetails.findChildByName("owner_count") as ITextWindow;
         _loc8_.text = param1;
         _loc9_.visible = param2 != "";
         _loc9_.text = param2;
         var _loc10_:* = param3 != null;
         _loc6_.visible = _loc10_;
         _loc4_.text = "";
         _loc11_.text = "";
         if(_loc10_)
         {
            _loc11_.textColor = 16777215;
            _loc11_.text = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getLocalizationWithParams("badge.rarity.badge","","rarity",UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getLocalization(BadgeRarity.getLabelLocalizationKey(param3.badgeRarityId,isUncommonBadgeRarityEnabled())));
            _loc4_.text = _loc11_.text;
            _loc6_.color = BadgeRarity.getWhiteBackgroundTagColor(param3.badgeRarityId,isUncommonBadgeRarityEnabled());
         }
         var _loc12_:Boolean = param3 != null && UnknownHabboGroups1.shouldShowOwnerCount(param3.ownerCount);
         _loc7_.visible = _loc12_;
         _loc7_.text = "";
         if(_loc12_)
         {
            _loc7_.text = UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.localization.getLocalizationWithParams("badge.owner_count","","count",UnknownHabboGroups1.formatOwnerCount(param3.ownerCount));
         }
         if(_loc5_ != null)
         {
            _loc5_.arrangeListItems();
            _badgeDetails.height = _loc5_.y + _loc5_.height + 6;
         }
      }
      
      private function disposeBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            _badgeDetails.dispose();
            _badgeDetails = null;
         }
      }
      
      private function clearBadgeGlowEffects() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IBadgeImageWidget = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = getBadgeWidget(_loc2_);
            if(_loc1_ != null)
            {
               _loc1_.clearGlow();
            }
            _loc2_++;
         }
      }
      
      private function getBadgeWidget(param1:int) : IBadgeImageWidget
      {
         if(_window == null)
         {
            return null;
         }
         var _loc2_:IWidgetWindowController = _window.findChildByName("badge_" + param1) as IWidgetWindowController;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.widget as IBadgeImageWidget;
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         var _loc3_:IWindowModel = _window.findChildByName(param1);
         _loc3_.mouseThreshold = 0;
         _loc3_.procedure = param2;
      }
      
      private function onAddAsFriend(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.friendlist.askForAFriend(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId,UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userName))
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.isFriendRequestSent = true;
         refreshHeader();
      }
      
      private function onRooms(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.newNavigator.performSearch("hotel_view","owner:" + UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userName);
      }
      
      private function onBlock(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.windowManager.confirm("${extendedprofile.block_player.title}","${extendedprofile.block_player.desc}",0,onConfirmBlock);
      }
      
      private function onConfirmBlock(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         if(param1 == null || Boolean(param1.disposed))
         {
            return;
         }
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.sessionDataManager.blockUser(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId);
            _window.findChildByName("blocked_container").visible = true;
         }
      }
      
      private function onConfirmUnblock(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         if(param1 == null || Boolean(param1.disposed))
         {
            return;
         }
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.sessionDataManager.unblockUser(UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId);
            _window.findChildByName("blocked_container").visible = false;
         }
      }
      
      public function get linkPattern() : String
      {
         return "profile/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length != 2)
         {
            return;
         }
         var _loc3_:String = _loc2_[1];
         if(_loc3_ == "unblock")
         {
            UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.windowManager.confirm("${extendedprofile.unblock_player.title}","${extendedprofile.unblock_player.desc}",0,onConfirmUnblock);
         }
      }
      
      private function onRelationshipLink(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:String = null;
         var _loc3_:RelationshipStatusInfo = null;
         var _loc5_:int = 0;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param1.target != null && param2.name != null && UnknownVarFromExtendedProfileWindowCtrl_Map_1 != null)
         {
            _loc4_ = param2.name.substr(0,param2.name.indexOf("_"));
            _loc3_ = UnknownVarFromExtendedProfileWindowCtrl_Map_1.getValue(RelationshipStatusEnum.stringAsStatus(_loc4_));
            if(_loc3_ != null)
            {
               _loc5_ = _loc3_.randomFriendId;
               if(_loc5_)
               {
                  UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.showExtendedProfile(_loc5_);
               }
            }
            else
            {
               UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.windowManager.alert("${extendedprofile.add.friends.alert.title}","${extendedprofile.add.friends.alert.body}",0,addFriendsAlertCallback);
            }
         }
      }
      
      private function onViewGroups(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.navigator.performGuildBaseSearch();
      }
      
      private function onSelectGroup(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_Int_1 = param2.id;
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new GetHabboGroupDetailsMessageComposer(UnknownVarFromExtendedProfileWindowCtrl_Int_1,false));
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new EventLogMessageComposer("HabboGroups","" + param2.id,"select"));
         this.refreshGroupListSelection();
      }
      
      private function onMakeFavourite(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new SelectFavouriteHabboGroupMessageComposer(param2.id));
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new EventLogMessageComposer("HabboGroups","" + param2.parent.id,"make favourite"));
         UnknownVarFromExtendedProfileWindowCtrl_Int_1 = param2.id;
      }
      
      private function onClearFavourite(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new DeselectFavouriteHabboGroupMessageComposer(param2.id));
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new EventLogMessageComposer("HabboGroups","" + param2.parent.id,"clear favourite"));
         UnknownVarFromExtendedProfileWindowCtrl_Int_1 = param2.id;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      private function onChangeLooks(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.context.createLinkEvent("avatareditor/open");
      }
      
      private function onChangeBadges(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.context.createLinkEvent("inventory/open/badges");
      }
      
      private function onBadgeCountClicked(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.context.createLinkEvent(UnknownHabboGroups1.getLink(0,-1,getBadgeLeaderboardPageForCurrentProfile()));
      }
      
      private function getBadgeLeaderboardPageForCurrentProfile() : int
      {
         return 0;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            disposeBadgeDetails();
            clearBadgeGlowEffects();
            _window.visible = false;
         }
      }
      
      private function refreshAvatarImage(param1:Boolean = false) : void
      {
         var _loc2_:IWidgetWindowController = IWidgetWindowController(_window.findChildByName("avatar_image"));
         var _loc3_:IAvatarImageWidget = IAvatarImageWidget(_loc2_.widget);
         _loc3_.figure = UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.figure;
      }
      
      public function updateVisibleExtendedProfile(param1:int) : void
      {
         if(_window != null && Boolean(_window.visible) && UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1 != null && UnknownVarFromExtendedProfileWindowCtrl_ExtendedProfileData_1.userId != param1)
         {
            UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.send(new GetExtendedProfileMessageComposer(param1));
         }
      }
      
      public function get badgeUpdateExpected() : Boolean
      {
         return _badgeUpdateExpected;
      }
      
      public function set badgeUpdateExpected(param1:Boolean) : void
      {
         _badgeUpdateExpected = param1;
      }
      
      public function set relationshipUpdateExpected(param1:Boolean) : void
      {
         _relationshipUpdateExpected = param1;
      }
      
      public function get relationshipUpdateExpected() : Boolean
      {
         return _relationshipUpdateExpected;
      }
      
      private function addFriendsAlertCallback(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            UnknownVarFromExtendedProfileWindowCtrl_HabboGroupsManager_1.context.createLinkEvent("friendbar/findfriends");
            close();
         }
         param1.dispose();
      }
   }
}

