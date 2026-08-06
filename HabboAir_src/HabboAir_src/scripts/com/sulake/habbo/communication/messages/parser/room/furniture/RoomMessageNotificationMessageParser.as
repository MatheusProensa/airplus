package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomMessageNotificationMessageParser implements IMessageParser
   {
      private var _roomId:int;
      
      private var _roomName:String;
      
      private var _messageCount:int;
      
      public function RoomMessageNotificationMessageParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get messageCount() : int
      {
         return _messageCount;
      }
      
      public function flush() : Boolean
      {
         _roomId = -1;
         _roomName = "";
         _messageCount = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         _roomName = param1.readString();
         _messageCount = param1.readInteger();
         return true;
      }
   }
}

