package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.CustomUserNotificationMessageParser;
   
   [SecureSWF(rename="true")]
   public class CustomUserNotificationMessageEvent extends MessageEvent
   {
      public function CustomUserNotificationMessageEvent(param1:Function)
      {
         super(param1,CustomUserNotificationMessageParser);
      }
      
      public function getParser() : CustomUserNotificationMessageParser
      {
         return parser as CustomUserNotificationMessageParser;
      }
   }
}

