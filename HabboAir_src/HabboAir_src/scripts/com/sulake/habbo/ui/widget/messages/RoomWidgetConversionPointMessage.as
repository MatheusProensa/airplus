package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetConversionPointMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetConversionPointMessage_String_1:String = "RWCPM_CONVERSION_POINT";
      
      private var _category:String;
      
      private var _pointType:String;
      
      private var _action:String;
      
      private var _extraString:String;
      
      private var _extraInt:int;
      
      public function RoomWidgetConversionPointMessage(param1:String, param2:String, param3:String, param4:String, param5:String = "", param6:int = 0)
      {
         super(param1);
         _category = param2;
         _pointType = param3;
         _action = param4;
         _extraString = !!param5 ? param5 : "";
         _extraInt = !!param6 ? param6 : 0;
      }
      
      public function get category() : String
      {
         return _category;
      }
      
      public function get pointType() : String
      {
         return _pointType;
      }
      
      public function get action() : String
      {
         return _action;
      }
      
      public function get extraString() : String
      {
         return _extraString;
      }
      
      public function get extraInt() : int
      {
         return _extraInt;
      }
   }
}

