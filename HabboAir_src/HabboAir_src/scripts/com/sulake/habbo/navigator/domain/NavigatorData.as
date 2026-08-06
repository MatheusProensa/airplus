package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.communication.messages.incoming.navigator.*;
   import com.sulake.habbo.communication.messages.parser.navigator.*;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.navigator.*;
   import com.sulake.habbo.navigator.roomsettings.FriendList;
   import flash.utils.Dictionary;
   
   public class NavigatorData
   {
      private static const MAX_HISTORY_LENGTH:int = 10;
      
      private var _navigator:HabboNavigator;
      
      private var _lastMsg:UnknownIHabboCommunicationMessagesIncomingNavigator1;
      
      private var _roomEventData:RoomEventData;
      
      private var _eventMod:Boolean;
      
      private var _roomPicker:Boolean;
      
      private var _currentRoomOwner:Boolean;
      
      private var _currentRoomId:int;
      
      private var _avatarId:int;
      
      private var _enteredGuestRoom:GuestRoomData;
      
      private var _hcMember:Boolean;
      
      private var _createdFlatId:int;
      
      private var _hotRoomPopupOpen:Boolean;
      
      private var _homeRoomId:int;
      
      private var _settingsReceived:Boolean;
      
      private var _allCategories:Array = [];
      
      private var _visibleCategories:Array = [];
      
      private var _allEventCategories:Array = [];
      
      private var _visibleEventCategories:Array = [];
      
      private var _favouriteLimit:int;
      
      private var UnknownVarFromNavigatorData_Int_1:int;
      
      private var UnknownVarFromNavigatorData_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromNavigatorData_Boolean_1:Boolean;
      
      private var _currentRoomRating:int;
      
      private var _canRate:Boolean;
      
      private var _currentRoomIsStaffPick:Boolean;
      
      private var _adIndex:int = 0;
      
      private var _adRoom:OfficialRoomEntryData;
      
      private var _promotedRooms:PromotedRoomsData;
      
      private var _friendList:FriendList = new FriendList();
      
      private var UnknownVarFromNavigatorData_RoomSessionTags_1:RoomSessionTags;
      
      private var _competitionRoomsData:CompetitionRoomsData;
      
      public function NavigatorData(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function get canAddFavourite() : Boolean
      {
         return _enteredGuestRoom != null && !_currentRoomOwner;
      }
      
      public function get canEditRoomSettings() : Boolean
      {
         return _enteredGuestRoom != null && (_currentRoomOwner || _navigator.sessionData.hasSecurity(5));
      }
      
      public function onRoomEnter(param1:RoomEntryInfoMessageParser) : void
      {
         _enteredGuestRoom = null;
         _currentRoomOwner = false;
         _currentRoomOwner = param1.owner;
         _currentRoomId = param1.guestRoomId;
      }
      
      public function onRoomExit() : void
      {
         if(_roomEventData != null)
         {
            _roomEventData.dispose();
            _roomEventData = null;
         }
         if(_enteredGuestRoom != null)
         {
            _enteredGuestRoom.dispose();
            _enteredGuestRoom = null;
         }
         _currentRoomOwner = false;
      }
      
      public function set enteredRoom(param1:GuestRoomData) : void
      {
         if(_enteredGuestRoom != null)
         {
            _enteredGuestRoom.dispose();
         }
         _enteredGuestRoom = param1;
      }
      
      public function set roomEventData(param1:RoomEventData) : void
      {
         if(_roomEventData != null)
         {
            _roomEventData.dispose();
         }
         _roomEventData = param1;
      }
      
      public function get popularTagsArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as PopularRoomTagsData != null;
      }
      
      public function get guestRoomSearchArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as GuestRoomSearchResultData != null;
      }
      
      public function get officialRoomsArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as OfficialRoomsData != null;
      }
      
      public function get categoriesWithUserCountArrived() : Boolean
      {
         return _lastMsg != null && _lastMsg as CategoriesWithVisitorCountData != null;
      }
      
      public function set guestRoomSearchResults(param1:GuestRoomSearchResultData) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         _adRoom = param1.ad;
         UnknownVarFromNavigatorData_Boolean_1 = false;
      }
      
      public function set popularTags(param1:PopularRoomTagsData) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         UnknownVarFromNavigatorData_Boolean_1 = false;
      }
      
      public function set officialRooms(param1:OfficialRoomsData) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         UnknownVarFromNavigatorData_Boolean_1 = false;
      }
      
      public function set categoriesWithVisitorData(param1:CategoriesWithVisitorCountData) : void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         UnknownVarFromNavigatorData_Boolean_1 = false;
      }
      
      private function disposeCurrentMsg() : void
      {
         if(_lastMsg == null)
         {
            return;
         }
         _lastMsg.dispose();
         _lastMsg = null;
      }
      
      public function set adRoom(param1:OfficialRoomEntryData) : void
      {
         _adRoom = param1;
      }
      
      public function set promotedRooms(param1:PromotedRoomsData) : void
      {
         _promotedRooms = param1;
      }
      
      public function get adRoom() : OfficialRoomEntryData
      {
         return _adRoom;
      }
      
      public function get guestRoomSearchResults() : GuestRoomSearchResultData
      {
         return _lastMsg as GuestRoomSearchResultData;
      }
      
      public function get popularTags() : PopularRoomTagsData
      {
         return _lastMsg as PopularRoomTagsData;
      }
      
      public function get officialRooms() : OfficialRoomsData
      {
         return _lastMsg as OfficialRoomsData;
      }
      
      public function get categoriesWithVisitorData() : CategoriesWithVisitorCountData
      {
         return _lastMsg as CategoriesWithVisitorCountData;
      }
      
      public function get promotedRooms() : PromotedRoomsData
      {
         return _promotedRooms;
      }
      
      public function get roomEventData() : RoomEventData
      {
         return _roomEventData;
      }
      
      public function get avatarId() : int
      {
         return _avatarId;
      }
      
      public function get eventMod() : Boolean
      {
         return _eventMod;
      }
      
      public function get roomPicker() : Boolean
      {
         return _roomPicker;
      }
      
      public function get currentRoomOwner() : Boolean
      {
         return _currentRoomOwner;
      }
      
      public function get enteredGuestRoom() : GuestRoomData
      {
         return _enteredGuestRoom;
      }
      
      public function get hcMember() : Boolean
      {
         return _hcMember;
      }
      
      public function get createdFlatId() : int
      {
         return _createdFlatId;
      }
      
      public function get homeRoomId() : int
      {
         return _homeRoomId;
      }
      
      public function get hotRoomPopupOpen() : Boolean
      {
         return _hotRoomPopupOpen;
      }
      
      public function get currentRoomRating() : int
      {
         return _currentRoomRating;
      }
      
      public function get canRate() : Boolean
      {
         return _canRate;
      }
      
      public function get settingsReceived() : Boolean
      {
         return _settingsReceived;
      }
      
      public function get adIndex() : int
      {
         return _adIndex;
      }
      
      public function get currentRoomIsStaffPick() : Boolean
      {
         return _currentRoomIsStaffPick;
      }
      
      public function get currentRoomId() : int
      {
         return _currentRoomId;
      }
      
      public function set avatarId(param1:int) : void
      {
         _avatarId = param1;
      }
      
      public function set createdFlatId(param1:int) : void
      {
         _createdFlatId = param1;
      }
      
      public function set hcMember(param1:Boolean) : void
      {
         _hcMember = param1;
      }
      
      public function set eventMod(param1:Boolean) : void
      {
         _eventMod = param1;
      }
      
      public function set roomPicker(param1:Boolean) : void
      {
         _roomPicker = param1;
      }
      
      public function set hotRoomPopupOpen(param1:Boolean) : void
      {
         _hotRoomPopupOpen = param1;
      }
      
      public function set homeRoomId(param1:int) : void
      {
         _homeRoomId = param1;
      }
      
      public function set currentRoomRating(param1:int) : void
      {
         _currentRoomRating = param1;
      }
      
      public function set canRate(param1:Boolean) : void
      {
         _canRate = param1;
      }
      
      public function set settingsReceived(param1:Boolean) : void
      {
         _settingsReceived = param1;
      }
      
      public function set adIndex(param1:int) : void
      {
         _adIndex = param1;
      }
      
      public function set currentRoomIsStaffPick(param1:Boolean) : void
      {
         _currentRoomIsStaffPick = param1;
      }
      
      public function set categories(param1:Array) : void
      {
         _allCategories = param1;
         _visibleCategories = [];
         for each(var _loc2_ in _allCategories)
         {
            if(_loc2_.visible)
            {
               _visibleCategories.push(_loc2_);
            }
         }
      }
      
      public function get allCategories() : Array
      {
         return _allCategories;
      }
      
      public function get visibleCategories() : Array
      {
         return _visibleCategories;
      }
      
      public function getCategoryById(param1:int) : FlatCategory
      {
         for each(var _loc2_ in _allCategories)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function set eventCategories(param1:Array) : void
      {
         _allEventCategories = param1;
         _visibleEventCategories = [];
         for each(var _loc2_ in _allEventCategories)
         {
            if(_loc2_.visible)
            {
               _visibleEventCategories.push(_loc2_);
            }
         }
      }
      
      public function get allEventCategories() : Array
      {
         return _allEventCategories;
      }
      
      public function get visibleEventCategories() : Array
      {
         return _visibleEventCategories;
      }
      
      public function getEventCategoryById(param1:int) : EventCategory
      {
         for each(var _loc2_ in _allCategories)
         {
            if(_loc2_.categoryId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onFavourites(param1:FavouritesMessageParser) : void
      {
         this._favouriteLimit = param1.limit;
         this.UnknownVarFromNavigatorData_Int_1 = param1.favouriteRoomIds.length;
         this.UnknownVarFromNavigatorData_Dictionary_1 = new Dictionary();
         for each(var _loc2_ in param1.favouriteRoomIds)
         {
            this.UnknownVarFromNavigatorData_Dictionary_1[_loc2_] = "yes";
         }
      }
      
      public function favouriteChanged(param1:int, param2:Boolean) : void
      {
         UnknownVarFromNavigatorData_Dictionary_1[param1] = param2 ? "yes" : null;
         UnknownVarFromNavigatorData_Int_1 += param2 ? 1 : -1;
      }
      
      public function isCurrentRoomFavourite() : Boolean
      {
         var _loc1_:int = _enteredGuestRoom.flatId;
         return UnknownVarFromNavigatorData_Dictionary_1[_loc1_] != null;
      }
      
      public function isCurrentRoomHome() : Boolean
      {
         if(_enteredGuestRoom == null)
         {
            return false;
         }
         var _loc1_:int = _enteredGuestRoom.flatId;
         return this._homeRoomId == _loc1_;
      }
      
      public function isRoomFavourite(param1:int) : Boolean
      {
         return UnknownVarFromNavigatorData_Dictionary_1[param1] != null;
      }
      
      public function isFavouritesFull() : Boolean
      {
         return UnknownVarFromNavigatorData_Int_1 >= _favouriteLimit;
      }
      
      public function isRoomHome(param1:int) : Boolean
      {
         return param1 == _homeRoomId;
      }
      
      public function startLoading() : void
      {
         this.UnknownVarFromNavigatorData_Boolean_1 = true;
      }
      
      public function isLoading() : Boolean
      {
         return this.UnknownVarFromNavigatorData_Boolean_1;
      }
      
      public function get friendList() : FriendList
      {
         return _friendList;
      }
      
      public function getAndResetSessionTags() : RoomSessionTags
      {
         var _loc1_:RoomSessionTags = UnknownVarFromNavigatorData_RoomSessionTags_1;
         UnknownVarFromNavigatorData_RoomSessionTags_1 = null;
         return _loc1_;
      }
      
      public function set roomSessionTags(param1:RoomSessionTags) : void
      {
         UnknownVarFromNavigatorData_RoomSessionTags_1 = param1;
      }
      
      public function get competitionRoomsData() : CompetitionRoomsData
      {
         return _competitionRoomsData;
      }
      
      public function set competitionRoomsData(param1:CompetitionRoomsData) : void
      {
         _competitionRoomsData = param1;
      }
   }
}

