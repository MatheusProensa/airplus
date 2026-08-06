package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   
   public class SnowballGivingGameObject extends SnowWarGameObject
   {
      protected var _fuseObjectId:int;
      
      protected var _snowballCount:int;
      
      protected var UnknownVarFromSnowballGivingGameObject_Tile_1:Tile;
      
      public function SnowballGivingGameObject(param1:int, param2:int, param3:Tile, param4:int)
      {
         super(param1,false);
         _active = true;
         _snowballCount = param2;
         UnknownVarFromSnowballGivingGameObject_Tile_1 = param3;
         _fuseObjectId = param4;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromSnowballGivingGameObject_Tile_1 = null;
      }
      
      override public function get direction360() : Direction360
      {
         return null;
      }
      
      override public function get boundingType() : int
      {
         return 2;
      }
      
      override public function get location3D() : Location3D
      {
         return UnknownVarFromSnowballGivingGameObject_Tile_1.location;
      }
      
      public function get fuseObjectId() : int
      {
         return _fuseObjectId;
      }
      
      public function get snowballCount() : int
      {
         return _snowballCount;
      }
      
      override public function subturn(param1:SynchronizedGameStage) : void
      {
      }
      
      public function pickupSnowballs(param1:int) : int
      {
         if(_snowballCount < param1)
         {
            param1 = _snowballCount;
         }
         _snowballCount -= param1;
         onSnowballPickup();
         return param1;
      }
      
      override public function onSnowBallHit(param1:SnowWarGameStage, param2:SnowBallGameObject) : void
      {
      }
      
      protected function onSnowballPickup() : void
      {
      }
   }
}

