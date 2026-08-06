package com.sulake.room.events
{
   public class RoomSpriteMouseEvent
   {
      private var _type:String = "";
      
      private var _eventId:String = "";
      
      private var _canvasId:String = "";
      
      private var _spriteTag:String = "";
      
      private var _screenX:Number = 0;
      
      private var _screenY:Number = 0;
      
      private var _localX:Number = 0;
      
      private var _localY:Number = 0;
      
      private var _ctrlKey:Boolean = false;
      
      private var _altKey:Boolean = false;
      
      private var _shiftKey:Boolean = false;
      
      private var _buttonDown:Boolean = false;
      
      private var _spriteOffsetX:int = 0;
      
      private var _spriteOffsetY:int = 0;
      
      public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:Number, param7:Number = 0, param8:Number = 0, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false)
      {
         super();
         _type = param1;
         _eventId = param2;
         _canvasId = param3;
         _spriteTag = param4;
         _screenX = param5;
         _screenY = param6;
         _localX = param7;
         _localY = param8;
         _ctrlKey = param9;
         _altKey = param10;
         _shiftKey = param11;
         _buttonDown = param12;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get eventId() : String
      {
         return _eventId;
      }
      
      public function get canvasId() : String
      {
         return _canvasId;
      }
      
      public function get spriteTag() : String
      {
         return _spriteTag;
      }
      
      public function get screenX() : Number
      {
         return _screenX;
      }
      
      public function get screenY() : Number
      {
         return _screenY;
      }
      
      public function get localX() : Number
      {
         return _localX;
      }
      
      public function get localY() : Number
      {
         return _localY;
      }
      
      public function get ctrlKey() : Boolean
      {
         return _ctrlKey;
      }
      
      public function get altKey() : Boolean
      {
         return _altKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return _shiftKey;
      }
      
      public function get buttonDown() : Boolean
      {
         return _buttonDown;
      }
      
      public function get spriteOffsetX() : int
      {
         return _spriteOffsetX;
      }
      
      public function set spriteOffsetX(param1:int) : void
      {
         _spriteOffsetX = param1;
      }
      
      public function get spriteOffsetY() : int
      {
         return _spriteOffsetY;
      }
      
      public function set spriteOffsetY(param1:int) : void
      {
         _spriteOffsetY = param1;
      }
   }
}

