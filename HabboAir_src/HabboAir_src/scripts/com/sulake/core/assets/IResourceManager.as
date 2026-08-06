package com.sulake.core.assets
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IResourceManager extends IComponentInterfaceQueue
   {
      function createAsset(param1:String, param2:Class, param3:Object) : ISoundAsset;
      
      function retrieveAsset(param1:String, param2:UnknownICoreAssets1) : void;
      
      function isSameAsset(param1:String, param2:String) : Boolean;
      
      function removeAsset(param1:String) : void;
   }
}

