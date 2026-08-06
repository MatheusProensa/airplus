package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomInfoUpdatedEvent extends MessageEvent implements IMessageEvent
   {
      public function RoomInfoUpdatedEvent(param1:Function)
      {
         super(param1,RoomInfoUpdatedMessageParser);
      }
      
      public function getParser() : RoomInfoUpdatedMessageParser
      {
         return this._parser as RoomInfoUpdatedMessageParser;
      }
   }
}

