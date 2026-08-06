package com.sulake.habbo.avatar.geometry
{
   public class Vector3D
   {
      private var _x:Number;
      
      private var _y:Number;
      
      private var _z:Number;
      
      public function Vector3D(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         _x = param1;
         _y = param2;
         _z = param3;
      }
      
      public static function dot(param1:Vector3D, param2:Vector3D) : Number
      {
         return param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
      }
      
      public static function cross(param1:Vector3D, param2:Vector3D) : Vector3D
      {
         var _loc3_:Vector3D = new Vector3D();
         _loc3_.x = param1.y * param2.z - param1.z * param2.y;
         _loc3_.y = param1.z * param2.x - param1.x * param2.z;
         _loc3_.z = param1.x * param2.y - param1.y * param2.x;
         return _loc3_;
      }
      
      public static function subtract(param1:Vector3D, param2:Vector3D) : Vector3D
      {
         return new Vector3D(param1.x - param2.x,param1.y - param2.y,param1.z - param2.z);
      }
      
      public function dot(param1:Vector3D) : Number
      {
         return _x * param1.x + _y * param1.y + _z * param1.z;
      }
      
      public function cross(param1:Vector3D) : Vector3D
      {
         var _loc2_:Vector3D = new Vector3D();
         _loc2_.x = _y * param1.z - _z * param1.y;
         _loc2_.y = _z * param1.x - _x * param1.z;
         _loc2_.z = _x * param1.y - _y * param1.x;
         return _loc2_;
      }
      
      public function subtract(param1:Vector3D) : void
      {
         _x -= param1.x;
         _y -= param1.y;
         _z -= param1.z;
      }
      
      public function add(param1:Vector3D) : void
      {
         _x += param1.x;
         _y += param1.y;
         _z += param1.z;
      }
      
      public function normalize() : void
      {
         var _loc1_:Number = 1 / this.length();
         _x *= _loc1_;
         _y *= _loc1_;
         _z *= _loc1_;
      }
      
      public function length() : Number
      {
         return Math.sqrt(_x * _x + _y * _y + _z * _z);
      }
      
      public function toString() : String
      {
         return "Vector3D: (" + _x + "," + _y + "," + _z + ")";
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      public function set z(param1:Number) : void
      {
         _z = param1;
      }
   }
}

