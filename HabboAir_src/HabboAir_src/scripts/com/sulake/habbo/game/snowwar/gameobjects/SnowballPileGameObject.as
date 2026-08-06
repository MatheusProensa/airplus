package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballPileGameObjectData;
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.Tile;
   
   public class SnowballPileGameObject extends SnowballGivingGameObject
   {
      private static const BOUNDING_DATA_PER_SNOWBALL:int = 100;
      
      private var _boundingData:Array;
      
      private var _maxSnowballs:int;
      
      public function SnowballPileGameObject(param1:SnowballPileGameObjectData, param2:SnowWarGameStage)
      {
         super(param1.id,param1.snowballCount,param2.getTileAt(Tile.convertToTileX(param1.locationX3D),Tile.convertToTileY(param1.locationY3D)),param1.fuseObjectId);
         _maxSnowballs = param1.maxSnowballs;
         if(_snowballCount > 0)
         {
            param2.addGameObjectToTile(this);
         }
         _boundingData = [_snowballCount * 100];
      }
      
      override public function get numberOfVariables() : int
      {
         return 7;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 3;
            case 1:
               return _gameObjectId;
            case 2:
               return UnknownVarFromSnowballGivingGameObject_Tile_1.location.x;
            case 3:
               return UnknownVarFromSnowballGivingGameObject_Tile_1.location.y;
            case 4:
               return _maxSnowballs;
            case 5:
               return _snowballCount;
            case 6:
               return _fuseObjectId;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      override public function get boundingData() : Array
      {
         return _boundingData;
      }
      
      override protected function onSnowballPickup() : void
      {
         _boundingData = [_snowballCount * 100];
         if(_snowballCount <= 0)
         {
            UnknownVarFromSnowballGivingGameObject_Tile_1.removeGameObject();
         }
      }
      
      public function get maxSnowballs() : int
      {
         return _maxSnowballs;
      }
   }
}

