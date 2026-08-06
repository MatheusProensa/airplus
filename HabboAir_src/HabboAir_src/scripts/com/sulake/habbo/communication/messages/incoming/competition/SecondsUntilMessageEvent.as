package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.SecondsUntilMessageParser;
   
   [SecureSWF(rename="true")]
   public class SecondsUntilMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function SecondsUntilMessageEvent(param1:Function)
      {
         super(param1,SecondsUntilMessageParser);
      }
      
      public function getParser() : SecondsUntilMessageParser
      {
         return _parser as SecondsUntilMessageParser;
      }
   }
}

