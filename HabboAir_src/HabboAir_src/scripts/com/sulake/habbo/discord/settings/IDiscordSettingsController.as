package com.sulake.habbo.discord.settings
{
   import com.sulake.habbo.communication.messages.parser.discord.DiscordPreferences;
   
   public interface IDiscordSettingsController
   {
      function get preferences() : DiscordPreferences;
      
      function onDiscordConnected() : void;
   }
}

