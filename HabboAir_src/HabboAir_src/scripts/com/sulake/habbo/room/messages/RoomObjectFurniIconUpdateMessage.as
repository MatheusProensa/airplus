package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectFurniIconUpdateMessage extends RoomObjectUpdateMessage
   {
      public static const BADGE_LOADED:String = "ROFIUM_FURNI_ICON_LOADED";
      
      private var _wallItem:Boolean;
      
      private var _typeId:int;
      
      private var _extra:String;
      
      private var _assetName:String;
      
      public function RoomObjectFurniIconUpdateMessage(param1:String, param2:Boolean, param3:int, param4:String)
      {
         super(null,null);
         _assetName = param1;
         _wallItem = param2;
         _typeId = param3;
         _extra = param4;
      }
      
      public function get assetName() : String
      {
         return _assetName;
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

