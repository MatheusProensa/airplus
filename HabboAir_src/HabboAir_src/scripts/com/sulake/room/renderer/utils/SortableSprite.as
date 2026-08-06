package com.sulake.room.renderer.utils
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.ISortableSprite;
   
   [SecureSWF(rename="true")]
   public class SortableSprite implements ISortableSprite
   {
      public static const UnknownConstFromSortableSprite_Number_1:Number = 100000000;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _z:Number = 0;
      
      public var name:String = "";
      
      private var _sprite:IRoomObjectSprite = null;
      
      public function SortableSprite()
      {
         super();
      }
      
      public function dispose() : void
      {
         _sprite = null;
         _z = -100000000;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set z(param1:Number) : void
      {
         _z = param1;
      }
      
      public function get sprite() : IRoomObjectSprite
      {
         return _sprite;
      }
      
      public function set sprite(param1:IRoomObjectSprite) : void
      {
         _sprite = param1;
      }
   }
}

