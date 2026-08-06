package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsData
   {
      public static const UnknownConstFromRoomSettingsData_Int_1:int = 0;
      
      public static const UnknownConstFromRoomSettingsData_Int_2:int = 1;
      
      public static const UnknownConstFromRoomSettingsData_Int_3:int = 2;
      
      public static const UnknownConstFromRoomSettingsData_Int_4:int = 3;
      
      public static const UnknownConstFromRoomSettingsData_Int_5:int = 4;
      
      public static const UnknownConstFromRoomSettingsData_Int_6:int = 0;
      
      public static const UnknownConstFromRoomSettingsData_Int_7:int = 1;
      
      public static const UnknownConstFromRoomSettingsData_Int_8:int = 2;
      
      private var _roomId:int;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _doorMode:int;
      
      private var _categoryId:int;
      
      private var _maximumVisitors:int;
      
      private var _maximumVisitorsLimit:int;
      
      private var _tags:Array;
      
      private var _tradeMode:int;
      
      private var _allowPets:Boolean;
      
      private var _allowFoodConsume:Boolean;
      
      private var _allowWalkThrough:Boolean;
      
      private var _hideWalls:Boolean;
      
      private var _wallThickness:int;
      
      private var _floorThickness:int;
      
      private var _leaveOnDoorTileEnabled:Boolean = true;
      
      private var _idleSleepEnabled:Boolean = true;
      
      private var _idleSleepTimeoutSeconds:int = 0;
      
      private var _idleAutokickEnabled:Boolean = true;
      
      private var _idleAutokickTimeoutSeconds:int = 0;
      
      private var _muteAllPets:Boolean = false;
      
      private var _controllersById:Dictionary;
      
      private var UnknownVarFromRoomSettingsData_Array_1:Array;
      
      private var _highlightedUserId:int;
      
      private var _bannedUsersById:Dictionary;
      
      private var UnknownVarFromRoomSettingsData_Array_2:Array;
      
      private var _roomModerationSettings:RoomModerationSettings;
      
      private var _chatSettings:RoomChatSettings;
      
      private var _hiddenByBc:Boolean;
      
      public function RoomSettingsData()
      {
         super();
      }
      
      public static function getDoorModeLocalizationKey(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "${navigator.door.mode.open}";
            case 1:
               return "${navigator.door.mode.closed}";
            case 2:
               return "${navigator.door.mode.password}";
            case 3:
               return "${navigator.door.mode.invisible}";
            case 4:
               return "${navigator.door.mode.noobs_only}";
            default:
               return "";
         }
      }
      
      public function get tradeMode() : int
      {
         return _tradeMode;
      }
      
      public function set tradeMode(param1:int) : void
      {
         _tradeMode = param1;
      }
      
      public function get allowPets() : Boolean
      {
         return _allowPets;
      }
      
      public function set allowPets(param1:Boolean) : void
      {
         _allowPets = param1;
      }
      
      public function get allowFoodConsume() : Boolean
      {
         return _allowFoodConsume;
      }
      
      public function set allowFoodConsume(param1:Boolean) : void
      {
         _allowFoodConsume = param1;
      }
      
      public function get allowWalkThrough() : Boolean
      {
         return _allowWalkThrough;
      }
      
      public function set allowWalkThrough(param1:Boolean) : void
      {
         _allowWalkThrough = param1;
      }
      
      public function get hideWalls() : Boolean
      {
         return _hideWalls;
      }
      
      public function set hideWalls(param1:Boolean) : void
      {
         _hideWalls = param1;
      }
      
      public function get wallThickness() : int
      {
         return _wallThickness;
      }
      
      public function set wallThickness(param1:int) : void
      {
         _wallThickness = param1;
      }
      
      public function get floorThickness() : int
      {
         return _floorThickness;
      }
      
      public function set floorThickness(param1:int) : void
      {
         _floorThickness = param1;
      }
      
      public function get leaveOnDoorTileEnabled() : Boolean
      {
         return _leaveOnDoorTileEnabled;
      }
      
      public function set leaveOnDoorTileEnabled(param1:Boolean) : void
      {
         _leaveOnDoorTileEnabled = param1;
      }
      
      public function get idleSleepEnabled() : Boolean
      {
         return _idleSleepEnabled;
      }
      
      public function set idleSleepEnabled(param1:Boolean) : void
      {
         _idleSleepEnabled = param1;
      }
      
      public function get idleSleepTimeoutSeconds() : int
      {
         return _idleSleepTimeoutSeconds;
      }
      
      public function set idleSleepTimeoutSeconds(param1:int) : void
      {
         _idleSleepTimeoutSeconds = param1;
      }
      
      public function get idleAutokickEnabled() : Boolean
      {
         return _idleAutokickEnabled;
      }
      
      public function set idleAutokickEnabled(param1:Boolean) : void
      {
         _idleAutokickEnabled = param1;
      }
      
      public function get idleAutokickTimeoutSeconds() : int
      {
         return _idleAutokickTimeoutSeconds;
      }
      
      public function set idleAutokickTimeoutSeconds(param1:int) : void
      {
         _idleAutokickTimeoutSeconds = param1;
      }
      
      public function get muteAllPets() : Boolean
      {
         return _muteAllPets;
      }
      
      public function set muteAllPets(param1:Boolean) : void
      {
         _muteAllPets = param1;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function set roomId(param1:int) : void
      {
         _roomId = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get doorMode() : int
      {
         return _doorMode;
      }
      
      public function set doorMode(param1:int) : void
      {
         _doorMode = param1;
      }
      
      public function get categoryId() : int
      {
         return _categoryId;
      }
      
      public function set categoryId(param1:int) : void
      {
         _categoryId = param1;
      }
      
      public function get maximumVisitors() : int
      {
         return _maximumVisitors;
      }
      
      public function set maximumVisitors(param1:int) : void
      {
         _maximumVisitors = param1;
      }
      
      public function get maximumVisitorsLimit() : int
      {
         return _maximumVisitorsLimit;
      }
      
      public function set maximumVisitorsLimit(param1:int) : void
      {
         _maximumVisitorsLimit = param1;
      }
      
      public function get tags() : Array
      {
         return _tags;
      }
      
      public function set tags(param1:Array) : void
      {
         _tags = param1;
      }
      
      public function setFlatController(param1:int, param2:FlatControllerData) : void
      {
         if(_controllersById != null)
         {
            _controllersById[param1] = param2;
            UnknownVarFromRoomSettingsData_Array_1 = null;
            _highlightedUserId = param1;
         }
      }
      
      public function get roomModerationSettings() : RoomModerationSettings
      {
         return _roomModerationSettings;
      }
      
      public function set roomModerationSettings(param1:RoomModerationSettings) : void
      {
         _roomModerationSettings = param1;
      }
      
      public function get controllersById() : Dictionary
      {
         return _controllersById;
      }
      
      public function set controllersById(param1:Dictionary) : void
      {
         _controllersById = param1;
      }
      
      public function get controllerList() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:FlatControllerData = null;
         if(UnknownVarFromRoomSettingsData_Array_1 == null)
         {
            UnknownVarFromRoomSettingsData_Array_1 = [];
            for(var _loc1_ in _controllersById)
            {
               _loc3_ = int(_loc1_);
               _loc2_ = _controllersById[_loc3_];
               if(_loc2_ != null)
               {
                  UnknownVarFromRoomSettingsData_Array_1.push(_loc2_);
               }
            }
            UnknownVarFromRoomSettingsData_Array_1.sortOn("userName",1);
         }
         return UnknownVarFromRoomSettingsData_Array_1;
      }
      
      public function get highlightedUserId() : int
      {
         return _highlightedUserId;
      }
      
      public function setBannedUser(param1:int, param2:BannedUserData) : void
      {
         if(_bannedUsersById == null)
         {
            _bannedUsersById = new Dictionary();
         }
         else
         {
            UnknownVarFromRoomSettingsData_Array_2 = null;
         }
         _bannedUsersById[param1] = param2;
      }
      
      public function get bannedUsersById() : Dictionary
      {
         return _bannedUsersById;
      }
      
      public function get bannedUsersList() : Array
      {
         if(UnknownVarFromRoomSettingsData_Array_2 == null)
         {
            UnknownVarFromRoomSettingsData_Array_2 = [];
            for each(var _loc1_ in _bannedUsersById)
            {
               UnknownVarFromRoomSettingsData_Array_2.push(_loc1_);
            }
            UnknownVarFromRoomSettingsData_Array_2.sortOn("userName",1);
         }
         return UnknownVarFromRoomSettingsData_Array_2;
      }
      
      public function get chatSettings() : RoomChatSettings
      {
         return _chatSettings;
      }
      
      public function set chatSettings(param1:RoomChatSettings) : void
      {
         _chatSettings = param1;
      }
      
      public function get hiddenByBc() : Boolean
      {
         return _hiddenByBc;
      }
      
      public function set hiddenByBc(param1:Boolean) : void
      {
         _hiddenByBc = param1;
      }
   }
}

