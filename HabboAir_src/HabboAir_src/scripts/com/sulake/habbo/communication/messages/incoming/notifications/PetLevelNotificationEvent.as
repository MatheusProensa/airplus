package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationParser;
   
   [SecureSWF(rename="true")]
   public class PetLevelNotificationEvent extends MessageEvent implements IMessageEvent
   {
      public function PetLevelNotificationEvent(param1:Function)
      {
         super(param1,PetLevelNotificationParser);
      }
      
      public function getParser() : PetLevelNotificationParser
      {
         return _parser as PetLevelNotificationParser;
      }
   }
}

