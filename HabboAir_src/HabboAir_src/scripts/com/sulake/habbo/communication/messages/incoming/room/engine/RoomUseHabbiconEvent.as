package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomUseHabbiconMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomUseHabbiconEvent extends MessageEvent implements IMessageEvent
   {
      public function RoomUseHabbiconEvent(param1:Function)
      {
         super(param1,RoomUseHabbiconMessageParser);
      }
      
      public function getParser() : RoomUseHabbiconMessageParser
      {
         return _parser as RoomUseHabbiconMessageParser;
      }
   }
}

