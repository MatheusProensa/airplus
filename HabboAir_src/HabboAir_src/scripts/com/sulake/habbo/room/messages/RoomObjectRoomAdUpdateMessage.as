package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import flash.display.BitmapData;
   
   public class RoomObjectRoomAdUpdateMessage extends RoomObjectUpdateMessage
   {
      public static const ROOM_AD_ACTIVATE:String = "RORUM_ROOM_AD_ACTIVATE";
      
      public static const ROOM_BILLBOARD_IMAGE_LOADED:String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADED";
      
      public static const ROOM_BILLBOARD_LOADING_FAILED:String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED";
      
      private var _type:String;
      
      private var _asset:String;
      
      private var _clickUrl:String;
      
      private var _objectId:int;
      
      private var _bitmapData:BitmapData;
      
      public function RoomObjectRoomAdUpdateMessage(param1:String, param2:String, param3:String, param4:int = -1, param5:BitmapData = null)
      {
         super(null,null);
         _type = param1;
         _asset = param2;
         _clickUrl = param3;
         _objectId = param4;
         _bitmapData = param5;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get asset() : String
      {
         return _asset;
      }
      
      public function get clickUrl() : String
      {
         return _clickUrl;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
   }
}

