package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildFurniContextMenuInfoMessageParser implements IMessageParser
   {
      private var _objectId:int;
      
      private var _guildId:int;
      
      private var _guildName:String;
      
      private var _guildHomeRoomId:int;
      
      private var _userIsMember:Boolean;
      
      private var _guildHasReadableForum:Boolean;
      
      public function GuildFurniContextMenuInfoMessageParser()
      {
         super();
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get guildId() : int
      {
         return _guildId;
      }
      
      public function get guildName() : String
      {
         return _guildName;
      }
      
      public function get guildHomeRoomId() : int
      {
         return _guildHomeRoomId;
      }
      
      public function get userIsMember() : Boolean
      {
         return _userIsMember;
      }
      
      public function get guildHasReadableForum() : Boolean
      {
         return _guildHasReadableForum;
      }
      
      public function flush() : Boolean
      {
         _objectId = -1;
         _guildId = -1;
         _guildName = "";
         _guildHomeRoomId = -1;
         _userIsMember = false;
         _guildHasReadableForum = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _objectId = param1.readInteger();
         _guildId = param1.readInteger();
         _guildName = param1.readString();
         _guildHomeRoomId = param1.readInteger();
         _userIsMember = param1.readBoolean();
         _guildHasReadableForum = param1.readBoolean();
         return true;
      }
   }
}

