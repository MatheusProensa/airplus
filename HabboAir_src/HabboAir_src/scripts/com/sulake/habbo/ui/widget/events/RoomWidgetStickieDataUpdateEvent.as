package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetStickieDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UPDATE_STICKIE_DATA:String = "RWSDUE_STICKIE_DATA";
      
      private var _objectId:int = -1;
      
      private var _objectType:String;
      
      private var _text:String;
      
      private var _colorHex:String;
      
      private var _controller:Boolean;
      
      public function RoomWidgetStickieDataUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param7,param8);
         _objectId = param2;
         _objectType = param3;
         _text = param4;
         _colorHex = param5;
         _controller = param6;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectType() : String
      {
         return _objectType;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get colorHex() : String
      {
         return _colorHex;
      }
      
      public function get controller() : Boolean
      {
         return _controller;
      }
   }
}

