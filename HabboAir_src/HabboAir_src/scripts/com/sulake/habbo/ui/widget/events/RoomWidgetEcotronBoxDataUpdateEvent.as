package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetEcotronBoxDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UPDATE_PACKAGEINFO:String = "RWEBDUE_PACKAGEINFO";
      
      public static const UnknownConstFromRoomWidgetEcotronBoxDataUpdateEvent_String_1:String = "RWEBDUE_CONTENTS";
      
      private var _objectId:int = -1;
      
      private var _text:String;
      
      private var _furniTypeName:String;
      
      private var _controller:Boolean;
      
      private var _iconBitmapData:BitmapData;
      
      public function RoomWidgetEcotronBoxDataUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean = false, param6:BitmapData = null, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param7,param8);
         _objectId = param2;
         _text = param3;
         _furniTypeName = param4;
         _controller = param5;
         _iconBitmapData = param6;
      }
      
      public function get objectId() : int
      {
         return _objectId;
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
      
      public function get furniTypeName() : String
      {
         return _furniTypeName;
      }
   }
}

