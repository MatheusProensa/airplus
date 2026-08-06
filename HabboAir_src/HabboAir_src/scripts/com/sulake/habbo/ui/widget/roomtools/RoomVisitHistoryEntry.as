package com.sulake.habbo.ui.widget.roomtools
{
   public class RoomVisitHistoryEntry
   {
      private var _flatId:int;
      
      private var _roomName:String;
      
      public function RoomVisitHistoryEntry(param1:int, param2:String)
      {
         super();
         _flatId = param1;
         _roomName = param2;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function set roomName(param1:String) : void
      {
         _roomName = param1;
      }
      
      public function copy() : RoomVisitHistoryEntry
      {
         return new RoomVisitHistoryEntry(_flatId,_roomName);
      }
   }
}

