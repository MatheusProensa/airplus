package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const OWN_USER:String = "RWUIUE_OWN_USER";
      
      public static const BOT:String = "RWUIUE_BOT";
      
      public static const PEER:String = "RWUIUE_PEER";
      
      public static const TRADE_REASON_OK:int = 0;
      
      public static const TRADE_REASON_SHUTDOWN:int = 2;
      
      public static const TRADE_REASON_NO_TRADINGROOM:int = 3;
      
      public static const DEFAULT_BOT_BADGE_ID:String = "BOT";
      
      private var _name:String = "";
      
      private var _motto:String = "";
      
      private var _achievementScore:int;
      
      private var _badgesRank:int = -1;
      
      private var _webID:int = 0;
      
      private var _xp:int = 0;
      
      private var _userType:int;
      
      private var _figure:String = "";
      
      private var _badges:Array = [];
      
      private var _selectedBadges:Array = [];
      
      private var _groupId:int = 0;
      
      private var _groupName:String = "";
      
      private var _groupBadgeId:String = "";
      
      private var _carryItem:int = 0;
      
      private var _userRoomId:int = 0;
      
      private var _isSpectatorMode:Boolean = false;
      
      private var _realName:String = "";
      
      private var _allowNameChange:Boolean = false;
      
      private var _amIOwner:Boolean = false;
      
      private var _amIAnyRoomController:Boolean = false;
      
      private var _myRoomControllerLevel:int = 0;
      
      private var _canBeAskedAsFriend:Boolean = false;
      
      private var _canBeKicked:Boolean = false;
      
      private var _canBeBanned:Boolean = false;
      
      private var _canBeMuted:Boolean = false;
      
      private var _respectLeft:int = 0;
      
      private var _respectReplenishesLeft:int = 0;
      
      private var _isIgnored:Boolean = false;
      
      private var _isGuildRoom:Boolean = false;
      
      private var _canTrade:Boolean = false;
      
      private var _canTradeReason:int = 0;
      
      private var _targetRoomControllerLevel:int = 0;
      
      private var _isFriend:Boolean = false;
      
      private var _isAmbassador:Boolean = false;
      
      private var _isBlocked:Boolean;
      
      public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
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
      
      public function set achievementScore(param1:int) : void
      {
         _achievementScore = param1;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function set badgesRank(param1:int) : void
      {
         _badgesRank = param1;
      }
      
      public function get badgesRank() : int
      {
         return _badgesRank;
      }
      
      public function set webID(param1:int) : void
      {
         _webID = param1;
      }
      
      public function get webID() : int
      {
         return _webID;
      }
      
      public function set xp(param1:int) : void
      {
         _xp = param1;
      }
      
      public function get xp() : int
      {
         return _xp;
      }
      
      public function set userType(param1:int) : void
      {
         _userType = param1;
      }
      
      public function get userType() : int
      {
         return _userType;
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
      
      public function set selectedBadges(param1:Array) : void
      {
         _selectedBadges = param1 == null ? [] : param1;
      }
      
      public function get selectedBadges() : Array
      {
         return _selectedBadges;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         _groupBadgeId = param1;
      }
      
      public function get groupBadgeId() : String
      {
         return _groupBadgeId;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         _canBeAskedAsFriend = param1;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return _canBeAskedAsFriend;
      }
      
      public function set respectLeft(param1:int) : void
      {
         _respectLeft = param1;
      }
      
      public function get respectLeft() : int
      {
         return _respectLeft;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return _respectReplenishesLeft;
      }
      
      public function set respectReplenishesLeft(param1:int) : void
      {
         _respectReplenishesLeft = param1;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         _isIgnored = param1;
      }
      
      public function get isIgnored() : Boolean
      {
         return _isIgnored;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         _amIOwner = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return _amIOwner;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
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
      
      public function set canTrade(param1:Boolean) : void
      {
         _canTrade = param1;
      }
      
      public function get canTrade() : Boolean
      {
         return _canTrade;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         _canTradeReason = param1;
      }
      
      public function get canTradeReason() : int
      {
         return _canTradeReason;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         _canBeKicked = param1;
      }
      
      public function get canBeKicked() : Boolean
      {
         return _canBeKicked;
      }
      
      public function set canBeBanned(param1:Boolean) : void
      {
         _canBeBanned = param1;
      }
      
      public function get canBeBanned() : Boolean
      {
         return _canBeBanned;
      }
      
      public function get canBeMuted() : Boolean
      {
         return _canBeMuted;
      }
      
      public function set canBeMuted(param1:Boolean) : void
      {
         _canBeMuted = param1;
      }
      
      public function set targetRoomControllerLevel(param1:int) : void
      {
         _targetRoomControllerLevel = param1;
      }
      
      public function get targetRoomControllerLevel() : int
      {
         return _targetRoomControllerLevel;
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
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         _isSpectatorMode = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return _isSpectatorMode;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function set allowNameChange(param1:Boolean) : void
      {
         _allowNameChange = param1;
      }
      
      public function get allowNameChange() : Boolean
      {
         return _allowNameChange;
      }
      
      public function get isFriend() : Boolean
      {
         return _isFriend;
      }
      
      public function set isFriend(param1:Boolean) : void
      {
         _isFriend = param1;
      }
      
      public function get amIAnAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function set amIAnAmbassador(param1:Boolean) : void
      {
         _isAmbassador = param1;
      }
      
      public function get isBlocked() : Boolean
      {
         return _isBlocked;
      }
      
      public function set isBlocked(param1:Boolean) : void
      {
         _isBlocked = param1;
      }
   }
}

