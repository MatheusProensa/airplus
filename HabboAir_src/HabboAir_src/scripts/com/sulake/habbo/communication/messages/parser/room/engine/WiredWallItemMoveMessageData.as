package com.sulake.habbo.communication.messages.parser.room.engine
{
   [SecureSWF(rename="true")]
   public class WiredWallItemMoveMessageData
   {
      private var _itemId:int;
      
      private var _isDirectionRight:Boolean;
      
      private var _oldWallX:int;
      
      private var _oldWallY:int;
      
      private var _oldOffsetX:int;
      
      private var _oldOffsetY:int;
      
      private var _newWallX:int;
      
      private var _newWallY:int;
      
      private var _newOffsetX:int;
      
      private var _newOffsetY:int;
      
      private var _animationTime:Number;
      
      public function WiredWallItemMoveMessageData(param1:int, param2:Boolean, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Number)
      {
         super();
         _itemId = param1;
         _isDirectionRight = param2;
         _oldWallX = param3;
         _oldWallY = param4;
         _oldOffsetX = param5;
         _oldOffsetY = param6;
         _newWallX = param7;
         _newWallY = param8;
         _newOffsetX = param9;
         _newOffsetY = param10;
         _animationTime = param11;
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get isDirectionRight() : Boolean
      {
         return _isDirectionRight;
      }
      
      public function get oldWallX() : int
      {
         return _oldWallX;
      }
      
      public function get oldWallY() : int
      {
         return _oldWallY;
      }
      
      public function get oldOffsetX() : int
      {
         return _oldOffsetX;
      }
      
      public function get oldOffsetY() : int
      {
         return _oldOffsetY;
      }
      
      public function get newWallX() : int
      {
         return _newWallX;
      }
      
      public function get newWallY() : int
      {
         return _newWallY;
      }
      
      public function get newOffsetX() : int
      {
         return _newOffsetX;
      }
      
      public function get newOffsetY() : int
      {
         return _newOffsetY;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
   }
}

