package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPresentDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UPDATE_PACKAGEINFO:String = "RWPDUE_PACKAGEINFO";
      
      public static const UnknownConstFromRoomWidgetEcotronBoxDataUpdateEvent_String_1:String = "RWPDUE_CONTENTS";
      
      public static const UnknownConstFromRoomWidgetPresentDataUpdateEvent_String_1:String = "RWPDUE_CONTENTS_CLUB";
      
      public static const UnknownConstFromRoomWidgetPresentDataUpdateEvent_String_2:String = "RWPDUE_CONTENTS_FLOOR";
      
      public static const UPDATE_CONTENTS_LANDSCAPE:String = "RWPDUE_CONTENTS_LANDSCAPE";
      
      public static const UPDATE_CONTENTS_WALLPAPER:String = "RWPDUE_CONTENTS_WALLPAPER";
      
      public static const UPDATE_CONTENTS_IMAGE:String = "RWPDUE_CONTENTS_IMAGE";
      
      private var _objectId:int = -1;
      
      private var _classId:int = 0;
      
      private var _itemType:String = "";
      
      private var _text:String;
      
      private var _controller:Boolean;
      
      private var _iconBitmapData:BitmapData;
      
      private var _purchaserName:String;
      
      private var _purchaserFigure:String;
      
      private var _placedItemId:int = -1;
      
      private var _placedItemType:String = "";
      
      private var _placedInRoom:Boolean;
      
      private var _trustedSender:Boolean;
      
      public function RoomWidgetPresentDataUpdateEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:BitmapData = null, param6:String = null, param7:String = null, param8:Boolean = false, param9:Boolean = false, param10:* = false)
      {
         super(param1,param8,param9);
         _objectId = param2;
         _text = param3;
         _controller = param4;
         _iconBitmapData = param5;
         _purchaserName = param6;
         _purchaserFigure = param7;
         _trustedSender = param10;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
      
      public function set classId(param1:int) : void
      {
         _classId = param1;
      }
      
      public function get itemType() : String
      {
         return _itemType;
      }
      
      public function set itemType(param1:String) : void
      {
         _itemType = param1;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get controller() : Boolean
      {
         return _controller;
      }
      
      public function get iconBitmapData() : BitmapData
      {
         return _iconBitmapData;
      }
      
      public function get purchaserName() : String
      {
         return _purchaserName;
      }
      
      public function get purchaserFigure() : String
      {
         return _purchaserFigure;
      }
      
      public function get placedItemId() : int
      {
         return _placedItemId;
      }
      
      public function set placedItemId(param1:int) : void
      {
         _placedItemId = param1;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function set placedInRoom(param1:Boolean) : void
      {
         _placedInRoom = param1;
      }
      
      public function get placedItemType() : String
      {
         return _placedItemType;
      }
      
      public function set placedItemType(param1:String) : void
      {
         _placedItemType = param1;
      }
      
      public function get trustedSender() : Boolean
      {
         return _trustedSender;
      }
   }
}

