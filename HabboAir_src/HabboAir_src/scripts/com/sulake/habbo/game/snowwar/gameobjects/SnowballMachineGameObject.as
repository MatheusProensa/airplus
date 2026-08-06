package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballMachineGameObjectData;
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   
   public class SnowballMachineGameObject extends SnowballGivingGameObject
   {
      public static var BOUNDING_DATA:Array = [1200];
      
      private var _maxSnowballs:int;
      
      private var UnknownVarFromSnowballMachineGameObject_Direction8_1:Direction8;
      
      public function SnowballMachineGameObject(param1:SnowballMachineGameObjectData, param2:SnowWarGameStage)
      {
         super(param1.id,param1.snowballCount,param2.getTileAt(Tile.convertToTileX(param1.locationX3D),Tile.convertToTileY(param1.locationY3D)),param1.fuseObjectId);
         _maxSnowballs = param1.maxSnowballs;
         UnknownVarFromSnowballMachineGameObject_Direction8_1 = Direction8.getDirection8(param1.direction);
         param2.addGameObjectToTile(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromSnowballMachineGameObject_Direction8_1 = null;
      }
      
      override public function get numberOfVariables() : int
      {
         return 8;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 4;
            case 1:
               return _gameObjectId;
            case 2:
               return UnknownVarFromSnowballGivingGameObject_Tile_1.location.x;
            case 3:
               return UnknownVarFromSnowballGivingGameObject_Tile_1.location.y;
            case 4:
               return UnknownVarFromSnowballMachineGameObject_Direction8_1.intValue();
            case 5:
               return _maxSnowballs;
            case 6:
               return _snowballCount;
            case 7:
               return _fuseObjectId;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      override public function get boundingData() : Array
      {
         return BOUNDING_DATA;
      }
      
      public function createSnowball() : void
      {
         if(_snowballCount < _maxSnowballs)
         {
            _snowballCount++;
         }
      }
   }
}

