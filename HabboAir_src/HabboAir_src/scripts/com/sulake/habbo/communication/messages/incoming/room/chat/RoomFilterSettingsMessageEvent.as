package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.RoomFilterSettingsMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomFilterSettingsMessageEvent extends MessageEvent
   {
      public function RoomFilterSettingsMessageEvent(param1:Function)
      {
         super(param1,RoomFilterSettingsMessageParser);
      }
      
      public function getParser() : RoomFilterSettingsMessageParser
      {
         return _parser as RoomFilterSettingsMessageParser;
      }
   }
}

