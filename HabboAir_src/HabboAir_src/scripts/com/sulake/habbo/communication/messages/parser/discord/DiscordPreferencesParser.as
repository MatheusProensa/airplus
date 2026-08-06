package com.sulake.habbo.communication.messages.parser.discord
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DiscordPreferencesParser implements IMessageParser
   {
      private var _preferences:DiscordPreferences;
      
      public function DiscordPreferencesParser()
      {
         super();
      }
      
      public function get preferences() : DiscordPreferences
      {
         return _preferences;
      }
      
      public function flush() : Boolean
      {
         _preferences = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _preferences = DiscordPreferences.readFromData(param1);
         return true;
      }
   }
}

