package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class GuildEditData implements IGuildEditData
   {
      private var _ownedRooms:Array;
      
      private var _isOwner:Boolean;
      
      private var _groupId:int;
      
      private var _groupName:String;
      
      private var _groupDesc:String;
      
      private var _baseRoomId:int;
      
      private var _primaryColorId:int;
      
      private var _secondaryColorId:int;
      
      private var _locked:Boolean;
      
      private var _url:String;
      
      private var _guildType:int;
      
      private var _guildRightsLevel:int;
      
      private var _badgeSettings:Array;
      
      private var _badgeCode:String;
      
      private var _membershipCount:int;
      
      public function GuildEditData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         super();
         _ownedRooms = [];
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _ownedRooms.push(new RoomEntryData(param1.readInteger(),param1.readString(),param1.readBoolean()));
            _loc3_++;
         }
         _isOwner = param1.readBoolean();
         _groupId = param1.readInteger();
         _groupName = param1.readString();
         _groupDesc = param1.readString();
         _baseRoomId = param1.readInteger();
         _primaryColorId = param1.readInteger();
         _secondaryColorId = param1.readInteger();
         _guildType = param1.readInteger();
         _guildRightsLevel = param1.readInteger();
         _locked = param1.readBoolean();
         _url = param1.readString();
         _badgeSettings = [];
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _badgeSettings.push(new GuildBadgeSettings(param1));
            _loc3_++;
         }
         _badgeCode = param1.readString();
         _membershipCount = param1.readInteger();
      }
      
      public function get ownedRooms() : Array
      {
         return _ownedRooms;
      }
      
      public function get exists() : Boolean
      {
         return true;
      }
      
      public function get isOwner() : Boolean
      {
         return _isOwner;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get groupDesc() : String
      {
         return _groupDesc;
      }
      
      public function get baseRoomId() : int
      {
         return _baseRoomId;
      }
      
      public function get primaryColorId() : int
      {
         return _primaryColorId;
      }
      
      public function get secondaryColorId() : int
      {
         return _secondaryColorId;
      }
      
      public function get badgeSettings() : Array
      {
         return _badgeSettings;
      }
      
      public function get locked() : Boolean
      {
         return _locked;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get guildType() : int
      {
         return _guildType;
      }
      
      public function get guildRightsLevel() : int
      {
         return _guildRightsLevel;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get membershipCount() : int
      {
         return _membershipCount;
      }
   }
}

