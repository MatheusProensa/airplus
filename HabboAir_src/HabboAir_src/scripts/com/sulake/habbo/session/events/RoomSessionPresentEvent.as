package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPresentEvent extends RoomSessionEvent
   {
      public static const ROOM_SESSION_PRESENT_OPENED:String = "RSPE_PRESENT_OPENED";
      
      private var _classId:int = 0;
      
      private var _itemType:String = "";
      
      private var _productCode:String;
      
      private var _placedItemId:int = 0;
      
      private var _placedItemType:String = "";
      
      private var _placedInRoom:Boolean;
      
      private var _petFigureString:String;
      
      public function RoomSessionPresentEvent(param1:String, param2:IRoomSession, param3:int, param4:String, param5:String, param6:int, param7:String, param8:Boolean, param9:String, param10:Boolean = false, param11:Boolean = false)
      {
         super(param1,param2,param10,param11);
         _classId = param3;
         _itemType = param4;
         _productCode = param5;
         _placedItemId = param6;
         _placedItemType = param7;
         _placedInRoom = param8;
         _petFigureString = param9;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
      
      public function get itemType() : String
      {
         return _itemType;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get placedItemId() : int
      {
         return _placedItemId;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function get placedItemType() : String
      {
         return _placedItemType;
      }
      
      public function get petFigureString() : String
      {
         return _petFigureString;
      }
   }
}

