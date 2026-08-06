package com.sulake.habbo.communication.messages.incoming.room.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotCommandConfigurationParser;
   
   [SecureSWF(rename="true")]
   public class BotCommandConfigurationEvent extends MessageEvent implements IMessageEvent
   {
      public function BotCommandConfigurationEvent(param1:Function)
      {
         super(param1,BotCommandConfigurationParser);
      }
      
      public function getParser() : BotCommandConfigurationParser
      {
         return _parser as BotCommandConfigurationParser;
      }
   }
}

