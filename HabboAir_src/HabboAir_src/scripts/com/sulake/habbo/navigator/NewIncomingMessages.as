package com.sulake.habbo.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.competition.NoOwnedRoomsAlertMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsDataMessageEvent;
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
   import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorCollapsedCategoriesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorLiftedRoomsEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorMetaDataEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorSavedSearchesEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.NavigatorSearchResultBlocksEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.NewNavigatorPreferencesEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;
   import com.sulake.habbo.communication.messages.incoming.room.chat.RoomFilterSettingsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
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
   import com.sulake.habbo.communication.messages.incoming.roomsettings.UserUnbannedFromRoomEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserEventCatsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.CategoriesWithVisitorCountParser;
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
   import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.BannedUsersFromRoomParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllersMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.MuteAllInRoomParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.UserUnbannedFromRoomParser;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.navigator.transitional.LegacyNavigator;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   [SecureSWF(rename="true")]
   public class NewIncomingMessages
   {
      private var _navigator:HabboNewNavigator;
      
      private var _messageListeners:Array = [];
      
      public function NewIncomingMessages(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         var _loc2_:IHabboCommunicationManager = _navigator.communication;
         addMessageListeners();
      }
      
      public function addMessageListeners() : void
      {
         var _loc1_:IHabboCommunicationManager = _navigator.communication;
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new CategoriesWithVisitorCountEvent(onCategoriesWithUserCount)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomEventEvent(onRoomEventEvent)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FavouritesEvent(onFavourites)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new CanCreateRoomEventEvent(onCanCreateRoomEventEvent)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FlatControllerAddedEvent(onFlatControllerAdded)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new NoOwnedRoomsAlertMessageEvent(onNoOwnedRoomsAlert)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FlatControllerRemovedEvent(onFlatControllerRemoved)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new NavigatorMetaDataEvent(onNavigatorMetaData)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new NavigatorLiftedRoomsEvent(onNavigatorLiftedRooms)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomExit)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomSettingsSaveErrorEvent(onRoomSettingsSaveError)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(onRoomSettingsSaved)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomFilterSettingsMessageEvent(onRoomFilterSettings)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new NavigatorSettingsEvent(onNavigatorSettings)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new OfficialRoomsEvent(onOfficialRooms)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new UserFlatCatsEvent(onUserFlatCats)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomSettingsDataEvent(onRoomSettingsData)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FlatControllersEvent(onFlatControllers)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new DoorbellMessageEvent(onDoorbell)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomInfoUpdatedEvent(onRoomInfoUpdated)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new GuestRoomSearchResultEvent(onGuestRoomSearchResult)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FavouriteChangedEvent(onFavouriteChanged)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new CompetitionRoomsDataMessageEvent(onCompetitionData)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new NavigatorSavedSearchesEvent(onSavedSearches)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new NavigatorSearchResultBlocksEvent(onNavigatorSearchResultBlocks)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new NewNavigatorPreferencesEvent(onNavigatorPreferences)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomSettingsErrorEvent(onRoomSettingsError)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new NavigatorCollapsedCategoriesMessageEvent(onCollapsedCategories)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomEventCancelEvent(onRoomEventCancel)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new UserEventCatsEvent(onUserEventCats)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FlatAccessibleMessageEvent(onDoorOpened)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new NoSuchFlatEvent(onNoSuchFlat)));
         _messageListeners.push(_loc1_.connection.addMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new PopularRoomTagsResultEvent(onPopularRoomTagsResult)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new CantConnectMessageEvent(onCantConnect)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new MuteAllInRoomEvent(onMuteAllEvent)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new BannedUsersFromRoomEvent(onBannedUsersFromRoom)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new UserUnbannedFromRoomEvent(onUserUnbannedFromRoom)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new FlatCreatedEvent(onFlatCreated)));
         _messageListeners.push(_loc1_.addHabboConnectionMessageEvent(new RoomRatingEvent(onRoomRating)));
      }
      
      public function removeLegacyMessageListeners() : void
      {
         var _loc1_:IHabboCommunicationManager = _navigator.communication;
         for each(var _loc2_ in _messageListeners)
         {
            _loc1_.removeHabboConnectionMessageEvent(_loc2_);
         }
         _messageListeners = [];
      }
      
      private function onNavigatorMetaData(param1:NavigatorMetaDataEvent) : void
      {
         _navigator.initialize(param1.getParser());
      }
      
      private function onNavigatorSearchResultBlocks(param1:NavigatorSearchResultBlocksEvent) : void
      {
         _navigator.onSearchResult(new SearchResultContainer(param1.getParser().searchResult));
      }
      
      private function onNavigatorLiftedRooms(param1:NavigatorLiftedRoomsEvent) : void
      {
         _navigator.onLiftedRooms(param1.getParser());
      }
      
      private function onNavigatorPreferences(param1:NewNavigatorPreferencesEvent) : void
      {
         _navigator.onPreferences(param1.getParser());
      }
      
      private function onSavedSearches(param1:NavigatorSavedSearchesEvent) : void
      {
         _navigator.onSavedSearches(param1.getParser());
      }
      
      private function onGroupDetails(param1:HabboGroupDetailsMessageEvent) : void
      {
         _navigator.onGroupDetails(param1.data);
      }
      
      private function onCollapsedCategories(param1:NavigatorCollapsedCategoriesMessageEvent) : void
      {
         _navigator.onCollapsedCategories(param1.getParser().collapsedCategories);
      }
      
      private function get data() : NavigatorData
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
            if(LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl != null)
            {
               LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.refreshButtons(_navigator.data.enteredGuestRoom);
            }
         }
      }
      
      private function onNoSuchFlat(param1:IMessageEvent) : void
      {
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectMessageParser = UserObjectEvent(param1).getParser();
         _navigator.data.avatarId = _loc2_.id;
         LegacyNavigator(_navigator.legacyNavigator).send(new GetUserFlatCatsMessageComposer());
         LegacyNavigator(_navigator.legacyNavigator).send(new GetUserEventCatsMessageComposer());
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:UserRightsMessageEvent = null;
         if(_navigator)
         {
            _loc2_ = UserRightsMessageEvent(param1);
            if(_loc2_.securityLevel >= 5)
            {
               _navigator.data.eventMod = true;
            }
            if(_loc2_.securityLevel >= 7)
            {
               _navigator.data.roomPicker = true;
            }
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
         Logger.log("Received GuestRoomSearch: " + (!!data.guestRoomSearchResults.rooms ? data.guestRoomSearchResults.rooms.length : " no rooms"));
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
         LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.refresh();
      }
      
      private function onRoomEventCancel(param1:IMessageEvent) : void
      {
         data.roomEventData = null;
         LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.refresh();
      }
      
      private function onCanCreateRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc3_:SimpleAlertView = null;
         var _loc2_:CanCreateRoomEventMessageParser = CanCreateRoomEventEvent(param1).getParser();
         Logger.log("CAN CREATE EVENT: " + _loc2_.canCreateEvent);
         if(_loc2_.canCreateEvent)
         {
            LegacyNavigator(_navigator.legacyNavigator).roomEventViewCtrl.show();
         }
         else
         {
            _loc3_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.cannotcreateevent.title}","${navigator.cannotcreateevent.error." + _loc2_.errorCode + "}");
            _loc3_.show();
            Logger.log("Cannot create an event just now...");
         }
      }
      
      private function onRoomInfo(param1:GetGuestRoomResultEvent) : void
      {
         var _loc2_:GetGuestRoomResultMessageParser = param1.getParser();
         if(!_loc2_.enterRoom && !_loc2_.roomForward)
         {
            _navigator.onRoomInfo(_loc2_.data);
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
         LegacyNavigator(_navigator.legacyNavigator).goToRoom(_loc2_.flatId,true);
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.reloadRoomList(5);
         LegacyNavigator(_navigator.legacyNavigator).goToMainView();
         LegacyNavigator(_navigator.legacyNavigator).closeNavigator();
      }
      
      private function onGameStarted(param1:IMessageEvent) : void
      {
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.close();
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         Logger.log("Navigator: exiting room");
         data.onRoomExit();
         LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomEventInfoCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomEventViewCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.close();
         LegacyNavigator(_navigator.legacyNavigator).roomFilterCtrl.close();
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
         var _loc2_:RoomsTabPageDecorator = RoomsTabPageDecorator(LegacyNavigator(_navigator.legacyNavigator).tabs.getTab(2).tabPageDecorator);
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
            LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onRoomSettings(_loc2_.data);
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
         LegacyNavigator(_navigator.legacyNavigator).roomFilterCtrl.onRoomFilterSettings(_loc2_.badWords);
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
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.reloadRoomList(5);
      }
      
      private function onRoomSettingsSaveError(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsSaveErrorMessageParser = (param1 as RoomSettingsSaveErrorEvent).getParser();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onRoomSettingsSaveError(_loc2_.roomId,_loc2_.errorCode,_loc2_.info);
      }
      
      private function onRoomInfoUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:RoomInfoUpdatedMessageParser = (param1 as RoomInfoUpdatedEvent).getParser();
         LegacyNavigator(_navigator.legacyNavigator).send(new GetGuestRoomMessageComposer(_loc2_.flatId,false,false));
      }
      
      private function onFavourites(param1:IMessageEvent) : void
      {
         var _loc2_:FavouritesMessageParser = (param1 as FavouritesEvent).getParser();
         _navigator.data.onFavourites(_loc2_);
      }
      
      private function onFavouriteChanged(param1:IMessageEvent) : void
      {
         var _loc2_:FavouriteChangedMessageParser = (param1 as FavouriteChangedEvent).getParser();
         data.favouriteChanged(_loc2_.flatId,_loc2_.added);
         LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.reload();
         LegacyNavigator(_navigator.legacyNavigator).mainViewCtrl.refresh();
      }
      
      private function onNavigatorSettings(param1:IMessageEvent) : void
      {
         var _loc2_:NavigatorSettingsMessageParser = (param1 as NavigatorSettingsEvent).getParser();
         data.homeRoomId = _loc2_.homeRoomId;
         data.settingsReceived = true;
         _navigator.view.refreshRoomInfoBubbleHomeState();
         LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.reload();
      }
      
      private function onFlatControllers(param1:IMessageEvent) : void
      {
         var _loc2_:FlatControllersMessageParser = (param1 as FlatControllersEvent).getParser();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllers(_loc2_.roomId,_loc2_.controllers);
      }
      
      private function onFlatControllerAdded(param1:IMessageEvent) : void
      {
         var _loc2_:FlatControllerAddedMessageParser = (param1 as FlatControllerAddedEvent).getParser();
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllerAdded(_loc2_.flatId,_loc2_.data);
      }
      
      private function onFlatControllerRemoved(param1:IMessageEvent) : void
      {
         var _loc2_:FlatControllerRemovedMessageParser = (param1 as FlatControllerRemovedEvent).getParser();
         Logger.log("Flat controller removed: " + _loc2_.flatId + ", " + _loc2_.userId);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFlatControllerRemoved(_loc2_.flatId,_loc2_.userId);
      }
      
      private function onBannedUsersFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:BannedUsersFromRoomParser = (param1 as BannedUsersFromRoomEvent).getParser();
         Logger.log("Got Banned users for room: " + _loc2_.roomId + ", " + _loc2_.bannedUsers.length);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onBannedUsersFromRoom(_loc2_.roomId,_loc2_.bannedUsers);
      }
      
      private function onUserUnbannedFromRoom(param1:IMessageEvent) : void
      {
         var _loc2_:UserUnbannedFromRoomParser = (param1 as UserUnbannedFromRoomEvent).getParser();
         Logger.log("User was unbanned from room. User Id: " + _loc2_.userId + " Room Id: " + _loc2_.roomId);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onUserUnbannedFromRoom(_loc2_.roomId,_loc2_.userId);
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
         LegacyNavigator(_navigator.legacyNavigator).doorbell.showWaiting();
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
            LegacyNavigator(_navigator.legacyNavigator).doorbell.hide();
         }
      }
      
      private function onRoomRating(param1:IMessageEvent) : void
      {
         var _loc2_:RoomRatingMessageParser = (param1 as RoomRatingEvent).getParser();
         data.currentRoomRating = _loc2_.rating;
         data.canRate = _loc2_.canRate;
         LegacyNavigator(_navigator.legacyNavigator).roomInfoViewCtrl.reload();
      }
      
      private function onFlatAccessDenied(param1:IMessageEvent) : void
      {
         var _loc2_:FlatAccessDeniedMessageParser = (param1 as FlatAccessDeniedMessageEvent).getParser();
         if(_loc2_.userName == null || _loc2_.userName == "")
         {
            LegacyNavigator(_navigator.legacyNavigator).doorbell.showNoAnswer();
         }
      }
      
      private function onFriendsListFragment(param1:IMessageEvent) : void
      {
         data.friendList.onFriendsListFragment(param1);
      }
      
      private function onFriendListUpdate(param1:IMessageEvent) : void
      {
         data.friendList.onFriendListUpdate(param1);
         LegacyNavigator(_navigator.legacyNavigator).roomSettingsCtrl.onFriendListUpdate();
      }
      
      private function onCompetitionData(param1:CompetitionRoomsDataMessageEvent) : void
      {
         data.competitionRoomsData = param1.getParser().data;
      }
      
      private function forwardToRoom(param1:int) : void
      {
         LegacyNavigator(_navigator.legacyNavigator).send(new GetGuestRoomMessageComposer(param1,false,true));
         LegacyNavigator(_navigator.legacyNavigator).trackNavigationDataPoint("Room Forward","go.roomforward","",param1);
      }
      
      private function onNoOwnedRoomsAlert(param1:NoOwnedRoomsAlertMessageEvent) : void
      {
         LegacyNavigator(_navigator.legacyNavigator).startRoomCreation();
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
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.guestroomfull.title}","${navigator.guestroomfull.text}");
               _loc2_.show();
               break;
            case 2:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${room.queue.error.title}","${room.queue.error." + _loc3_.parameter + "}");
               _loc2_.show();
               break;
            case 3:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.banned.title}","${navigator.banned.text}");
               _loc2_.show();
               break;
            case 4:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${navigator.blocked.title}","${navigator.blocked.text}");
               _loc2_.show();
               break;
            default:
               _loc2_ = new SimpleAlertView(LegacyNavigator(_navigator.legacyNavigator),"${room.queue.error.title}","${room.queue.error.title}");
               _loc2_.show();
         }
         LegacyNavigator(_navigator.legacyNavigator).send(new QuitMessageComposer());
         var _loc4_:HabboToolbarEvent = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
         _loc4_.iconId = "HTIE_ICON_RECEPTION";
         LegacyNavigator(_navigator.legacyNavigator).toolbar.events.dispatchEvent(_loc4_);
      }
   }
}

