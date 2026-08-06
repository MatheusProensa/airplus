package com.sulake.habbo.communication.messages.incoming.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotRemovedFromInventoryParser;
   
   [SecureSWF(rename="true")]
   public class BotRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent
   {
      public function BotRemovedFromInventoryEvent(param1:Function)
      {
         super(param1,BotRemovedFromInventoryParser);
      }
      
      public function getParser() : BotRemovedFromInventoryParser
      {
         return _parser as BotRemovedFromInventoryParser;
      }
   }
}

