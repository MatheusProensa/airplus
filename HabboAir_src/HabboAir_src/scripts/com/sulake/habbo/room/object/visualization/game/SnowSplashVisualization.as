package com.sulake.habbo.room.object.visualization.game
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.furniture.SnowballVisualizationData;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   
   public class SnowSplashVisualization extends RoomObjectSpriteVisualization
   {
      private static const FRAME_ASSET_NAMES:Array = ["snowball_splash_1","snowball_splash_2","snowball_splash_3"];
      
      private var _frameNumber:int = 0;
      
      private var UnknownVarFromSnowSplashVisualization_SnowballVisualizationData_1:SnowballVisualizationData;
      
      public function SnowSplashVisualization()
      {
         super();
      }
      
      public function get isDone() : Boolean
      {
         return _frameNumber >= FRAME_ASSET_NAMES.length;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         var _loc2_:BitmapDataAsset = null;
         UnknownVarFromSnowSplashVisualization_SnowballVisualizationData_1 = param1 as SnowballVisualizationData;
         createSprites(1);
         _loc2_ = UnknownVarFromSnowSplashVisualization_SnowballVisualizationData_1.assets.getAssetByName(FRAME_ASSET_NAMES[_frameNumber]) as BitmapDataAsset;
         getSprite(0).asset = _loc2_.content as BitmapData;
         return true;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         _frameNumber++;
         getSprite(0).asset = isDone ? null : UnknownVarFromSnowSplashVisualization_SnowballVisualizationData_1.assets.getAssetByName(FRAME_ASSET_NAMES[_frameNumber]).content as BitmapData;
      }
   }
}

