package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetClothingChangeMessage extends RoomWidgetMessage
   {
      public static const REQUEST_EDITOR:String = "RWCCM_REQUEST_EDITOR";
      
      private var _objectId:int = 0;
      
      private var _objectCategory:int = 0;
      
      private var _roomId:int = 0;
      
      private var _gender:String = "";
      
      public function RoomWidgetClothingChangeMessage(param1:String, param2:String, param3:int, param4:int, param5:int)
      {
         super(param1);
         _gender = param2;
         _objectId = param3;
         _objectCategory = param4;
         _roomId = param5;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectCategory() : int
      {
         return _objectCategory;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
   }
}

