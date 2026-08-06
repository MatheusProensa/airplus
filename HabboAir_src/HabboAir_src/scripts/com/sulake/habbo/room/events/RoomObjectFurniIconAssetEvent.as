package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectFurniIconAssetEvent extends RoomObjectEvent
   {
      public static const UnknownConstFromRoomObjectFurniIconAssetEvent_String_1:String = "ROFIAE_LOAD_FURNI_ICON";
      
      private var _wallItem:Boolean;
      
      private var _typeId:int;
      
      private var _extra:String;
      
      public function RoomObjectFurniIconAssetEvent(param1:String, param2:IRoomObject, param3:Boolean, param4:int, param5:String, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param2,param6,param7);
         _wallItem = param3;
         _typeId = param4;
         _extra = param5;
      }
      
      public function get wallItem() : Boolean
      {
         return _wallItem;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get extra() : String
      {
         return _extra;
      }
   }
}

