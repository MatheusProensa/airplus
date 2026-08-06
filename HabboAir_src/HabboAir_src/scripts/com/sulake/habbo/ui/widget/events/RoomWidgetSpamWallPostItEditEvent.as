package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetSpamWallPostItEditEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetSpamWallPostItEditEvent_String_1:String = "RWSWPUE_OPEN_EDITOR";
      
      private var _objectId:int;
      
      private var _location:String;
      
      private var _objectType:String;
      
      public function RoomWidgetSpamWallPostItEditEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         _objectId = param2;
         _location = param3;
         _objectType = param4;
      }
      
      public function get location() : String
      {
         return _location;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectType() : String
      {
         return _objectType;
      }
   }
}

