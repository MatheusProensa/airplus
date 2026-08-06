package com.sulake.habbo.session.events
{
   import flash.events.Event;
   
   public class SessionDataPreferencesEvent extends Event
   {
      public static const UnknownConstFromRoomEngineObjectEvent_String_2:String = "APUE_UPDATED";
      
      private var _uiFlags:int;
      
      public function SessionDataPreferencesEvent(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         _uiFlags = param1;
         super("APUE_UPDATED",param2,param3);
      }
      
      public function get uiFlags() : int
      {
         return _uiFlags;
      }
   }
}

