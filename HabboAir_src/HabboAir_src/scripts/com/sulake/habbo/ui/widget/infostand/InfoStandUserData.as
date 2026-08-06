package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.communication.messages.incoming.users.SelectedBadgeData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   
   public class InfoStandUserData
   {
      private var _userId:int = 0;
      
      private var _userName:String = "";
      
      private var _badges:Array = [];
      
      private var _selectedBadges:Array = [];
      
      private var _badgesRank:int = -1;
      
      private var _groupId:int = 0;
      
      private var _groupName:String = "";
      
      private var _groupBadgeId:String = "";
      
      private var _respectLeft:int = 0;
      
      private var _respectReplenishesLeft:int = 0;
      
      private var _carryItem:int = 0;
      
      private var _userRoomId:int = 0;
      
      private var _type:String;
      
      private var _petRespectLeft:int = 0;
      
      public function InfoStandUserData()
      {
         super();
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         _badges = param1;
      }
      
      public function set selectedBadges(param1:Array) : void
      {
         _selectedBadges = param1 == null ? [] : param1;
      }
      
      public function set badgesRank(param1:int) : void
      {
         _badgesRank = param1;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         _groupBadgeId = param1;
      }
      
      public function set respectLeft(param1:int) : void
      {
         _respectLeft = param1;
      }
      
      public function set respectReplenishesLeft(param1:int) : void
      {
         _respectReplenishesLeft = param1;
      }
      
      public function set carryItem(param1:int) : void
      {
         _carryItem = param1;
      }
      
      public function set userRoomId(param1:int) : void
      {
         _userRoomId = param1;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function set petRespectLeft(param1:int) : void
      {
         _petRespectLeft = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get badges() : Array
      {
         return _badges.slice();
      }
      
      public function get selectedBadges() : Array
      {
         return _selectedBadges.slice();
      }
      
      public function get badgesRank() : int
      {
         return _badgesRank;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get groupBadgeId() : String
      {
         return _groupBadgeId;
      }
      
      public function get respectLeft() : int
      {
         return _respectLeft;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return _respectReplenishesLeft;
      }
      
      public function get carryItem() : int
      {
         return _carryItem;
      }
      
      public function get userRoomId() : int
      {
         return _userRoomId;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get petRespectLeft() : int
      {
         return _petRespectLeft;
      }
      
      public function getSelectedBadge(param1:int) : SelectedBadgeData
      {
         for each(var _loc2_ in _selectedBadges)
         {
            if(_loc2_ != null && _loc2_.slotIndex == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBadgeSlot(param1:String) : int
      {
         for each(var _loc2_ in _selectedBadges)
         {
            if(_loc2_ != null && _loc2_.badgeCode == param1)
            {
               return _loc2_.slotIndex;
            }
         }
         return _badges.indexOf(param1);
      }
      
      public function isBot() : Boolean
      {
         return type == "RWUIUE_BOT";
      }
      
      public function setData(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userId = param1.webID;
         userName = param1.name;
         badges = param1.badges;
         selectedBadges = param1.selectedBadges;
         badgesRank = param1.badgesRank;
         groupId = param1.groupId;
         groupName = param1.groupName;
         groupBadgeId = param1.groupBadgeId;
         respectLeft = param1.respectLeft;
         respectReplenishesLeft = param1.respectReplenishesLeft;
         carryItem = param1.carryItem;
         userRoomId = param1.userRoomId;
         type = param1.type;
      }
   }
}

