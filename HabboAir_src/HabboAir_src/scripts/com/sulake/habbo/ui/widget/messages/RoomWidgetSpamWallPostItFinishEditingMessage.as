package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetSpamWallPostItFinishEditingMessage extends RoomWidgetMessage
   {
      public static const SEND_POSTIT_DATA:String = "RWSWPFEE_SEND_POSTIT_DATA";
      
      private var _objectId:int;
      
      private var _location:String;
      
      private var _text:String;
      
      private var _colorHex:String;
      
      public function RoomWidgetSpamWallPostItFinishEditingMessage(param1:String, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1);
         _objectId = param2;
         _location = param3;
         _text = param4;
         _colorHex = param5;
      }
      
      public function get location() : String
      {
         return _location;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get colorHex() : String
      {
         return _colorHex;
      }
   }
}

