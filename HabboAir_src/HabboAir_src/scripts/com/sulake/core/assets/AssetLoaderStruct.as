package com.sulake.core.assets
{
   import com.sulake.core.assets.loaders.ICachedAssetLoader;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   
   public class AssetLoaderStruct extends EventDispatcherWrapper implements IComponentInterfaceQueue
   {
      private var _assetLoader:ICachedAssetLoader;
      
      private var _assetName:String;
      
      public function AssetLoaderStruct(param1:String, param2:ICachedAssetLoader)
      {
         super();
         _assetName = param1;
         _assetLoader = param2;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get assetLoader() : ICachedAssetLoader
      {
         return _assetLoader;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(_assetLoader != null)
            {
               if(!_assetLoader.disposed)
               {
                  _assetLoader.dispose();
                  _assetLoader = null;
               }
            }
            super.dispose();
         }
      }
   }
}

