package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.AntiSpamTriggeredMessageParser;
   
   [SecureSWF(rename="true")]
   public class AntiSpamTriggeredMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function AntiSpamTriggeredMessageEvent(param1:Function)
      {
         super(param1,AntiSpamTriggeredMessageParser);
      }
      
      public function getParser() : AntiSpamTriggeredMessageParser
      {
         return _parser as AntiSpamTriggeredMessageParser;
      }
   }
}

