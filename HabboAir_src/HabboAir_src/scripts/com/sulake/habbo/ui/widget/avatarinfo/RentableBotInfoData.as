package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   
   public class RentableBotInfoData
   {
      private var _id:int = -1;
      
      private var _roomIndex:int;
      
      private var _isIgnored:Boolean = false;
      
      private var _amIOwner:Boolean = false;
      
      private var _amIAnyRoomController:Boolean = false;
      
      private var _carryItemType:int = 0;
      
      private var _botSkills:Array;
      
      private var _botSkillsWithCommands:Array = new Array(0);
      
      private var _name:String;
      
      public function RentableBotInfoData()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set roomIndex(param1:int) : void
      {
         _roomIndex = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get isIgnored() : Boolean
      {
         return _isIgnored;
      }
      
      public function get amIOwner() : Boolean
      {
         return _amIOwner;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return _amIAnyRoomController;
      }
      
      public function get carryItemType() : int
      {
         return _carryItemType;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         _isIgnored = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         _amIOwner = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         _amIAnyRoomController = param1;
      }
      
      public function set carryItemType(param1:int) : void
      {
         _carryItemType = param1;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get botSkillsWithCommands() : Array
      {
         return _botSkillsWithCommands;
      }
      
      public function set botSkillsWithCommands(param1:Array) : void
      {
         _botSkillsWithCommands = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function populate(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         if(param1.webID != id)
         {
            _botSkillsWithCommands = new Array(0);
         }
         id = param1.webID;
         roomIndex = param1.userRoomId;
         amIOwner = param1.amIOwner;
         amIAnyRoomController = param1.amIAnyRoomController;
         carryItemType = param1.carryItem;
         botSkills = param1.botSkills;
         _name = param1.name;
      }
      
      public function cloneAndSetSkillsWithCommands(param1:Array) : void
      {
         _botSkills = [];
         for each(var _loc2_ in param1)
         {
            botSkills.push(_loc2_.id);
         }
         _botSkillsWithCommands = param1.concat();
      }
   }
}

