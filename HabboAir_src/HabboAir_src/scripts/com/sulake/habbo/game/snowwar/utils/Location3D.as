package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public class Location3D implements IComponentInterfaceQueue
   {
      private var _x:int;
      
      private var _y:int;
      
      private var _z:int;
      
      private var _disposed:Boolean = false;
      
      public function Location3D(param1:int, param2:int, param3:int)
      {
         super();
         _x = param1;
         _y = param2;
         _z = param3;
      }
      
      public static function isInDistanceStatic(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         var _loc7_:int = param3 - param1;
         if(_loc7_ < 0)
         {
            _loc7_ = -_loc7_;
         }
         var _loc6_:int = param4 - param2;
         if(_loc6_ < 0)
         {
            _loc6_ = -_loc6_;
         }
         if(_loc6_ > param5 || _loc7_ > param5)
         {
            return false;
         }
         if(_loc7_ * _loc7_ + _loc6_ * _loc6_ < param5 * param5)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         _x = 0;
         _y = 0;
         _z = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get z() : int
      {
         return _z;
      }
      
      public function changeLocation(param1:int, param2:int, param3:int) : void
      {
         _x = param1;
         _y = param2;
         _z = param3;
      }
      
      public function change2DLocation(param1:int, param2:int) : void
      {
         _x = param1;
         _y = param2;
      }
      
      public function changeLocationToLocation(param1:Location3D) : void
      {
         _x = param1._x;
         _y = param1._y;
         _z = param1._z;
      }
      
      public function distanceTo(param1:Location3D) : int
      {
         var _loc2_:int = param1._x - _x;
         var _loc3_:int = param1._y - _y;
         var _loc4_:int = param1._z - _z;
         return int(Math.abs(_loc2_) + Math.abs(_loc3_) + Math.abs(_loc4_));
      }
      
      public function directionTo(param1:Location3D) : Direction8
      {
         if(param1._x == _x && param1._y == _y)
         {
            return null;
         }
         var _loc3_:int = param1._x - _x;
         var _loc2_:int = param1._y - _y;
         var _loc4_:int = Direction360.getAngleFromComponents(_loc3_,_loc2_);
         return Direction360.direction360ValueToDirection8(_loc4_);
      }
      
      public function equals(param1:Object) : Boolean
      {
         if(this == param1)
         {
            return true;
         }
         if(!(param1 is Location3D))
         {
            return false;
         }
         var _loc2_:Location3D = Location3D(param1);
         if(_x != _loc2_._x)
         {
            return false;
         }
         if(_y != _loc2_._y)
         {
            return false;
         }
         if(_z != _loc2_._z)
         {
            return false;
         }
         return true;
      }
      
      public function hashCode() : int
      {
         var _loc1_:int = 0;
         _loc1_ = _x;
         _loc1_ = 29 * _loc1_ + _y;
         return 29 * _loc1_ + _z;
      }
      
      public function toString() : String
      {
         return "_x:" + _x + "yy:" + _y + "_zz:" + _z;
      }
      
      public function isInDistance(param1:Location3D, param2:int) : Boolean
      {
         return isInDistanceStatic(_x,_y,param1._x,param1._y,param2);
      }
   }
}

