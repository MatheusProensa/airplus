package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectRoomFloorHoleUpdateMessage extends RoomObjectUpdateMessage
   {
      public static const ADD_HOLE:String = "RORPFHUM_ADD";
      
      public static const REMOVE_HOLE:String = "RORPFHUM_REMOVE";
      
      private var _type:String = "";
      
      private var _id:int;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _invert:Boolean;
      
      public function RoomObjectRoomFloorHoleUpdateMessage(param1:String, param2:int, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:Boolean = false)
      {
         super(null,null);
         _type = param1;
         _id = param2;
         _x = param3;
         _y = param4;
         _width = param5;
         _height = param6;
         _invert = param7;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get invert() : Boolean
      {
         return _invert;
      }
   }
}

