package com.sulake.habbo.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.competition.NoOwnedRoomsAlertMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameStartedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.ConvertedRoomIdEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventCancelEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.UserEventCatsEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.RoomFilterSettingsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomForwardMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.BannedUsersFromRoomEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllersEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.MuteAllInRoomEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.ShowEnforceRoomCategoryDialogEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.UserUnbannedFromRoomEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserEventCatsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.CategoriesWithVisitorCountParser;
   import com.sulake.habbo.communication.messages.parser.navigator.ConvertedRoomIdMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.UserEventCatsMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.chat.RoomFilterSettingsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.BannedUsersFromRoomParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllersMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.MuteAllInRoomParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.ShowEnforceRoomCategoryDialogParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.UserUnbannedFromRoomParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.RoomSessionTags;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   [SecureSWF(rename="true")]
   public class IncomingMessages
   {
      private var _navigator:HabboNavigator;
      
      public function IncomingMessages(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var _loc2_:IHabboCommunicationManager = _navigator.communication;
         _loc2_.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo));
         _loc2_.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
         _loc2_.addHabboConnectionMessageEvent(new CantConnectMessageEvent(onCantConnect));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsDataEvent(onRoomSettingsData));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsSaveErrorEvent(onRoomSettingsSaveError));
         _loc2_.addHabboConnectionMessageEvent(new UserFlatCatsEvent(onUserFlatCats));
         _loc2_.addHabboConnectionMessageEvent(new GuestRoomSearchResultEvent(onGuestRoomSearchResult));
         _loc2_.addHabboConnectionMessageEvent(new ShowEnforceRoomCategoryDialogEvent(onEnforceRoomCategorySelection));
         _loc2_.addHabboConnectionMessageEvent(new GenericErrorEvent(onError));
         _loc2_.addHabboConnectionMessageEvent(new ConvertedRoomIdEvent(onConvertedRoomId));
         _loc2_.addHabboConnectionMessageEvent(new RoomRatingEvent(onRoomRating));
         _loc2_.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
         _loc2_.addHabboConnectionMessageEvent(new FlatAccessibleMessageEvent(onDoorOpened));
         _loc2_.addHabboConnectionMessageEvent(new RoomForwardMessageEvent(onRoomForward));
         _loc2_.addHabboConnectionMessageEvent(new CanCreateRoomEvent(onCanCreateRoom));
         _loc2_.addHabboConnectionMessageEvent(new UserEventCatsEvent(onUserEventCats));
         _loc2_.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(onRoomSettingsSaved));
         _loc2_.addHabboConnectionMessageEvent(new FavouriteChangedEvent(onFavouriteChanged));
         _loc2_.addHabboConnectionMessageEvent(new DoorbellMessageEvent(onDoorbell));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsErrorEvent(onRoomSettingsError));
         _loc2_.addHabboConnectionMessageEvent(new NoSuchFlatEvent(onNoSuchFlat));
         _loc2_.addHabboConnectionMessageEvent(new FlatControllerAddedEvent(onFlatControllerAdded));
         _loc2_.addHabboConnectionMessageEvent(new FlatCreatedEvent(onFlatCreated));
         _loc2_.addHabboConnectionMessageEvent(new FlatControllersEvent(onFlatControllers));
         _loc2_.addHabboConnectionMessageEvent(new NavigatorSettingsEvent(onNavigatorSettings));
         _loc2_.addHabboConnectionMessageEvent(new RoomEventCancelEvent(onRoomEventCancel));
         _loc2_.addHabboConnectionMessageEvent(new CanCreateRoomEventEvent(onCanCreateRoomEventEvent));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameStartedMessageEvent(onGameStarted));
         _loc2_.addHabboConnectionMessageEvent(new RoomInfoUpdatedEvent(onRoomInfoUpdated));
         _loc2_.addHabboConnectionMessageEvent(new FavouritesEvent(onFavourites));
         _loc2_.addHabboConnectionMessageEvent(new FlatControllerRemovedEvent(onFlatControllerRemoved));
         _loc2_.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         _loc2_.addHabboConnectionMessageEvent(new OfficialRoomsEvent(onOfficialRooms));
         _loc2_.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
         _loc2_.addHabboConnectionMessageEvent(new NoOwnedRoomsAlertMessageEvent(onNoOwnedRoomsAlert));
         _loc2_.addHabboConnectionMessageEvent(new BannedUsersFromRoomEvent(onBannedUsersFromRoom));
         _loc2_.addHabboConnectionMessageEvent(new RoomFilterSettingsMessageEvent(onRoomFilterSettings));
         _loc2_.addHabboConnectionMessageEvent(new CompetitionRoomsDataMessageEvent(onCompetitionData));
         _loc2_.addHabboConnectionMessageEvent(new PopularRoomTagsResultEvent(onPopularRoomTagsResult));
         _loc2_.addHabboConnectionMessageEvent(new UserUnbannedFromRoomEvent(onUserUnbannedFromRoom));
         _loc2_.addHabboConnectionMessageEvent(new RoomEventEvent(onRoomEventEvent));
         _loc2_.addHabboConnectionMessageEvent(new CategoriesWithVisitorCountEvent(onCategoriesWithUserCount));
         _loc2_.addHabboConnectionMessageEvent(new MuteAllInRoomEvent(onMuteAllEvent));
         _loc2_.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         _loc2_.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
         _loc2_.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
      }
      
      public function get data() : NavigatorData
      {
         return _navigator.data;
      }
      
      private function onMuteAllEvent(param1:IMessageEvent) : void
      {
         var _loc4_:MuteAllInRoomEvent = param1 as MuteAllInRoomEvent;
         var _loc3_:MuteAllInRoomParser = _loc4_.getParser();
         var _loc2_:GuestRoomData = _navigator.data.enteredGuestRoom;
         if(_loc2_ != null)
         {
            _loc2_.allInRoomMuted = _loc3_.allMuted;
            if(_navigator.roomInfoViewCtrl != null)
            {
               _navigator.roomInfoViewCtrl.refreshButtons(_navigator.data.enteredGuestRoom);
            }
         }
      }
      
      private function onNoSuchFlat(param1:IMessageEvent) : void
      {
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectMessageParser = UserObjectEvent(param1).getParser();
         data.avatarId = _loc2_.id;
         _navigator.send(new GetUserFlatCatsMessageComposer());
         _navigator.send(new GetUserEventCatsMessageComposer());
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:UserRightsMessageEvent = UserRightsMessageEvent(param1);
         if(_loc2_.securityLevel >= 5)
         {
            _navigator.data.eventMod = true;
         }
         if(_loc2_.securityLevel >= 7)
         {
            _navigator.data.roomPicker = true;
         }
      }
      
      private function onCategoriesWithUserCount(param1:IMessageEvent) : void
      {
         var _loc2_:CategoriesWithVisitorCountParser = CategoriesWithVisitorCountEvent(param1).getParser();
         data.categoriesWithVisitorData = _loc2_.data;
         Logger.log("Received Categories with user count: " + data.categoriesWithVisitorData.categoryToCurrentUserCountMap.length);
      }
      
      private function onOfficialRooms(param1:IMessageEvent) : void
      {
         var _loc2_:OfficialRoomsMessageParser = OfficialRoomsEvent(param1).getParser();
         data.officialRooms = _loc2_.data;
         data.adRoom = _loc2_.adRoom;
         data.promotedRooms = _loc2_.promotedRooms;
         Logger.log("Received Official rooms: " + data.officialRooms.entries.length);
      }
      
      private function onGuestRoomSearchResult(param1:IMessageEvent) : void
      {
         var _loc2_:GuestRoomSearchResultData = GuestRoomSearchResultEvent(param1).getParser().data;
         data.guestRoomSearchResults = _loc2_;
         Logger.log("Received GuestRoomSearch: " + data.guestRoomSearchResults.rooms.length);
      }
      
      private function onPopularRoomTagsResult(param1:IMessageEvent) : void
      {
         var _loc2_:PopularRoomTagsData = PopularRoomTagsResultEvent(param1).getParser().data;
         data.popularTags = _loc2_;
         Logger.log("Received popular room tags: " + data.popularTags.tags.length);
      }
      
      private function onRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc2_:RoomEventMessageParser = RoomEventEvent(param1).getParser();
         Logger.log("Got room event: " + _loc2_.data.ownerAvatarId + ", " + _loc2_.data.eventName);
         data.roomEventData = _loc2_.data.ownerAvatarId > 0 ? _loc2_.data : null;
         _navigator.roomEventInfoCtrl.refresh();
      }
      
      private function onRoomEventCancel(param1:IMessageEvent) : void
      {
         data.roomEventData = null;
         _navigator.roomEventInfoCtrl.refresh();
      }
      
      private function onCanCreateRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc3_:SimpleAlertView = null;
         var _loc2_:CanCreateRoomEventMessageParser = CanCreateRoomEventEvent(param1).getParser();
         Logger.log("CAN CREATE EVENT: " + _loc2_.canCreateEvent);
         if(_loc2_.canCreateEvent)
         {
            _navigator.roomEventViewCtrl.show();
         }
         else
         {
            _loc3_ = new SimpleAlertView(_navigator,"${navigator.cannotcreateevent.title}","${navigator.cannotcreateevent.error." + _loc2_.errorCode + "}");
            _loc3_.show();
            Logger.log("Cannot create an event just now...");
         }
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
         Logger.log("Navigator: entering room");
         data.onRoomEnter(_loc2_);
         closeOpenCantConnectAlerts();
         _navigator.roomInfoViewCtrl.close();
         _navigator.send(new GetGuestRoomMessageComposer(_loc2_.guestRoomId,true,false));
         Logger.log("Sent get guest room...");
         _navigator.roomEventInfoCtrl.refresh();
         _navigator.roomEventViewCtrl.close();
         _navigator.roomSettingsCtrl.close();
         _navigator.roomFilterCtrl.close();
         HabboWebTools.closeNews();
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc3_:* = false;
         var _loc4_:RoomSessionTags = null;
         var _loc2_:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(param1).getParser();
         Logger.log("Got room info: " + _loc2_.enterRoom + ", " + _loc2_.roomForward);
         if(_loc2_.enterRoom)
         {
            data.enteredRoom = _loc2_.data;
            data.currentRoomIsStaffPick = _loc2_.staffPick;
            _loc3_ = data.createdFlatId == _loc2_.data.flatId;
            if(!_loc3_ && _loc2_.data.displayRoomEntryAd)
            {
               requestRoomEnterAd();
            }
            data.createdFlatId = 0;
            if(data.enteredGuestRoom != null && data.enteredGuestRoom.habboGroupId > 0)
            {
               _navigator.roomEventInfoCtrl.expanded = false;
               _navigator.roomEventInfoCtrl.refresh();
            }
            _loc4_ = _navigator.data.getAndResetSessionTags();
            if(_loc4_ != null)
            {
               _navigator.send(_loc4_.getMsg());
            }
         }
         else if(_loc2_.roomForward)
         {
            if(_loc2_.openingConnection)
            {
               _navigator.goToRoom(_loc2_.data.flatId,false,"",-1,true);
            }
            else if(_loc2_.data.doorMode == 1 && (!_loc2_.isGroupMember && _navigator.sessionData.userName != _loc2_.data.ownerName))
            {
               _navigator.doorbell.show(_loc2_.data);
            }
            else if(_loc2_.data.doorMode == 2 && (_navigator.sessionData.userName != _loc2_.data.ownerName && !_loc2_.isGroupMember))
            {
               _navigator.passwordInput.show(_loc2_.data);
            }
            else
            {
               if(_loc2_.data.doorMode == 4 && !_navigator.sessionData.isAmbassador && !_navigator.sessionData.isRealNoob && !_navigator.sessionData.isAnyRoomController)
               {
                  return;
               }
               _navigator.goToRoom(_loc2_.data.flatId,false);
            }
         }
         else
         {
            data.enteredRoom = _loc2_.data;
            data.currentRoomIsStaffPick = _loc2_.staffPick;
            _navigator.roomInfoViewCtrl.reload();
         }
      }
      
      private function requestRoomEnterAd() : void
      {
         if(_navigator.getProperty("roomenterad.habblet.enabled") == "true")
         {
            HabboWebTools.openRoomEnterAd();
         }
      }
      
      private function onFlatCreated(param1:IMessageEvent) : void
      {
         var _loc2_:FlatCreatedMessageParser = FlatCreatedEvent(param1).getParser();
         ErrorReportStorage.addDebugData("IncomingEvent","Flat created: " + _loc2_.flatId + ", " + _loc2_.flatName);
         data.createdFlatId = _loc2_.flatId;
         _navigator.goToRoom(_loc2_.flatId,true);
         _navigator.mainViewCtrl.reloadRoomList(5);
         _navigator.goToMainView();
         _navigator.closeNavigator();
      }
      
      private function onGameStarted(param1:IMessageEvent) : void
      {
         _navigator.mainViewCtrl.close();
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc2_:ScrSendUserInfoMessageParser = ScrSendUserInfoEvent(param1).getParser();
         Logger.log("Got subscription info: " + _loc2_.productName + ", " + _loc2_.daysToPeriodEnd + ", " + _loc2_.memberPeriods + ", " + _loc2_.periodsSubscribedAhead + ", " + _loc2_.responseType);
         data.hcMember = _loc2_.daysToPeriodEnd > 0;
      }
      
      private function onRoomForward(param1:IMessageEvent) : void
      {
         var _loc2_:RoomForwardMessageParser = RoomForwardMessageEvent(param1).getParser();
         Logger.log("Got room forward: " + _loc2_.roomId);
         forwardToRoom(_loc2_.roomId);
      }
      
      private function onConvertedRoomId(param1:IMessageEvent) : void
      {
         var _loc2_:ConvertedRoomIdMessageParser = ConvertedRoomIdEvent(param1).getParser();
         if(_navigator.webRoomReport)
         {
            _navigator.habboHelp.reportRoom(_loc2_.convertedId,_navigator.webRoomReportedName,"");
         }
         else
         {
            Logger.log("Got converted room ID for " + _loc2_.globalId + ", forward to room " + _loc2_.convertedId);
            forwardToRoom(_loc2_.convertedId);
         }
      }
      
      private function onNavigatorSettings(param1:IMessageEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:* = false;
         var _loc7_:int = 0;
         var _loc5_:Boolean = false;
         var _loc2_:NavigatorSettingsMessageParser = NavigatorSettingsEvent(param1).getParser();
         Logger.log("Got navigator settings: " + _loc2_.homeRoomId);
         var _loc3_:* = !_navigator.data.settingsReceived;
         _navigator.data.homeRoomId = _loc2_.homeRoomId;
         _navigator.data.settingsReceived = true;
         _navigator.mainViewCtrl.refresh();
         var _loc8_:int = -1;
         var _loc9_:int = -1;
         if(_loc3_ && !HabboComponentFlags.isRoomViewerMode(_navigator.flags))
         {
            _loc6_ = false;
            _loc4_ = false;
            if(_navigator.propertyExists("friend.id"))
            {
               _loc8_ = 0;
               _navigator.send(new FollowFriendMessageComposer(int(_navigator.getProperty("friend.id"))));
            }
            if(_navigator.propertyExists("forward.type") && _navigator.propertyExists("forward.id"))
            {
               _loc8_ = int(_navigator.getProperty("forward.type"));
               _loc9_ = int(_navigator.getProperty("forward.id"));
            }
            _loc4_ = _loc2_.roomIdToEnter <= 0;
            if(_loc8_ == 2)
            {
               Logger.log("Guest room forward on enter: " + _loc9_);
               forwardToRoom(_loc9_);
            }
            else if(_loc8_ == -1)
            {
               if(!_loc4_)
               {
                  _loc7_ = _loc2_.roomIdToEnter;
                  if(_loc7_ != _navigator.data.homeRoomId)
                  {
                     this._navigator.goToRoom(_loc7_,true);
                  }
                  else
                  {
                     _loc5_ = this._navigator.goToHomeRoom();
                     if(!_loc5_)
                     {
                        _loc6_ = true;
                     }
                  }
               }
            }
            if(_loc6_ && !_navigator.mainViewCtrl.isOpen())
            {
               _navigator.mainViewCtrl.onNavigatorToolBarIconClick();
            }
         }
         else
         {
            _navigator.roomInfoViewCtrl.reload();
         }
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         Logger.log("Navigator: exiting room");
         data.onRoomExit();
         _navigator.roomInfoViewCtrl.close();
         _navigator.roomEventInfoCtrl.close();
         _navigator.roomEventViewCtrl.close();
         _navigator.roomSettingsCtrl.close();
         _navigator.roomFilterCtrl.close();
         var _loc2_:Boolean = _navigator.getBoolean("news.auto_popup.enabled");
         if(_loc2_)
         {
            HabboWebTools.openNews();
         }
      }
      
      private function onUserFlatCats(param1:IMessageEvent) : void
      {
         var _loc3_:UserFlatCatsMessageParser = (param1 as UserFlatCatsEvent).getParser();
         _navigator.data.categories = _loc3_.nodes;
         var _loc2_:RoomsTabPageDecorator = RoomsTabPageDecorator(_navigator.tabs.getTab(2).tabPageDecorator);
         _loc2_.prepareRoomCategories();
      }
      
      private function onUserEventCats(param1:IMessageEvent) : void
      {
         var _loc2_:UserEventCatsMessageParser = (param1 as UserEventCatsEvent).getParser();
         _navigator.data.eventCategories = _loc2_.eventCategories;
      }
      
      private function onRoomSettingsData(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsDataMessageParser = null;
         try
         {
            _loc2_ = (param1 as RoomSettingsDataEvent).getParser();
            _navigator.roomSettingsCtrl.onRoomSettings(_loc2_.data);
            Logger.log("GOT ROOM SETTINGS DATA: " + _loc2_.data.name + ", " + _loc2_.data.maximumVisitors + ", " + _loc2_.data.maximumVisitorsLimit);
         }
         catch(e:Error)
         {
            Logger.log("CRASHED WHILE PROCESSING ROOM SETTINGS DATA!");
         }
      }
      
      private function onRoomFilterSettings(param1:IMessageEvent) : void
      {
         var _loc2_:RoomFilterSettingsMessageParser = (param1 as RoomFilterSettingsMessageEvent).getParser();
         _navigator.roomFilterCtrl.onRoomFilterSettings(_loc2_.badWords);
         Logger.log("GOT ROOM FILTER SETTINGS: " + _loc2_.badWords);
      }
      
      private function onRoomSettingsError(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsErrorMessageParser = (param1 as RoomSettingsErrorEvent).getParser();
      }
      
      private function onRoomSettingsSaved(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsSavedMessageParser = (param1 as RoomSettingsSavedEvent).getParser();
         ErrorReportStorage.addDebugData("IncomingEvent","Room settings saved: " + _loc2_.roomId);
         _navigator.mainViewCtrl.reloadRoomList(5);
      }
      
      private function onRoomSettingsSaveError(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsSaveErrorMessageParser = (param1 as RoomSettingsSaveErrorEvent).getParser();
         _navigator.roomSettingsCtrl.onRoomSettingsSaveError(_loc2_.roomId,_loc2_.errorCode,_loc2_.info);
      }
      
      private function onRoomInfoUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:RoomInfoUpdatedMessageParser = (param1 as RoomInfoUpdatedEvent).getParser();
         Logger.log("ROOM UPDATED: " + _loc2_.flatId);
         _navigator.send(new GetGuestRoomMessageComposer(_loc2_.flatId,false,false));
      }
      
      private function onFavourites(param1:IMessageEvent) : void
      {
         var _loc2_:FavouritesMessageParser = (param1 as FavouritesEvent).getParser();
         _navigator.data.onFavourites(_loc2_);
      }
      
      private function onFavouriteChanged(param1:IMessageEvent) : void
      {
         var _loc2_:FavouriteChangedMessageParser = (param1 as FavouriteChangedEvent).getParser();
         Logger.log("Received favourite changed: " + _loc2_.flatId + ", " + _loc2_.added);
         _navigator.data.favouriteChanged(_loc2_.flatId,_loc2_.added);
         _navigator.roomInfoViewCtrl.reload();
         _navigator.mainViewCtrl.refresh();
      }
      
      private function onCanCreateRoom(param1:IMessageEvent) : void
      {
         var _loc2_:AlertView = null;
         var _loc3_:CanCreateRoomMessageParser = (param1 as CanCreateRoomEvent).getParser();
         Logger.log("Can create room: " + _loc3_.resultCode + ", " + _loc3_.roomLimit);
         if(_loc3_.resultCode == 0)
         {
            _navigator.roomCreateViewCtrl.show();
         }
         else
         {
            _navigator.registerParameter("navigator.createroom.limitreached","limit","" + _loc3_.roomLimit);
            if(_navigator.sessionData.hasVip)
            {
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.createroom.error}","${navigator.createroom.limitreached}");
            }
            else
            {
               _loc2_ = new ClubPromoAlertView(_navigator,"${navigator.createroom.error}","${navigator.createroom.limitreached}","${navigator.createroom.vippromo}");
            }
            _loc2_.show();
         }
      }
      
      private function onFlatControllers(param1:IMessageEvent) : void
      {
         var _loc2_:FlatControllersMessageParser = (param1 as FlatControllersEvent).getParser();
         Logger.log("Got flat controllers: " + _loc2_.roomId + ", " + _loc2_.controllers.length);
         _navigator.roomSettingsCtrl.onFlatControllers(_loc2_.roomId,_loc2_.controllers);
      }
      
      private function onFlatControllerAdded(param1:IMessageEvent) : void
      {
         var _loc2_:FlatControllerAddedMessageParser = (param1 as FlatControllerAddedEvent).getParser();
         Logger.log("Flat controller added: " + _loc2_.flatId + ", " + _loc2_.data.userId + ", " + _loc2_.data.userName);
         _navigator.roomSettingsCtrl.onFlatControllerAdded(_loc2_.flatId,_loc2_.data);
      }
      
      private function onFlatControllerRemoved(param1:IMessageEvent) : void
      {
         var _loc2_:FlatControllerRemovedMessageParser = (param1 as FlatControllerRemovedEvent).getParser();
         Logger.log("Flat controller removed: " + _loc2_.flatId + ", " + _loc2_.userId);
         _navigator.roomSettingsCtrl.onFlatControllerRemoved(_loc2_.flatId,_loc2_.userId);
      }
      
      private function onBannedUsersFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:BannedUsersFromRoomParser = (param1 as BannedUsersFromRoomEvent).getParser();
         Logger.log("Got Banned users for room: " + _loc2_.roomId + ", " + _loc2_.bannedUsers.length);
         _navigator.roomSettingsCtrl.onBannedUsersFromRoom(_loc2_.roomId,_loc2_.bannedUsers);
      }
      
      private function onUserUnbannedFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:UserUnbannedFromRoomParser = (param1 as UserUnbannedFromRoomEvent).getParser();
         Logger.log("User was unbanned from room. User Id: " + _loc2_.userId + " Room Id: " + _loc2_.roomId);
         _navigator.roomSettingsCtrl.onUserUnbannedFromRoom(_loc2_.roomId,_loc2_.userId);
      }
      
      private function onError(param1:IMessageEvent) : void
      {
         var event:IMessageEvent = param1;
         var error:GenericErrorEvent = event as GenericErrorEvent;
         if(error == null)
         {
            return;
         }
         switch(error.getParser().errorCode)
         {
            case -100002:
               _navigator.passwordInput.showRetry();
               break;
            case 4009:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.need.to.be.vip}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               break;
            case 4010:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.invalid_room_name}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               break;
            case 4011:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.cannot_perm_ban}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               break;
            case 4013:
               _navigator.windowManager.alert("${generic.alert.title}","${navigator.alert.room_in_maintenance}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               break;
            case -100005:
               _navigator.windowManager.alert("${generic.alert.title}","${notification.nft_token_required}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
         }
      }
      
      private function onDoorbell(param1:IMessageEvent) : void
      {
         var _loc2_:DoorbellMessageEvent = param1 as DoorbellMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.userName != "")
         {
            return;
         }
         _navigator.doorbell.showWaiting();
      }
      
      private function onDoorOpened(param1:IMessageEvent) : void
      {
         var _loc3_:FlatAccessibleMessageEvent = param1 as FlatAccessibleMessageEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:FlatAccessibleMessageParser = _loc3_.getParser();
         if(_loc2_ != null && (_loc2_.userName == null || _loc2_.userName.length == 0))
         {
            _navigator.doorbell.hide();
         }
      }
      
      private function onRoomRating(param1:IMessageEvent) : void
      {
         var _loc2_:RoomRatingMessageParser = (param1 as RoomRatingEvent).getParser();
         _navigator.data.currentRoomRating = _loc2_.rating;
         _navigator.data.canRate = _loc2_.canRate;
         this._navigator.roomInfoViewCtrl.reload();
      }
      
      private function onFlatAccessDenied(param1:IMessageEvent) : void
      {
         var _loc2_:FlatAccessDeniedMessageParser = (param1 as FlatAccessDeniedMessageEvent).getParser();
         if(_loc2_.userName == null || _loc2_.userName == "")
         {
            _navigator.doorbell.showNoAnswer();
         }
      }
      
      private function onFriendsListFragment(param1:IMessageEvent) : void
      {
         _navigator.data.friendList.onFriendsListFragment(param1);
      }
      
      private function onFriendListUpdate(param1:IMessageEvent) : void
      {
         _navigator.data.friendList.onFriendListUpdate(param1);
         _navigator.roomSettingsCtrl.onFriendListUpdate();
      }
      
      private function onCompetitionData(param1:CompetitionRoomsDataMessageEvent) : void
      {
         _navigator.data.competitionRoomsData = param1.getParser().data;
      }
      
      private function forwardToRoom(param1:int) : void
      {
         _navigator.send(new GetGuestRoomMessageComposer(param1,false,true));
         _navigator.trackNavigationDataPoint("Room Forward","go.roomforward","",param1);
      }
      
      private function onNoOwnedRoomsAlert(param1:NoOwnedRoomsAlertMessageEvent) : void
      {
         _navigator.startRoomCreation();
      }
      
      private function closeOpenCantConnectAlerts() : void
      {
         var _loc1_:Array = null;
         var _loc7_:IWindowContext_3 = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:IWindowModel = null;
         var _loc3_:AlertView = null;
         if(_navigator != null)
         {
            _loc1_ = [];
            _loc7_ = _navigator.windowManager.getWindowContext(2);
            _loc4_ = int(_loc7_.getDesktopWindow().numChildren);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc7_.getDesktopWindow().getChildAt(_loc5_);
               if(_loc6_.tags.indexOf("SimpleAlertView") > -1)
               {
                  _loc1_.push(_loc6_);
               }
               _loc5_++;
            }
            if(_loc1_.length > 0)
            {
               for each(var _loc2_ in _loc1_)
               {
                  _loc3_ = AlertView.findAlertView(_loc2_);
                  if(_loc3_ != null)
                  {
                     _loc3_.dispose();
                  }
               }
            }
         }
      }
      
      private function onCantConnect(param1:IMessageEvent) : void
      {
         var _loc2_:SimpleAlertView = null;
         var _loc3_:CantConnectMessageParser = (param1 as CantConnectMessageEvent).getParser();
         Logger.log("FAILED TO CONNECT: REASON: " + _loc3_.reason);
         switch(_loc3_.reason - 1)
         {
            case 0:
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.guestroomfull.title}","${navigator.guestroomfull.text}");
               _loc2_.show();
               break;
            case 2:
               _loc2_ = new SimpleAlertView(_navigator,"${room.queue.error.title}","${room.queue.error." + _loc3_.parameter + "}");
               _loc2_.show();
               break;
            case 3:
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.banned.title}","${navigator.banned.text}");
               _loc2_.show();
               break;
            case 4:
               _loc2_ = new SimpleAlertView(_navigator,"${navigator.blocked.title}","${navigator.blocked.text}");
               _loc2_.show();
               break;
            default:
               _loc2_ = new SimpleAlertView(_navigator,"${room.queue.error.title}","${room.queue.error.title}");
               _loc2_.show();
         }
         _navigator.send(new QuitMessageComposer());
         var _loc4_:HabboToolbarEvent = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
         _loc4_.iconId = "HTIE_ICON_RECEPTION";
         _navigator.toolbar.events.dispatchEvent(_loc4_);
      }
      
      private function onEnforceRoomCategorySelection(param1:IMessageEvent) : void
      {
         var _loc2_:ShowEnforceRoomCategoryDialogParser = (param1 as ShowEnforceRoomCategoryDialogEvent).getParser();
         _navigator.enforceCategoryCtrl.show(_loc2_.selectionType);
      }
   }
}

