package com.sulake.habbo.roomevents.events
{
   import flash.events.Event;
   
   public class WiredAchievementsUpdatedEvent extends Event
   {
      public static const WIRED_ACHIEVEMENTS_UPDATED:String = "WIRED_ACHIEVEMENTS_UPDATED";
      
      private var _achievements:Vector.<String>;
      
      public function WiredAchievementsUpdatedEvent(param1:String, param2:Vector.<String>, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _achievements = param2;
      }
      
      public function get achievements() : Vector.<String>
      {
         return _achievements;
      }
   }
}

