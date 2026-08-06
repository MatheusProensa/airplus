package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.UnknownHabboCommunicationMessagesParserNotifications1;
   
   [SecureSWF(rename="true")]
   public class RestoreClientMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function RestoreClientMessageEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserNotifications1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserNotifications1
      {
         return _parser as UnknownHabboCommunicationMessagesParserNotifications1;
      }
   }
}

