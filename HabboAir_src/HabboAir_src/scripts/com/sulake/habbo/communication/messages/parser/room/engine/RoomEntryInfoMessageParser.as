package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomEntryInfoMessageParser implements IMessageParser
   {
      private var _guestRoomId:int;
      
      private var _owner:Boolean;
      
      public function RoomEntryInfoMessageParser()
      {
         super();
      }
      
      public function get guestRoomId() : int
      {
         return _guestRoomId;
      }
      
      public function get owner() : Boolean
      {
         return _owner;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _guestRoomId = param1.readInteger();
         _owner = param1.readBoolean();
         return true;
      }
   }
}

