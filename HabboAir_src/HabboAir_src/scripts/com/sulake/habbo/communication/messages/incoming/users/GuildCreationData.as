package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class GuildCreationData implements IGuildEditData
   {
      private var _costInCredits:int;
      
      private var _ownedRooms:Array;
      
      private var _badgeSettings:Array;
      
      public function GuildCreationData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         super();
         _costInCredits = param1.readInteger();
         _ownedRooms = [];
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _ownedRooms.push(new RoomEntryData(param1.readInteger(),param1.readString(),param1.readBoolean()));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _badgeSettings = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _badgeSettings.push(new GuildBadgeSettings(param1));
            _loc3_++;
         }
      }
      
      public function get costInCredits() : int
      {
         return _costInCredits;
      }
      
      public function get ownedRooms() : Array
      {
         return _ownedRooms;
      }
      
      public function get exists() : Boolean
      {
         return false;
      }
      
      public function get isOwner() : Boolean
      {
         return true;
      }
      
      public function get groupId() : int
      {
         return 0;
      }
      
      public function get groupName() : String
      {
         return "";
      }
      
      public function get groupDesc() : String
      {
         return "";
      }
      
      public function get baseRoomId() : int
      {
         return 0;
      }
      
      public function get primaryColorId() : int
      {
         return 0;
      }
      
      public function get secondaryColorId() : int
      {
         return 0;
      }
      
      public function get badgeSettings() : Array
      {
         return _badgeSettings;
      }
      
      public function get locked() : Boolean
      {
         return false;
      }
      
      public function get url() : String
      {
         return "";
      }
      
      public function get guildType() : int
      {
         return 0;
      }
      
      public function get guildRightsLevel() : int
      {
         return 0;
      }
      
      public function get badgeCode() : String
      {
         return "";
      }
      
      public function get membershipCount() : int
      {
         return 0;
      }
   }
}

