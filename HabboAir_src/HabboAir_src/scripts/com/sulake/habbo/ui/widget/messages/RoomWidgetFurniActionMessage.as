package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetFurniActionMessage extends RoomWidgetMessage
   {
      public static const ROTATE:String = "RWFUAM_ROTATE";
      
      public static const MOVE:String = "RWFAM_MOVE";
      
      public static const UnknownConstFromRoomWidgetFurniActionMessage_String_1:String = "RWFAM_PICKUP";
      
      public static const UnknownConstFromRoomWidgetFurniActionMessage_String_2:String = "RWFAM_EJECT";
      
      public static const USE:String = "RWFAM_USE";
      
      public static const SAVE_STUFF_DATA:String = "RWFAM_SAVE_STUFF_DATA";
      
      public static const UnknownConstFromRoomWidgetUserActionMessage_String_2:String = "RWFAM_WIRED_INSPECT";
      
      private var _furniId:int = 0;
      
      private var _furniCategory:int = 0;
      
      private var _offerId:int;
      
      private var _objectData:String;
      
      public function RoomWidgetFurniActionMessage(param1:String, param2:int, param3:int, param4:int = -1, param5:String = null)
      {
         super(param1);
         _furniId = param2;
         _furniCategory = param3;
         _offerId = param4;
         _objectData = param5;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get furniCategory() : int
      {
         return _furniCategory;
      }
      
      public function get objectData() : String
      {
         return _objectData;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
   }
}

