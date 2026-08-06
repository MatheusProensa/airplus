package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPlayListEditorEvent extends RoomWidgetUpdateEvent
   {
      public static const SHOW_PLAYLIST_EDITOR:String = "RWPLEE_SHOW_PLAYLIST_EDITOR";
      
      public static const UnknownConstFromRoomWidgetPlayListEditorEvent_String_1:String = "RWPLEE_HIDE_PLAYLIST_EDITOR";
      
      public static const INVENTORY_UPDATED:String = "RWPLEE_INVENTORY_UPDATED";
      
      public static const SONG_DISK_INVENTORY_UPDATED:String = "RWPLEE_SONG_DISK_INVENTORY_UPDATED";
      
      public static const PLAY_LIST_UPDATED:String = "RWPLEE_PLAY_LIST_UPDATED";
      
      public static const PLAY_LIST_FULL:String = "RWPLEE_PLAY_LIST_FULL";
      
      private var _furniId:int;
      
      public function RoomWidgetPlayListEditorEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _furniId = param2;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
   }
}

