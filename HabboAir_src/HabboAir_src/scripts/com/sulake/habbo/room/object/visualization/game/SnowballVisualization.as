package com.sulake.habbo.room.object.visualization.game
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.furniture.SnowballVisualizationData;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   
   public class SnowballVisualization extends RoomObjectSpriteVisualization
   {
      private static const SNOWBALL_ASSET_NAME:String = "snowball_small_png";
      
      private static const SNOWBALL_SHADOW_ASSET_NAME:String = "snowball_small_shadow_png";
      
      private static const UnknownConstFromSnowballVisualization_Int_1:int = 16;
      
      private var UnknownVarFromSnowballVisualization_SnowballVisualizationData_1:SnowballVisualizationData;
      
      private var UnknownVarFromSnowballVisualization_IRoomObjectSprite_1:IRoomObjectSprite;
      
      public function SnowballVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         UnknownVarFromSnowballVisualization_IRoomObjectSprite_1 = null;
         super.dispose();
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         var _loc2_:BitmapDataAsset = null;
         UnknownVarFromSnowballVisualization_SnowballVisualizationData_1 = param1 as SnowballVisualizationData;
         createSprites(2);
         _loc2_ = UnknownVarFromSnowballVisualization_SnowballVisualizationData_1.assets.getAssetByName("snowball_small_png") as BitmapDataAsset;
         getSprite(0).asset = _loc2_.content as BitmapData;
         _loc2_ = UnknownVarFromSnowballVisualization_SnowballVisualizationData_1.assets.getAssetByName("snowball_small_shadow_png") as BitmapDataAsset;
         UnknownVarFromSnowballVisualization_IRoomObjectSprite_1 = getSprite(1);
         UnknownVarFromSnowballVisualization_IRoomObjectSprite_1.asset = _loc2_.content as BitmapData;
         UnknownVarFromSnowballVisualization_IRoomObjectSprite_1.alpha = 100;
         UnknownVarFromSnowballVisualization_IRoomObjectSprite_1.relativeDepth = 1;
         return true;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         UnknownVarFromSnowballVisualization_IRoomObjectSprite_1.offsetY = object.getLocation().z * 16;
         UnknownVarFromSnowballVisualization_IRoomObjectSprite_1.alpha = Math.max(0,100 - UnknownVarFromSnowballVisualization_IRoomObjectSprite_1.offsetY / 10);
      }
   }
}

