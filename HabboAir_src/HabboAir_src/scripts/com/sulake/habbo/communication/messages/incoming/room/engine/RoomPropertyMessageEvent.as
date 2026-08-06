package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomPropertyMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomPropertyMessageEvent extends MessageEvent
   {
      public function RoomPropertyMessageEvent(param1:Function)
      {
         super(param1,RoomPropertyMessageParser);
      }
      
      public function getParser() : RoomPropertyMessageParser
      {
         return _parser as RoomPropertyMessageParser;
      }
   }
}

