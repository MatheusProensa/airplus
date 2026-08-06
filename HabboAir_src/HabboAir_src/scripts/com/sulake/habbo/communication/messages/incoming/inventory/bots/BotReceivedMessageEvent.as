package com.sulake.habbo.communication.messages.incoming.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotReceivedMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotReceivedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function BotReceivedMessageEvent(param1:Function)
      {
         super(param1,BotReceivedMessageParser);
      }
      
      public function getParser() : BotReceivedMessageParser
      {
         return _parser as BotReceivedMessageParser;
      }
   }
}

