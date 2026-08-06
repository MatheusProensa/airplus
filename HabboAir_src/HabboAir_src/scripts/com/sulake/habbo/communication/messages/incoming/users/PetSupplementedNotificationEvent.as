package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.PetSupplementedNotificationParser;
   
   [SecureSWF(rename="true")]
   public class PetSupplementedNotificationEvent extends MessageEvent implements IMessageEvent
   {
      public function PetSupplementedNotificationEvent(param1:Function)
      {
         super(param1,PetSupplementedNotificationParser);
      }
      
      public function getParser() : PetSupplementedNotificationParser
      {
         return _parser as PetSupplementedNotificationParser;
      }
   }
}

