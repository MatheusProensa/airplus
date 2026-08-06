package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameObject;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.utils.CollisionDetection;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.UnknownIHabboGameSnowwarUtils1;
   
   public class SnowWarGameObject implements ISynchronizedGameObject, UnknownIHabboGameSnowwarUtils1
   {
      protected var _active:Boolean = false;
      
      protected var _gameObjectId:int = -1;
      
      protected var _isGhost:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function SnowWarGameObject(param1:int, param2:Boolean)
      {
         super();
         _gameObjectId = param2 ? -param1 : param1;
         _isGhost = param2;
      }
      
      public function dispose() : void
      {
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isActive() : Boolean
      {
         return _active;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this._active = param1;
      }
      
      public function get numberOfVariables() : int
      {
         return -1;
      }
      
      public function getVariable(param1:int) : int
      {
         return -1;
      }
      
      public function get gameObjectId() : int
      {
         return _gameObjectId;
      }
      
      public function set gameObjectId(param1:int) : void
      {
         _gameObjectId = param1;
      }
      
      public function subturn(param1:SynchronizedGameStage) : void
      {
      }
      
      public function get boundingType() : int
      {
         return 0;
      }
      
      public function get boundingData() : Array
      {
         return null;
      }
      
      public function get location3D() : Location3D
      {
         return null;
      }
      
      public function get direction360() : Direction360
      {
         return null;
      }
      
      public function get isGhost() : Boolean
      {
         return _isGhost;
      }
      
      public function get ghostObjectId() : int
      {
         return -(_gameObjectId + 1);
      }
      
      public function onRemove() : void
      {
      }
      
      public function get collisionHeight() : int
      {
         return boundingData[0];
      }
      
      public function testSnowBallCollision(param1:SnowBallGameObject) : Boolean
      {
         return param1.location3D.z < collisionHeight && CollisionDetection.testForObjectToObjectCollision(this,param1);
      }
      
      public function onSnowBallHit(param1:SnowWarGameStage, param2:SnowBallGameObject) : void
      {
      }
   }
}

