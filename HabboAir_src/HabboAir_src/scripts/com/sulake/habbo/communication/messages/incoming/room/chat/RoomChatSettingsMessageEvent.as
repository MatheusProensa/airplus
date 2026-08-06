package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.RoomChatSettingsMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomChatSettingsMessageEvent extends MessageEvent
   {
      public function RoomChatSettingsMessageEvent(param1:Function)
      {
         super(param1,RoomChatSettingsMessageParser);
      }
      
      public function getParser() : RoomChatSettingsMessageParser
      {
         return _parser as RoomChatSettingsMessageParser;
      }
   }
}

