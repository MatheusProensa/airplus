package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveConfirmMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveConfirmMessageEvent extends MessageEvent
   {
      public function ObjectRemoveConfirmMessageEvent(param1:Function)
      {
         super(param1,ObjectRemoveConfirmMessageParser);
      }
      
      public function getParser() : ObjectRemoveConfirmMessageParser
      {
         return _parser as ObjectRemoveConfirmMessageParser;
      }
   }
}

