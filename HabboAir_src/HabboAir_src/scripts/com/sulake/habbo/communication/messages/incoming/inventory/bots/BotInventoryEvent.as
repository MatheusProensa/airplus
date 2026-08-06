package com.sulake.habbo.communication.messages.incoming.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotInventoryMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotInventoryEvent extends MessageEvent implements IMessageEvent
   {
      public function BotInventoryEvent(param1:Function)
      {
         super(param1,BotInventoryMessageParser);
      }
      
      public function getParser() : BotInventoryMessageParser
      {
         return _parser as BotInventoryMessageParser;
      }
   }
}

