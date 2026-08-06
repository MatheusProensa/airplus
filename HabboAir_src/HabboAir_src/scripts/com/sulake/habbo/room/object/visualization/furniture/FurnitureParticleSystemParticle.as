package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.geom.Vector3D;
   
   public class FurnitureParticleSystemParticle
   {
      private var _x:Number;
      
      private var _y:Number;
      
      private var _z:Number;
      
      private var _lastX:Number;
      
      private var _lastY:Number;
      
      private var _lastZ:Number;
      
      private var _hasMoved:Boolean = false;
      
      private var _direction:Vector3D;
      
      private var _age:int = 0;
      
      private var _lifeTime:int;
      
      private var _isEmitter:Boolean = false;
      
      private var _fade:Boolean = false;
      
      private var _fadeTime:Number;
      
      private var _alphaMultiplier:Number = 1;
      
      private var _frames:Array;
      
      public function FurnitureParticleSystemParticle()
      {
         super();
      }
      
      public function get fade() : Boolean
      {
         return _fade;
      }
      
      public function get alphaMultiplier() : Number
      {
         return _alphaMultiplier;
      }
      
      public function get direction() : Vector3D
      {
         return _direction;
      }
      
      public function get age() : int
      {
         return _age;
      }
      
      public function init(param1:Number, param2:Number, param3:Number, param4:Vector3D, param5:Number, param6:Number, param7:int, param8:Boolean = false, param9:Array = null, param10:Boolean = false) : void
      {
         _x = param1;
         _y = param2;
         _z = param3;
         _direction = new Vector3D(param4.x,param4.y,param4.z);
         _direction.scaleBy(param5);
         _lastX = _x - _direction.x * param6;
         _lastY = _y - _direction.y * param6;
         _lastZ = _z - _direction.z * param6;
         _age = 0;
         _hasMoved = false;
         _lifeTime = param7;
         _isEmitter = param8;
         _frames = param9;
         _fade = param10;
         _alphaMultiplier = 1;
         _fadeTime = 0.5 + Math.random() * 0.5;
      }
      
      public function update() : void
      {
         _age++;
         if(_age == _lifeTime)
         {
            ignite();
         }
         if(_fade)
         {
            if(_age / _lifeTime > _fadeTime)
            {
               _alphaMultiplier = (_lifeTime - _age) / (_lifeTime * (1 - _fadeTime));
            }
         }
      }
      
      public function getAsset() : IGraphicAsset
      {
         if(_frames && _frames.length > 0)
         {
            return _frames[_age % _frames.length];
         }
         return null;
      }
      
      protected function ignite() : void
      {
      }
      
      public function get isEmitter() : Boolean
      {
         return _isEmitter;
      }
      
      public function get isAlive() : Boolean
      {
         return _age <= _lifeTime;
      }
      
      public function dispose() : void
      {
         _direction = null;
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
      
      public function get lastX() : Number
      {
         return _lastX;
      }
      
      public function set lastX(param1:Number) : void
      {
         _hasMoved = true;
         _lastX = param1;
      }
      
      public function get lastY() : Number
      {
         return _lastY;
      }
      
      public function set lastY(param1:Number) : void
      {
         _hasMoved = true;
         _lastY = param1;
      }
      
      public function get lastZ() : Number
      {
         return _lastZ;
      }
      
      public function set lastZ(param1:Number) : void
      {
         _hasMoved = true;
         _lastZ = param1;
      }
      
      public function get hasMoved() : Boolean
      {
         return _hasMoved;
      }
      
      public function toString() : String
      {
         return [_x,_y,_z].toString();
      }
      
      public function copy(param1:FurnitureParticleSystemParticle, param2:Number) : void
      {
         _x = param1._x * param2;
         _y = param1._y * param2;
         _z = param1._z * param2;
         _lastX = param1._lastX * param2;
         _lastY = param1._lastY * param2;
         _lastZ = param1._lastZ * param2;
         _hasMoved = param1.hasMoved;
         _direction = param1._direction;
         _age = param1._age;
         _lifeTime = param1._lifeTime;
         _isEmitter = param1._isEmitter;
         _fade = param1._fade;
         _fadeTime = param1._fadeTime;
         _alphaMultiplier = param1._alphaMultiplier;
      }
   }
}

