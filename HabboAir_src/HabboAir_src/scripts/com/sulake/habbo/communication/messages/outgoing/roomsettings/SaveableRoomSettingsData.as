package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   [SecureSWF(rename="true")]
   public class SaveableRoomSettingsData
   {
      private var _roomId:int;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _doorMode:int;
      
      private var _password:String;
      
      private var _categoryId:int;
      
      private var _maximumVisitors:int;
      
      private var _tags:Array;
      
      private var _controllers:Array;
      
      private var _tradeMode:int;
      
      private var _allowPets:Boolean;
      
      private var _allowFoodConsume:Boolean;
      
      private var _allowWalkThrough:Boolean;
      
      private var _hideWalls:Boolean;
      
      private var _wallThickness:int;
      
      private var _floorThickness:int;
      
      private var _whoCanMute:int;
      
      private var _whoCanKick:int;
      
      private var _whoCanBan:int;
      
      private var _chatFloodSensitivity:int;
      
      private var _leaveOnDoorTileEnabled:Boolean = true;
      
      private var _idleSleepEnabled:Boolean = true;
      
      private var _idleSleepTimeoutSeconds:int = 0;
      
      private var _idleAutokickEnabled:Boolean = true;
      
      private var _idleAutokickTimeoutSeconds:int = 0;
      
      private var _muteAllPets:Boolean = false;
      
      public function SaveableRoomSettingsData()
      {
         super();
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
      
      public function get password() : String
      {
         return _password;
      }
      
      public function set password(param1:String) : void
      {
         _password = param1;
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
      
      public function get tags() : Array
      {
         return _tags;
      }
      
      public function set tags(param1:Array) : void
      {
         _tags = param1;
      }
      
      public function get controllers() : Array
      {
         return _controllers;
      }
      
      public function set controllers(param1:Array) : void
      {
         _controllers = param1;
      }
      
      public function get whoCanMute() : int
      {
         return _whoCanMute;
      }
      
      public function set whoCanMute(param1:int) : void
      {
         _whoCanMute = param1;
      }
      
      public function get whoCanKick() : int
      {
         return _whoCanKick;
      }
      
      public function set whoCanKick(param1:int) : void
      {
         _whoCanKick = param1;
      }
      
      public function get whoCanBan() : int
      {
         return _whoCanBan;
      }
      
      public function set whoCanBan(param1:int) : void
      {
         _whoCanBan = param1;
      }
      
      public function get chatFloodSensitivity() : int
      {
         return _chatFloodSensitivity;
      }
      
      public function set chatFloodSensitivity(param1:int) : void
      {
         _chatFloodSensitivity = param1;
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
   }
}

