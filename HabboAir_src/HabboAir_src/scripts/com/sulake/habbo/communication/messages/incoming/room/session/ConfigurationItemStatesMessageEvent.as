package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.ConfigurationItemStatesMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConfigurationItemStatesMessageEvent extends MessageEvent
   {
      public function ConfigurationItemStatesMessageEvent(param1:Function)
      {
         super(param1,ConfigurationItemStatesMessageParser);
      }
      
      public function getParser() : ConfigurationItemStatesMessageParser
      {
         return _parser as ConfigurationItemStatesMessageParser;
      }
   }
}

