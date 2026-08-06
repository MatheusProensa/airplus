package com.sulake.habbo.communication.messages.incoming.discord
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.discord.DiscordPreferences;
   import com.sulake.habbo.communication.messages.parser.discord.DiscordPreferencesParser;
   
   [SecureSWF(rename="true")]
   public class DiscordPreferencesEvent extends MessageEvent implements IMessageEvent
   {
      public function DiscordPreferencesEvent(param1:Function)
      {
         super(param1,DiscordPreferencesParser);
      }
      
      public function getParser() : DiscordPreferencesParser
      {
         return this._parser as DiscordPreferencesParser;
      }
      
      public function get preferences() : DiscordPreferences
      {
         return getParser().preferences;
      }
   }
}

