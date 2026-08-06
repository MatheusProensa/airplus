package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GuestRoomData implements IComponentInterfaceQueue
   {
      private const UnknownConstFromGuestRoomData_Int_1:int = 1;
      
      private const UnknownConstFromGuestRoomData_Int_2:int = 2;
      
      private const UnknownConstFromGuestRoomData_Int_3:int = 4;
      
      private const UnknownConstFromGuestRoomData_Int_4:int = 8;
      
      private const UnknownConstFromGuestRoomData_Int_5:int = 16;
      
      private const UnknownConstFromGuestRoomData_Int_6:int = 32;
      
      private var _flatId:int;
      
      private var _roomName:String;
      
      private var _showOwner:Boolean;
      
      private var _ownerId:int;
      
      private var _ownerName:String;
      
      private var _doorMode:int;
      
      private var _userCount:int;
      
      private var _maxUserCount:int;
      
      private var _description:String;
      
      private var _tradeMode:int;
      
      private var _score:int;
      
      private var _ranking:int;
      
      private var _categoryId:int;
      
      private var UnknownVarFromGuestRoomData_Int_1:int;
      
      private var _habboGroupId:int = 0;
      
      private var _groupName:String = "";
      
      private var _groupBadgeCode:String = "";
      
      private var _tags:Array;
      
      private var _thumbnail:RoomThumbnailData;
      
      private var _allowPets:Boolean;
      
      private var _displayRoomEntryAd:Boolean;
      
      private var _roomAdName:String = "";
      
      private var _roomAdDescription:String = "";
      
      private var _roomAdExpiresInMin:int = 0;
      
      private var _allInRoomMuted:Boolean;
      
      private var _canMute:Boolean;
      
      private var _disposed:Boolean;
      
      private var _officialRoomPicRef:String = null;
      
      public function GuestRoomData(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         _tags = [];
         super();
         _flatId = param1.readInteger();
         _roomName = param1.readString();
         _ownerId = param1.readInteger();
         _ownerName = param1.readString();
         _doorMode = param1.readInteger();
         _userCount = param1.readInteger();
         _maxUserCount = param1.readInteger();
         _description = param1.readString();
         _tradeMode = param1.readInteger();
         _score = param1.readInteger();
         _ranking = param1.readInteger();
         _categoryId = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.readString();
            _tags.push(_loc5_);
            _loc4_++;
         }
         var _loc2_:int = param1.readInteger();
         if((_loc2_ & 1) > 0)
         {
            _officialRoomPicRef = param1.readString();
         }
         if((_loc2_ & 2) > 0)
         {
            _habboGroupId = param1.readInteger();
            _groupName = param1.readString();
            _groupBadgeCode = param1.readString();
         }
         if((_loc2_ & 4) > 0)
         {
            _roomAdName = param1.readString();
            _roomAdDescription = param1.readString();
            _roomAdExpiresInMin = param1.readInteger();
         }
         _showOwner = (_loc2_ & 8) > 0;
         _allowPets = (_loc2_ & 0x10) > 0;
         _displayRoomEntryAd = (_loc2_ & 0x20) > 0;
         _thumbnail = new RoomThumbnailData(null);
         _thumbnail.setDefaults();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this._tags = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get showOwner() : Boolean
      {
         return _showOwner;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get doorMode() : int
      {
         return _doorMode;
      }
      
      public function get userCount() : int
      {
         return _userCount;
      }
      
      public function get maxUserCount() : int
      {
         return _maxUserCount;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get tradeMode() : int
      {
         return _tradeMode;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get ranking() : int
      {
         return _ranking;
      }
      
      public function get categoryId() : int
      {
         return _categoryId;
      }
      
      public function get habboGroupId() : int
      {
         return _habboGroupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get groupBadgeCode() : String
      {
         return _groupBadgeCode;
      }
      
      public function get tags() : Array
      {
         return _tags;
      }
      
      public function get thumbnail() : RoomThumbnailData
      {
         return _thumbnail;
      }
      
      public function get allowPets() : Boolean
      {
         return _allowPets;
      }
      
      public function get displayRoomEntryAd() : Boolean
      {
         return _displayRoomEntryAd;
      }
      
      public function get roomAdName() : String
      {
         return _roomAdName;
      }
      
      public function get roomAdDescription() : String
      {
         return _roomAdDescription;
      }
      
      public function get roomAdExpiresInMin() : int
      {
         return _roomAdExpiresInMin;
      }
      
      public function get allInRoomMuted() : Boolean
      {
         return _allInRoomMuted;
      }
      
      public function get officialRoomPicRef() : String
      {
         return _officialRoomPicRef;
      }
      
      public function set allInRoomMuted(param1:Boolean) : void
      {
         _allInRoomMuted = param1;
      }
      
      public function set roomName(param1:String) : void
      {
         _roomName = param1;
      }
      
      public function get canMute() : Boolean
      {
         return _canMute;
      }
      
      public function set canMute(param1:Boolean) : void
      {
         _canMute = param1;
      }
      
      public function set userCount(param1:int) : void
      {
         this._userCount = param1;
      }
   }
}

