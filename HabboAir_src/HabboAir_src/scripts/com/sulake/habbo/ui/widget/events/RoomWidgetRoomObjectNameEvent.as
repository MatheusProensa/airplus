package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomObjectNameEvent extends RoomWidgetUpdateEvent
   {
      public static const OBJECT_NAME:String = "RWONE_TYPE";
      
      private var _userId:int;
      
      private var _category:int;
      
      private var _userName:String;
      
      private var _userType:int;
      
      private var _roomIndex:int;
      
      public function RoomWidgetRoomObjectNameEvent(param1:int, param2:int, param3:String, param4:int, param5:int)
      {
         _userId = param1;
         _category = param2;
         _userName = param3;
         _userType = param4;
         _roomIndex = param5;
         super("RWONE_TYPE",false,false);
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userType() : int
      {
         return _userType;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
   }
}

