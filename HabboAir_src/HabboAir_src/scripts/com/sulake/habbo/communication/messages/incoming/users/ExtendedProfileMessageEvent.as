package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ExtendedProfileMessageParser;
   
   [SecureSWF(rename="true")]
   public class ExtendedProfileMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ExtendedProfileMessageEvent(param1:Function)
      {
         super(param1,ExtendedProfileMessageParser);
      }
      
      public function get data() : ExtendedProfileData
      {
         return ExtendedProfileMessageParser(_parser).data;
      }
   }
}

