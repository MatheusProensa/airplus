package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   
   public class InfoStandRentableBotData
   {
      private var _userId:int = 0;
      
      private var _name:String = "";
      
      private var _badges:Array = [];
      
      private var _carryItem:int = 0;
      
      private var _userRoomId:int = 0;
      
      private var _amIOwner:Boolean;
      
      private var _amIAnyRoomController:Boolean;
      
      private var _botSkills:Array;
      
      public function InfoStandRentableBotData()
      {
         super();
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         _badges = param1;
      }
      
      public function set carryItem(param1:int) : void
      {
         _carryItem = param1;
      }
      
      public function set userRoomId(param1:int) : void
      {
         _userRoomId = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         _amIOwner = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         _amIAnyRoomController = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get badges() : Array
      {
         return _badges.slice();
      }
      
      public function get carryItem() : int
      {
         return _carryItem;
      }
      
      public function get userRoomId() : int
      {
         return _userRoomId;
      }
      
      public function get amIOwner() : Boolean
      {
         return _amIOwner;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return _amIAnyRoomController;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function setData(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         userId = param1.webID;
         name = param1.name;
         badges = param1.badges;
         carryItem = param1.carryItem;
         userRoomId = param1.userRoomId;
         amIOwner = param1.amIOwner;
         amIAnyRoomController = param1.amIAnyRoomController;
         botSkills = param1.botSkills;
      }
   }
}

