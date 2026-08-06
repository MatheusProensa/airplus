package com.sulake.habbo.room.events
{
   public class RoomEngineObjectEvent extends RoomEngineEvent
   {
      public static const UnknownConstFromRoomEngineObjectEvent_String_1:String = "REOE_SELECTED";
      
      public static const DESELECTED:String = "REOE_DESELECTED";
      
      public static const ADDED:String = "REOE_ADDED";
      
      public static const REMOVED:String = "REOE_REMOVED";
      
      public static const UnknownConstFromRoomEngineObjectEvent_String_2:String = "REOE_UPDATED";
      
      public static const PLACED:String = "REOE_PLACED";
      
      public static const PLACED_ON_USER:String = "REOE_PLACED_ON_USER";
      
      public static const CONTENT_UPDATED:String = "REOE_CONTENT_UPDATED";
      
      public static const REQUEST_MOVE:String = "REOE_REQUEST_MOVE";
      
      public static const REQUEST_ROTATE:String = "REOE_REQUEST_ROTATE";
      
      public static const REQUEST_PICKUP:String = "REOE_REQUEST_PICKUP";
      
      public static const MOUSE_ENTER:String = "REOE_MOUSE_ENTER";
      
      public static const MOUSE_LEAVE:String = "REOE_MOUSE_LEAVE";
      
      private var _objectId:int;
      
      private var _category:int;
      
      public function RoomEngineObjectEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param5,param6);
         _objectId = param3;
         _category = param4;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get category() : int
      {
         return _category;
      }
   }
}

