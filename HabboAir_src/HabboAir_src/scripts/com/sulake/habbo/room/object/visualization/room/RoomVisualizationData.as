package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.UnknownIHabboRoomObjectVisualizationRoomRasterizer1;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.LandscapeRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.FloorRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallAdRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallRasterizer;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   
   public class RoomVisualizationData implements IRoomObjectVisualizationData
   {
      private var _wallRasterizer:WallRasterizer;
      
      private var _floorRasterizer:FloorRasterizer;
      
      private var _wallAdRasterizr:WallAdRasterizer;
      
      private var _landscapeRasterizer:LandscapeRasterizer;
      
      private var _maskManager:PlaneMaskManager;
      
      private var _initialized:Boolean = false;
      
      public function RoomVisualizationData()
      {
         super();
         _wallRasterizer = new WallRasterizer();
         _floorRasterizer = new FloorRasterizer();
         _wallAdRasterizr = new WallAdRasterizer();
         _landscapeRasterizer = new LandscapeRasterizer();
         _maskManager = new PlaneMaskManager();
      }
      
      public function get initialized() : Boolean
      {
         return _initialized;
      }
      
      public function get floorRasterizer() : UnknownIHabboRoomObjectVisualizationRoomRasterizer1
      {
         return _floorRasterizer;
      }
      
      public function get wallRasterizer() : UnknownIHabboRoomObjectVisualizationRoomRasterizer1
      {
         return _wallRasterizer;
      }
      
      public function get wallAdRasterizr() : WallAdRasterizer
      {
         return _wallAdRasterizr;
      }
      
      public function get landscapeRasterizer() : UnknownIHabboRoomObjectVisualizationRoomRasterizer1
      {
         return _landscapeRasterizer;
      }
      
      public function get maskManager() : PlaneMaskManager
      {
         return _maskManager;
      }
      
      public function dispose() : void
      {
         if(_wallRasterizer != null)
         {
            _wallRasterizer.dispose();
            _wallRasterizer = null;
         }
         if(_floorRasterizer != null)
         {
            _floorRasterizer.dispose();
            _floorRasterizer = null;
         }
         if(_wallAdRasterizr != null)
         {
            _wallAdRasterizr.dispose();
            _wallAdRasterizr = null;
         }
         if(_landscapeRasterizer != null)
         {
            _landscapeRasterizer.dispose();
            _landscapeRasterizer = null;
         }
         if(_maskManager != null)
         {
            _maskManager.dispose();
            _maskManager = null;
         }
      }
      
      public function clearCache() : void
      {
         if(_wallRasterizer != null)
         {
            _wallRasterizer.clearCache();
         }
         if(_floorRasterizer != null)
         {
            _floorRasterizer.clearCache();
         }
         if(_landscapeRasterizer != null)
         {
            _landscapeRasterizer.clearCache();
         }
      }
      
      public function initialize(param1:XML) : Boolean
      {
         var _loc4_:XML = null;
         var _loc3_:XML = null;
         var _loc7_:XML = null;
         var _loc11_:XML = null;
         var _loc6_:XML = null;
         reset();
         if(param1 == null)
         {
            return false;
         }
         var _loc5_:XMLList = param1.wallData;
         if(_loc5_.length() > 0)
         {
            _loc4_ = _loc5_[0];
            _wallRasterizer.initialize(_loc4_);
         }
         var _loc2_:XMLList = param1.floorData;
         if(_loc2_.length() > 0)
         {
            _loc3_ = _loc2_[0];
            _floorRasterizer.initialize(_loc3_);
         }
         var _loc10_:XMLList = param1.wallAdData;
         if(_loc10_.length() > 0)
         {
            _loc7_ = _loc10_[0];
            _wallAdRasterizr.initialize(_loc7_);
         }
         var _loc8_:XMLList = param1.landscapeData;
         if(_loc8_.length() > 0)
         {
            _loc11_ = _loc8_[0];
            _landscapeRasterizer.initialize(_loc11_);
         }
         var _loc9_:XMLList = param1.maskData;
         if(_loc9_.length() > 0)
         {
            _loc6_ = _loc9_[0];
            _maskManager.initialize(_loc6_);
         }
         return true;
      }
      
      public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         if(_initialized)
         {
            return;
         }
         _wallRasterizer.initializeAssetCollection(param1);
         _floorRasterizer.initializeAssetCollection(param1);
         _wallAdRasterizr.initializeAssetCollection(param1);
         _landscapeRasterizer.initializeAssetCollection(param1);
         _maskManager.initializeAssetCollection(param1);
         _initialized = true;
      }
      
      protected function reset() : void
      {
      }
   }
}

