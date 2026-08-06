package com.sulake.room.events
{
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectMouseEvent extends RoomObjectEvent
   {
      public static const ROOM_OBJECT_MOUSE_CLICK:String = "ROE_MOUSE_CLICK";
      
      public static const ROOM_OBJECT_MOUSE_ENTER:String = "ROE_MOUSE_ENTER";
      
      public static const ROOM_OBJECT_MOUSE_MOVE:String = "ROE_MOUSE_MOVE";
      
      public static const ROOM_OBJECT_MOUSE_LEAVE:String = "ROE_MOUSE_LEAVE";
      
      public static const ROOM_OBJECT_MOUSE_DOUBLE_CLICK:String = "ROE_MOUSE_DOUBLE_CLICK";
      
      public static const ROOM_OBJECT_MOUSE_DOWN:String = "ROE_MOUSE_DOWN";
      
      private var _eventId:String = "";
      
      private var _altKey:Boolean;
      
      private var _ctrlKey:Boolean;
      
      private var _shiftKey:Boolean;
      
      private var _buttonDown:Boolean;
      
      private var _localX:int;
      
      private var _localY:int;
      
      private var _spriteOffsetX:int;
      
      private var _spriteOffsetY:int;
      
      public function RoomObjectMouseEvent(param1:String, param2:IRoomObject, param3:String, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false)
      {
         super(param1,param2,param8,param9);
         _eventId = param3;
         _altKey = param4;
         _ctrlKey = param5;
         _shiftKey = param6;
         _buttonDown = param7;
      }
      
      public function get eventId() : String
      {
         return _eventId;
      }
      
      public function get altKey() : Boolean
      {
         return _altKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return _ctrlKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return _shiftKey;
      }
      
      public function get buttonDown() : Boolean
      {
         return _buttonDown;
      }
      
      public function get localX() : int
      {
         return _localX;
      }
      
      public function get localY() : int
      {
         return _localY;
      }
      
      public function get spriteOffsetX() : int
      {
         return _spriteOffsetX;
      }
      
      public function get spriteOffsetY() : int
      {
         return _spriteOffsetY;
      }
      
      public function set localX(param1:int) : void
      {
         _localX = param1;
      }
      
      public function set localY(param1:int) : void
      {
         _localY = param1;
      }
      
      public function set spriteOffsetX(param1:int) : void
      {
         _spriteOffsetX = param1;
      }
      
      public function set spriteOffsetY(param1:int) : void
      {
         _spriteOffsetY = param1;
      }
   }
}

