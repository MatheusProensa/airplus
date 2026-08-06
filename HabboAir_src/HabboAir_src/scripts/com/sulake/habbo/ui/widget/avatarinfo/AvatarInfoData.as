package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   
   public class AvatarInfoData
   {
      private var _isIgnored:Boolean = false;
      
      private var _canTrade:Boolean = false;
      
      private var _canTradeReason:int = 0;
      
      private var _canBeKicked:Boolean = false;
      
      private var _canBeBanned:Boolean = false;
      
      private var _canBeMuted:Boolean = false;
      
      private var _canBeAskedAsFriend:Boolean = false;
      
      private var _amIOwner:Boolean = false;
      
      private var _amIAnyRoomController:Boolean = false;
      
      private var _respectLeft:int = 0;
      
      private var _respectReplenishesLeft:int = 0;
      
      private var _isOwnUser:Boolean = false;
      
      private var _allowNameChange:Boolean = false;
      
      private var _isGuildRoom:Boolean = false;
      
      private var _carryItemType:int = 0;
      
      private var _myRoomControllerLevel:int = 0;
      
      private var _targetRoomControllerLevel:int = 0;
      
      private var _isFriend:Boolean = false;
      
      private var _isAmbassador:Boolean = false;
      
      private var _isBlocked:Boolean = false;
      
      public function AvatarInfoData()
      {
         super();
      }
      
      public function get isIgnored() : Boolean
      {
         return _isIgnored;
      }
      
      public function get canTrade() : Boolean
      {
         return _canTrade;
      }
      
      public function get canTradeReason() : int
      {
         return _canTradeReason;
      }
      
      public function get canBeKicked() : Boolean
      {
         return _canBeKicked;
      }
      
      public function get canBeBanned() : Boolean
      {
         return _canBeBanned;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return _canBeAskedAsFriend;
      }
      
      public function get amIOwner() : Boolean
      {
         return _amIOwner;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return _amIAnyRoomController;
      }
      
      public function get respectLeft() : int
      {
         return _respectLeft;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return _respectReplenishesLeft;
      }
      
      public function get isOwnUser() : Boolean
      {
         return _isOwnUser;
      }
      
      public function get allowNameChange() : Boolean
      {
         return _allowNameChange;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function get carryItemType() : int
      {
         return _carryItemType;
      }
      
      public function get myRoomControllerLevel() : int
      {
         return _myRoomControllerLevel;
      }
      
      public function get targetRoomControllerLevel() : int
      {
         return _targetRoomControllerLevel;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         _isIgnored = param1;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         _canTrade = param1;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         _canTradeReason = param1;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         _canBeKicked = param1;
      }
      
      public function set canBeBanned(param1:Boolean) : void
      {
         _canBeBanned = param1;
      }
      
      public function get canBeMuted() : Boolean
      {
         return _canBeMuted;
      }
      
      public function set canBeMuted(param1:Boolean) : void
      {
         _canBeMuted = param1;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         _canBeAskedAsFriend = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         _amIOwner = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         _amIAnyRoomController = param1;
      }
      
      public function set respectLeft(param1:int) : void
      {
         _respectLeft = param1;
      }
      
      public function set respectReplenishesLeft(param1:int) : void
      {
         _respectReplenishesLeft = param1;
      }
      
      public function set isOwnUser(param1:Boolean) : void
      {
         _isOwnUser = param1;
      }
      
      public function set allowNameChange(param1:Boolean) : void
      {
         _allowNameChange = param1;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function set carryItemType(param1:int) : void
      {
         _carryItemType = param1;
      }
      
      public function set myRoomControllerLevel(param1:int) : void
      {
         _myRoomControllerLevel = param1;
      }
      
      public function set targetRoomControllerLevel(param1:int) : void
      {
         _targetRoomControllerLevel = param1;
      }
      
      public function get isFriend() : Boolean
      {
         return _isFriend;
      }
      
      public function get isAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function get isBlocked() : Boolean
      {
         return _isBlocked;
      }
      
      public function populate(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         _amIAnyRoomController = param1.amIAnyRoomController;
         _myRoomControllerLevel = param1.myRoomControllerLevel;
         _amIOwner = param1.amIOwner;
         _canBeAskedAsFriend = param1.canBeAskedAsFriend;
         _canBeKicked = param1.canBeKicked;
         _canBeBanned = param1.canBeBanned;
         _canBeMuted = param1.canBeMuted;
         _canTrade = param1.canTrade;
         _canTradeReason = param1.canTradeReason;
         _isIgnored = param1.isIgnored;
         _respectLeft = param1.respectLeft;
         _respectReplenishesLeft = param1.respectReplenishesLeft;
         _isOwnUser = param1.type == "RWUIUE_OWN_USER";
         _allowNameChange = param1.allowNameChange;
         _isGuildRoom = param1.isGuildRoom;
         _targetRoomControllerLevel = param1.targetRoomControllerLevel;
         _carryItemType = param1.carryItem;
         _isFriend = param1.isFriend;
         _isAmbassador = param1.amIAnAmbassador;
         _isBlocked = param1.isBlocked;
      }
   }
}

