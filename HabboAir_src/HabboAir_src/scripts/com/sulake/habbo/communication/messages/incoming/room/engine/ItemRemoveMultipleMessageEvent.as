package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMultipleMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemRemoveMultipleMessageEvent extends MessageEvent
   {
      public function ItemRemoveMultipleMessageEvent(param1:Function)
      {
         super(param1,ItemRemoveMultipleMessageParser);
      }
      
      public function getParser() : ItemRemoveMultipleMessageParser
      {
         return _parser as ItemRemoveMultipleMessageParser;
      }
   }
}

