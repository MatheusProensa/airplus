package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMultipleMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveMultipleMessageEvent extends MessageEvent
   {
      public function ObjectRemoveMultipleMessageEvent(param1:Function)
      {
         super(param1,ObjectRemoveMultipleMessageParser);
      }
      
      public function getParser() : ObjectRemoveMultipleMessageParser
      {
         return _parser as ObjectRemoveMultipleMessageParser;
      }
   }
}

