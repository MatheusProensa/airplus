package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class SnowballVisualizationData implements IRoomObjectVisualizationData
   {
      private var _assets:IAssetLibraryCollection;
      
      public function SnowballVisualizationData()
      {
         super();
      }
      
      public function dispose() : void
      {
         _assets = null;
      }
      
      public function initialize(param1:XML) : Boolean
      {
         return true;
      }
      
      public function set assets(param1:IAssetLibraryCollection) : void
      {
         _assets = param1;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return _assets;
      }
   }
}

