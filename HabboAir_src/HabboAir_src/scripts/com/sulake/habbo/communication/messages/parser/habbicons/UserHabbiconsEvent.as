package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class UserHabbiconsEvent extends MessageEvent implements IMessageEvent
   {
      public function UserHabbiconsEvent(param1:Function)
      {
         super(param1,UserHabbiconsMessageParser);
      }
      
      public function getParser() : UserHabbiconsMessageParser
      {
         return _parser as UserHabbiconsMessageParser;
      }
   }
}

