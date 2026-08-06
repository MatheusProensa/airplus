package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPlayListPlayStateMessage extends RoomWidgetMessage
   {
      public static const TOGGLE_PLAY_PAUSE:String = "RWPLPS_TOGGLE_PLAY_PAUSE";
      
      private var _furniId:int;
      
      private var _position:int;
      
      public function RoomWidgetPlayListPlayStateMessage(param1:String, param2:int, param3:int = -1)
      {
         super(param1);
         _furniId = param2;
         _position = param3;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get position() : int
      {
         return _position;
      }
   }
}

