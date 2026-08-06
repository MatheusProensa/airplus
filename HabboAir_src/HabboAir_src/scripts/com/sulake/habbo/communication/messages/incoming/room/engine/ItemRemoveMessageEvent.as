package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemRemoveMessageEvent extends MessageEvent
   {
      public function ItemRemoveMessageEvent(param1:Function)
      {
         super(param1,ItemRemoveMessageParser);
      }
      
      public function getParser() : ItemRemoveMessageParser
      {
         return _parser as ItemRemoveMessageParser;
      }
   }
}

