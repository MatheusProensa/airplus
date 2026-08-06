package com.sulake.habbo.groups.events
{
   import flash.events.Event;
   
   public class GuildSettingsChangedInManageEvent extends Event
   {
      public static const GUILD_VISUAL_SETTINGS_CHANGED:String = "GSCIME_GUILD_VISUAL_SETTINGS_CHANGED";
      
      private var _guildId:int;
      
      public function GuildSettingsChangedInManageEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _guildId = param2;
      }
      
      public function get guildId() : int
      {
         return _guildId;
      }
   }
}

