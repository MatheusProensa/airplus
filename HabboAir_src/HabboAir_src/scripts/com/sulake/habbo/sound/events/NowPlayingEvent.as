package com.sulake.habbo.sound.events
{
   import flash.events.Event;
   
   public class NowPlayingEvent extends Event
   {
      public static const USER_PLAY_SONG:String = "NPE_USER_PLAY_SONG";
      
      public static const USER_STOP_SONG:String = "NPW_USER_STOP_SONG";
      
      public static const NOW_PLAYING_SONG_CHANGED:String = "NPE_SONG_CHANGED";
      
      private var _id:int;
      
      private var _position:int;
      
      private var _priority:int;
      
      public function NowPlayingEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         _id = param3;
         _position = param4;
         _priority = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
   }
}

