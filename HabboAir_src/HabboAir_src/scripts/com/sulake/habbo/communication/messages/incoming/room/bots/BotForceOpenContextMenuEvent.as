package com.sulake.habbo.communication.messages.incoming.room.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotForceOpenContextMenuParser;
   
   [SecureSWF(rename="true")]
   public class BotForceOpenContextMenuEvent extends MessageEvent implements IMessageEvent
   {
      public function BotForceOpenContextMenuEvent(param1:Function)
      {
         super(param1,BotForceOpenContextMenuParser);
      }
      
      public function getParser() : BotForceOpenContextMenuParser
      {
         return _parser as BotForceOpenContextMenuParser;
      }
   }
}

