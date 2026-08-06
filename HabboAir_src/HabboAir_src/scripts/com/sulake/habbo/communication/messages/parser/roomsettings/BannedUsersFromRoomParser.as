package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.BannedUserData;
   
   [SecureSWF(rename="true")]
   public class BannedUsersFromRoomParser implements IMessageParser
   {
      private var _roomId:int;
      
      private var _bannedUsers:Array;
      
      public function BannedUsersFromRoomParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _bannedUsers = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _roomId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _bannedUsers.push(new BannedUserData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get bannedUsers() : Array
      {
         return _bannedUsers;
      }
   }
}

