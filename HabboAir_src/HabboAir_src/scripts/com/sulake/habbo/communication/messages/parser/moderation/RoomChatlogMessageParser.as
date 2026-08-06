package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.ChatRecordData;
   
   [SecureSWF(rename="true")]
   public class RoomChatlogMessageParser implements IMessageParser
   {
      private var _data:ChatRecordData;
      
      public function RoomChatlogMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new ChatRecordData(param1);
         return true;
      }
      
      public function get data() : ChatRecordData
      {
         return _data;
      }
   }
}

