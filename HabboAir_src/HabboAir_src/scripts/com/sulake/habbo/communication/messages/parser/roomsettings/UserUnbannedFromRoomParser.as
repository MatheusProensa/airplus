package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserUnbannedFromRoomParser implements IMessageParser
   {
      private var _roomId:int;
      
      private var _userId:int;
      
      public function UserUnbannedFromRoomParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         _userId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         _userId = param1.readInteger();
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}

