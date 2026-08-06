package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.YouAreNotSpectatorMessageParser;
   
   [SecureSWF(rename="true")]
   public class YouAreNotSpectatorMessageEvent extends MessageEvent
   {
      public function YouAreNotSpectatorMessageEvent(param1:Function)
      {
         super(param1,YouAreNotSpectatorMessageParser);
      }
      
      public function getParser() : YouAreNotSpectatorMessageParser
      {
         return _parser as YouAreNotSpectatorMessageParser;
      }
   }
}

