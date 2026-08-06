package com.sulake.habbo.navigator.view
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.navigator.transitional.LegacyNavigator;
   import com.sulake.habbo.session.enum.RoomTradingLevelEnum;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomInfoPopup
   {
      private var _window:IWindowController_1;
      
      private var _navigator:HabboNewNavigator;
      
      private var UnknownVarFromRoomInfoPopup_Vector_1:Vector.<String> = new Vector.<String>(0);
      
      private var UnknownVarFromRoomInfoPopup_GuestRoomData_1:GuestRoomData = null;
      
      private var UnknownVarFromRoomInfoPopup_Point_1:Point = new Point(-1,-1);
      
      private var UnknownVarFromRoomInfoPopup_Boolean_1:Boolean = false;
      
      private var UnknownVarFromRoomInfoPopup_Boolean_2:Boolean;
      
      private var UnknownVarFromRoomInfoPopup_Boolean_3:Boolean = false;
      
      private var UnknownVarFromRoomInfoPopup_Boolean_4:Boolean;
      
      public function RoomInfoPopup(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function show(param1:Boolean) : void
      {
         if(param1)
         {
            if(!_window)
            {
               createWindow();
            }
            populate();
            _window.visible = true;
         }
         else
         {
            UnknownVarFromRoomInfoPopup_Boolean_1 = false;
            UnknownVarFromRoomInfoPopup_Boolean_3 = false;
            if(_window)
            {
               _window.visible = false;
            }
         }
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function showAt(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc5_:Point = null;
         var _loc4_:* = !this.visible;
         show(param1);
         if(param1)
         {
            _loc5_ = new Point(param2,param3 - _window.height / 2);
            if(UnknownVarFromRoomInfoPopup_Point_1 != _loc5_)
            {
               if(_loc4_ && param1 && UnknownVarFromRoomInfoPopup_GuestRoomData_1)
               {
                  _navigator.trackEventLog("browse.openroominfo","Results",UnknownVarFromRoomInfoPopup_GuestRoomData_1.roomName,UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId);
               }
            }
            position = _loc5_;
            _window.activate();
         }
      }
      
      public function setData(param1:GuestRoomData) : void
      {
         if(UnknownVarFromRoomInfoPopup_GuestRoomData_1 == null || UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId != param1.flatId)
         {
            UnknownVarFromRoomInfoPopup_Boolean_1 = false;
            UnknownVarFromRoomInfoPopup_Boolean_3 = false;
         }
         this.UnknownVarFromRoomInfoPopup_GuestRoomData_1 = param1;
      }
      
      public function getGlobalRectangle(param1:Rectangle) : void
      {
         _window.getGlobalRectangle(param1);
      }
      
      private function set position(param1:Point) : void
      {
         _window.position = param1;
         UnknownVarFromRoomInfoPopup_Point_1 = param1;
      }
      
      private function get roomIsHome() : Boolean
      {
         if(UnknownVarFromRoomInfoPopup_Boolean_1)
         {
            return UnknownVarFromRoomInfoPopup_Boolean_2;
         }
         return _navigator.legacyNavigator.isRoomHome(UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId);
      }
      
      private function set roomIsHome(param1:Boolean) : void
      {
         UnknownVarFromRoomInfoPopup_Boolean_1 = true;
         UnknownVarFromRoomInfoPopup_Boolean_2 = param1;
      }
      
      private function get roomIsFavorite() : Boolean
      {
         if(UnknownVarFromRoomInfoPopup_Boolean_3)
         {
            return UnknownVarFromRoomInfoPopup_Boolean_4;
         }
         return _navigator.legacyNavigator.isRoomFavorite(UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId);
      }
      
      private function set roomIsFavorite(param1:Boolean) : void
      {
         UnknownVarFromRoomInfoPopup_Boolean_3 = true;
         UnknownVarFromRoomInfoPopup_Boolean_4 = param1;
      }
      
      private function populate() : void
      {
         var _loc7_:HabboGroupDetailsData = null;
         var _loc5_:String = null;
         var _loc1_:String = null;
         var _loc10_:int = 0;
         if(UnknownVarFromRoomInfoPopup_GuestRoomData_1 == null)
         {
            return;
         }
         var _loc4_:IItemListWindow = IItemListWindow(_window.findChildByName("main_content"));
         var _loc9_:IItemListWindow = IItemListWindow(_window.findChildByName("header_content"));
         var _loc6_:IItemListWindow = IItemListWindow(_window.findChildByName("bottom_itemlist"));
         _window.findChildByName("room_owner_region").visible = UnknownVarFromRoomInfoPopup_GuestRoomData_1.showOwner;
         _window.findChildByName("room_group_region").visible = UnknownVarFromRoomInfoPopup_GuestRoomData_1.groupBadgeCode != "";
         _window.findChildByName("room_name").caption = UnknownVarFromRoomInfoPopup_GuestRoomData_1.roomName;
         _window.findChildByName("room_desc").caption = UnknownVarFromRoomInfoPopup_GuestRoomData_1.description;
         _window.findChildByName("owner_name").caption = UnknownVarFromRoomInfoPopup_GuestRoomData_1.ownerName;
         _window.findChildByName("room_owner_region").id = UnknownVarFromRoomInfoPopup_GuestRoomData_1.ownerId;
         _window.findChildByName("room_owner_region").procedure = ownerLinkProcedure;
         _window.findChildByName("favorite_region").procedure = roomFavoriteRegionProcedure;
         _window.findChildByName("home_region").procedure = homeRoomRegionProcedure;
         _window.findChildByName("settings_region").procedure = settingsRegionProcedure;
         _window.findChildByName("settings_container").visible = UnknownVarFromRoomInfoPopup_GuestRoomData_1.ownerName == _navigator.sessionData.userName;
         if(_navigator.context.configuration.getBoolean("room.report.enabled") && UnknownVarFromRoomInfoPopup_GuestRoomData_1.ownerName != _navigator.sessionData.userName)
         {
            _window.findChildByName("report_region").id = UnknownVarFromRoomInfoPopup_GuestRoomData_1.ownerId;
            _window.findChildByName("report_region").procedure = reportRegionProcedure;
            _window.findChildByName("report_region").visible = true;
            _window.findChildByName("report_container").visible = true;
         }
         else
         {
            _window.findChildByName("report_region").visible = false;
            _window.findChildByName("report_container").visible = false;
         }
         IItemListWindow(_window.findChildByName("midBottom_itemlist")).arrangeListItems();
         IStaticBitmapWrapperWindow(_window.findChildByName("favorite_icon")).assetUri = "newnavigator_icon_fav_" + (roomIsFavorite ? "yes" : "no");
         IStaticBitmapWrapperWindow(_window.findChildByName("home_icon")).assetUri = "newnavigator_icon_home_" + (roomIsHome ? "yes" : "no");
         var _loc8_:* = UnknownVarFromRoomInfoPopup_GuestRoomData_1.groupBadgeCode != "";
         _window.findChildByName("room_group_badge").visible = _loc8_;
         _window.findChildByName("room_owner_region").visible = UnknownVarFromRoomInfoPopup_GuestRoomData_1.showOwner;
         _window.findChildByName("room_group_region").visible = _loc8_;
         _window.findChildByName("room_group_owner_container").visible = _loc8_ || UnknownVarFromRoomInfoPopup_GuestRoomData_1.showOwner;
         if(_loc8_)
         {
            IBadgeImageWidget(IWidgetWindowController(_window.findChildByName("room_group_badge")).widget).badgeId = UnknownVarFromRoomInfoPopup_GuestRoomData_1.groupBadgeCode;
            _window.findChildByName("group_name").caption = UnknownVarFromRoomInfoPopup_GuestRoomData_1.groupName;
            _window.findChildByName("group_name").id = UnknownVarFromRoomInfoPopup_GuestRoomData_1.habboGroupId;
            _window.findChildByName("room_group_region").id = UnknownVarFromRoomInfoPopup_GuestRoomData_1.habboGroupId;
            _window.findChildByName("room_group_region").procedure = groupLinkProcedure;
            _loc7_ = _navigator.getCachedGroupDetails(UnknownVarFromRoomInfoPopup_GuestRoomData_1.habboGroupId);
            if(_loc7_)
            {
               if(_loc7_.isOwner)
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = "newnavigator_icon_group_owner";
               }
               else if(_loc7_.isAdmin)
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = "newnavigator_icon_group_admin";
               }
               else
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = null;
               }
               IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_size")).assetUri = "${image.library.url}guilds/grouptype_icon_" + _loc7_.type + ".png";
               IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_furnish")).assetUri = !_loc7_.membersCanDecorate ? null : "${image.library.url}guilds/group_decorate_icon.png";
            }
         }
         else
         {
            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_admin")).assetUri = null;
            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_size")).assetUri = null;
            IStaticBitmapWrapperWindow(_window.findChildByName("group_mode_furnish")).assetUri = null;
         }
         var _loc3_:* = UnknownVarFromRoomInfoPopup_GuestRoomData_1.roomAdExpiresInMin > 0;
         if(_loc3_)
         {
            _loc5_ = _navigator.localization.getLocalizationWithParams("navigator.eventsettings.name") + ": " + UnknownVarFromRoomInfoPopup_GuestRoomData_1.roomAdName;
            _loc1_ = _navigator.localization.getLocalizationWithParams("navigator.eventsettings.desc") + ": " + UnknownVarFromRoomInfoPopup_GuestRoomData_1.roomAdDescription + "\n";
            _loc1_ += _navigator.localization.getLocalizationWithParams("roomad.event.expiration_time") + FriendlyTime.getFriendlyTime(_navigator.localization,UnknownVarFromRoomInfoPopup_GuestRoomData_1.roomAdExpiresInMin * 60);
            _window.findChildByName("event_name").caption = _loc5_;
            _window.findChildByName("event_desc").caption = _loc1_;
         }
         _loc6_.getListItemByName("event_info").visible = _loc3_;
         _loc9_.arrangeListItems();
         UnknownVarFromRoomInfoPopup_Vector_1 = new Vector.<String>(0);
         var _loc2_:IItemListWindow = IItemListWindow(_window.findChildByName("tag_list"));
         _loc2_.destroyListItems();
         _loc10_ = 0;
         while(_loc10_ < UnknownVarFromRoomInfoPopup_GuestRoomData_1.tags.length)
         {
            UnknownVarFromRoomInfoPopup_Vector_1.push(UnknownVarFromRoomInfoPopup_GuestRoomData_1.tags[_loc10_]);
            _loc2_.addListItem(getNewTagItem(UnknownVarFromRoomInfoPopup_GuestRoomData_1.tags[_loc10_],_loc10_));
            _loc10_++;
         }
         clearProperties();
         addProperty("properties","${navigator.roompopup.property.trading}",RoomTradingLevelEnum.getLocalizationKey(UnknownVarFromRoomInfoPopup_GuestRoomData_1.tradeMode));
         if(_navigator.context.configuration.getBoolean("room.ranking.enabled"))
         {
            addProperty("properties","${navigator.roompopup.property.ranking}",UnknownVarFromRoomInfoPopup_GuestRoomData_1.ranking.toString());
         }
         addProperty("properties","${navigator.roompopup.property.max_users}",UnknownVarFromRoomInfoPopup_GuestRoomData_1.maxUserCount.toString());
         IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = "newnavigator_default_room";
         if(_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA"))
         {
            if(UnknownVarFromRoomInfoPopup_GuestRoomData_1.officialRoomPicRef != null)
            {
               if(_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId + ".png";
               }
               else
               {
                  IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = _navigator.getProperty("image.library.url") + UnknownVarFromRoomInfoPopup_GuestRoomData_1.officialRoomPicRef;
               }
            }
            else
            {
               IStaticBitmapWrapperWindow(_window.findChildByName("room_thumbnail")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId + ".png";
            }
         }
         _loc6_.arrangeListItems();
         _loc4_.arrangeListItems();
      }
      
      private function clearProperties() : void
      {
         IItemListWindow(_window.findChildByName("properties")).destroyListItems();
      }
      
      private function addProperty(param1:String, param2:String, param3:String) : void
      {
         var _loc5_:IItemListWindow = IItemListWindow(_window.findChildByName(param1));
         var _loc4_:IWindowController_1 = IWindowController_1(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("property_xml").content)));
         _loc4_.findChildByName("property_name").caption = param2;
         _loc4_.findChildByName("property_value").caption = param3;
         _loc5_.addListItem(_loc4_);
      }
      
      private function getNewTagItem(param1:String, param2:int) : IWindowModel
      {
         var _loc3_:IWindowController_1 = IWindowController_1(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("tag_xml").content)));
         var _loc4_:IRegionWindow = IRegionWindow(_loc3_.findChildByName("tag_region"));
         _loc4_.id = param2;
         _loc4_.procedure = tagRegionProcedure;
         _loc4_.findChildByName("tag_text").caption = "#" + param1;
         return _loc4_;
      }
      
      private function createWindow() : void
      {
         _window = IWindowController_1(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("room_info_popup_bubble_xml").content)));
      }
      
      private function ownerLinkProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.getExtendedProfile(param2.id);
            destroy();
         }
      }
      
      private function groupLinkProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.getGuildInfo(param2.id);
            destroy();
         }
      }
      
      private function reportRegionProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.habboHelp.reportRoom(UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId,UnknownVarFromRoomInfoPopup_GuestRoomData_1.roomName,UnknownVarFromRoomInfoPopup_GuestRoomData_1.description);
            destroy();
         }
      }
      
      private function tagRegionProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.performTagSearch(UnknownVarFromRoomInfoPopup_Vector_1[param2.id]);
            destroy();
         }
      }
      
      private function settingsRegionProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:RoomSettingsCtrl = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl;
            _loc3_.startRoomSettingsEditFromNavigator(UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId,UnknownVarFromRoomInfoPopup_GuestRoomData_1.habboGroupId);
            destroy();
         }
      }
      
      private function roomFavoriteRegionProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(!roomIsFavorite)
            {
               _navigator.communication.connection.send(new AddFavouriteRoomMessageComposer(UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId));
               roomIsFavorite = true;
            }
            else
            {
               _navigator.communication.connection.send(new DeleteFavouriteRoomMessageComposer(UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId));
               roomIsFavorite = false;
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("favorite_icon")).assetUri = "newnavigator_icon_fav_" + (roomIsFavorite ? "yes" : "no");
         }
      }
      
      private function homeRoomRegionProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(!roomIsHome)
            {
               _navigator.communication.connection.send(new UpdateHomeRoomMessageComposer(UnknownVarFromRoomInfoPopup_GuestRoomData_1.flatId));
               roomIsHome = true;
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("home_icon")).assetUri = "newnavigator_icon_home_" + (roomIsHome ? "yes" : "no");
         }
      }
      
      public function refreshHomeState() : void
      {
         UnknownVarFromRoomInfoPopup_Boolean_1 = false;
         if(_window && _window.visible && UnknownVarFromRoomInfoPopup_GuestRoomData_1)
         {
            IStaticBitmapWrapperWindow(_window.findChildByName("home_icon")).assetUri = "newnavigator_icon_home_" + (roomIsHome ? "yes" : "no");
         }
      }
      
      private function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
         }
         _window = null;
      }
   }
}

