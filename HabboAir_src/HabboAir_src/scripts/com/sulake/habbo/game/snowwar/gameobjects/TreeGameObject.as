package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.TreeGameObjectData;
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   
   public class TreeGameObject extends SnowWarGameObject
   {
      private static const NO_BOUNDING_DATA:Array = [0];
      
      private static const BOUNDING_DATA:Array = [3200 - SnowBallGameObject.BOUNDING_DATA[0] - 1];
      
      private var _fuseObjectId:int;
      
      private var _tile:Tile;
      
      private var _direction8:Direction8;
      
      private var _direction360:Direction360;
      
      private var _collisionHeight:int;
      
      private var _maxHits:int;
      
      private var _hits:int;
      
      public function TreeGameObject(param1:TreeGameObjectData, param2:SnowWarGameStage)
      {
         super(param1.id,false);
         isActive = true;
         _tile = param2.getTileAt(Tile.convertToTileX(param1.locationX3D),Tile.convertToTileY(param1.locationY3D));
         _direction8 = Direction8.getDirection8(param1.direction);
         _direction360 = new Direction360(Direction360.direction8ToDirection360Value(_direction8));
         _fuseObjectId = param1.fuseObjectId;
         _collisionHeight = param1.height;
         _hits = param1.hits;
         _maxHits = param1.maxHits;
         if(_hits < _maxHits)
         {
            param2.addGameObjectToTile(this);
         }
         _tile.addToHeight(-_collisionHeight);
         _tile.blocked = true;
      }
      
      override public function get numberOfVariables() : int
      {
         return 9;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 2;
            case 1:
               return gameObjectId;
            case 2:
               return _tile.location.x;
            case 3:
               return _tile.location.y;
            case 4:
               return _direction8.intValue();
            case 5:
               return _collisionHeight;
            case 6:
               return _fuseObjectId;
            case 7:
               return _maxHits;
            case 8:
               return _hits;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      override public function get boundingType() : int
      {
         return 2;
      }
      
      override public function subturn(param1:SynchronizedGameStage) : void
      {
      }
      
      override public function get boundingData() : Array
      {
         if(_hits < _maxHits)
         {
            return BOUNDING_DATA;
         }
         return NO_BOUNDING_DATA;
      }
      
      override public function get location3D() : Location3D
      {
         return _tile.location;
      }
      
      override public function get direction360() : Direction360
      {
         return _direction360;
      }
      
      override public function onSnowBallHit(param1:SnowWarGameStage, param2:SnowBallGameObject) : void
      {
         if(_hits < _maxHits)
         {
            _hits++;
         }
         if(_hits >= _maxHits)
         {
            _tile.removeGameObject();
         }
      }
      
      public function get maxHits() : int
      {
         return _maxHits;
      }
      
      public function get hits() : int
      {
         return _hits;
      }
      
      public function get fuseObjectId() : int
      {
         return _fuseObjectId;
      }
      
      override public function get collisionHeight() : int
      {
         return _collisionHeight;
      }
   }
}

