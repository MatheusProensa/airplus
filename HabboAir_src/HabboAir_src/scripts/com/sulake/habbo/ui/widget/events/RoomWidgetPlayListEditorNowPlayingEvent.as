package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPlayListEditorNowPlayingEvent extends RoomWidgetUpdateEvent
   {
      public static const USER_PLAY_SONG:String = "RWPLENPE_USER_PLAY_SONG";
      
      public static const USER_STOP_SONG:String = "RWPLENPW_USER_STOP_SONG";
      
      public static const NOW_PLAYING_SONG_CHANGED:String = "RWPLENPE_SONG_CHANGED";
      
      private var _id:int;
      
      private var _position:int;
      
      private var _priority:int;
      
      public function RoomWidgetPlayListEditorNowPlayingEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         _id = param2;
         _position = param3;
         _priority = param4;
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

