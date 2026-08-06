package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPlayListModificationMessage extends RoomWidgetMessage
   {
      public static const ADD_TO_PLAYLIST:String = "RWPLAM_ADD_TO_PLAYLIST";
      
      public static const REMOVE_FROM_PLAYLIST:String = "RWPLAM_REMOVE_FROM_PLAYLIST";
      
      private var _diskId:int;
      
      private var _slotNumber:int;
      
      public function RoomWidgetPlayListModificationMessage(param1:String, param2:int = -1, param3:int = -1)
      {
         super(param1);
         _slotNumber = param2;
         _diskId = param3;
      }
      
      public function get diskId() : int
      {
         return _diskId;
      }
      
      public function get slotNumber() : int
      {
         return _slotNumber;
      }
   }
}

