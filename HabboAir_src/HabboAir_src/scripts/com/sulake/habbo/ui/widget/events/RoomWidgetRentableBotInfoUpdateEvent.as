package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const RENTABLE_BOT:String = "RWRBIUE_RENTABLE_BOT";
      
      public static const DEFAULT_BOT_BADGE_ID:String = "RENTABLE_BOT";
      
      private var _name:String = "";
      
      private var _motto:String = "";
      
      private var _webID:int = 0;
      
      private var _figure:String = "";
      
      private var _badges:Array = [];
      
      private var _carryItem:int = 0;
      
      private var _userRoomId:int = 0;
      
      private var _ownerId:int;
      
      private var _ownerName:String;
      
      private var _amIOwner:Boolean = false;
      
      private var _amIAnyRoomController:Boolean = false;
      
      private var _myRoomControllerLevel:int = 0;
      
      private var _botSkills:Array;
      
      public function RoomWidgetRentableBotInfoUpdateEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("RWRBIUE_RENTABLE_BOT",param1,param2);
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set motto(param1:String) : void
      {
         _motto = param1;
      }
      
      public function get motto() : String
      {
         return _motto;
      }
      
      public function set webID(param1:int) : void
      {
         _webID = param1;
      }
      
      public function get webID() : int
      {
         return _webID;
      }
      
      public function set figure(param1:String) : void
      {
         _figure = param1;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function set badges(param1:Array) : void
      {
         _badges = param1;
      }
      
      public function get badges() : Array
      {
         return _badges;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function set ownerId(param1:int) : void
      {
         _ownerId = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         _amIOwner = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return _amIOwner;
      }
      
      public function set myRoomControllerLevel(param1:int) : void
      {
         _myRoomControllerLevel = param1;
      }
      
      public function get myRoomControllerLevel() : int
      {
         return _myRoomControllerLevel;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         _amIAnyRoomController = param1;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return _amIAnyRoomController;
      }
      
      public function set carryItem(param1:int) : void
      {
         _carryItem = param1;
      }
      
      public function get carryItem() : int
      {
         return _carryItem;
      }
      
      public function set userRoomId(param1:int) : void
      {
         _userRoomId = param1;
      }
      
      public function get userRoomId() : int
      {
         return _userRoomId;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
   }
}

