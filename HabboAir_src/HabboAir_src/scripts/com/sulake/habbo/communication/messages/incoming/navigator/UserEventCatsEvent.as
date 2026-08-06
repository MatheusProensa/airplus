package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.UserEventCatsMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserEventCatsEvent extends MessageEvent implements IMessageEvent
   {
      public function UserEventCatsEvent(param1:Function)
      {
         super(param1,UserEventCatsMessageParser);
      }
      
      public function getParser() : UserEventCatsMessageParser
      {
         return this._parser as UserEventCatsMessageParser;
      }
   }
}

