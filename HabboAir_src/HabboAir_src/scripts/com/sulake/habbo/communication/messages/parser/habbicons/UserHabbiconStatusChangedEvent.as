package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class UserHabbiconStatusChangedEvent extends MessageEvent implements IMessageEvent
   {
      public function UserHabbiconStatusChangedEvent(param1:Function)
      {
         super(param1,UserHabbiconStatusChangedMessageParser);
      }
      
      public function getParser() : UserHabbiconStatusChangedMessageParser
      {
         return _parser as UserHabbiconStatusChangedMessageParser;
      }
   }
}

