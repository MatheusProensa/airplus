package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class RoomObjectRoomAdEvent extends RoomObjectEvent
   {
      public static const ROOM_AD_LOAD_IMAGE:String = "RORAE_ROOM_AD_LOAD_IMAGE";
      
      public static const ROOM_AD_FURNI_CLICK:String = "RORAE_ROOM_AD_FURNI_CLICK";
      
      public static const ROOM_AD_FURNI_DOUBLE_CLICK:String = "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK";
      
      public static const ROOM_AD_TOOLTIP_SHOW:String = "RORAE_ROOM_AD_TOOLTIP_SHOW";
      
      public static const ROOM_AD_TOOLTIP_HIDE:String = "RORAE_ROOM_AD_TOOLTIP_HIDE";
      
      private var _imageUrl:String = "";
      
      private var _clickUrl:String = "";
      
      public function RoomObjectRoomAdEvent(param1:String, param2:IRoomObject, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param5,param6);
         _imageUrl = param3;
         _clickUrl = param4;
      }
      
      public function get clickUrl() : String
      {
         return _clickUrl;
      }
      
      public function get imageUrl() : String
      {
         return _imageUrl;
      }
      
      override public function clone() : Event
      {
         return new RoomObjectRoomAdEvent(type,object,imageUrl,clickUrl,bubbles,cancelable);
      }
   }
}

