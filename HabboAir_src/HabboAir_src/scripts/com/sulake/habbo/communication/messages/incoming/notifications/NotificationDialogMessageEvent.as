package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.NotificationDialogMessageParser;
   
   [SecureSWF(rename="true")]
   public class NotificationDialogMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function NotificationDialogMessageEvent(param1:Function)
      {
         super(param1,NotificationDialogMessageParser);
      }
      
      public function getParser() : NotificationDialogMessageParser
      {
         return _parser as NotificationDialogMessageParser;
      }
   }
}

