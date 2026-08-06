package com.sulake.core.assets
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.LibraryLoader;
   import flash.net.URLRequest;
   
   public interface IAssetLibraryCollection extends IComponentInterfaceQueue
   {
      function get url() : String;
      
      function get name() : String;
      
      function get isReady() : Boolean;
      
      function get numAssets() : uint;
      
      function get manifest() : XML;
      
      function get nameArray() : Array;
      
      function loadFromFile(param1:LibraryLoader, param2:Boolean = true) : void;
      
      function loadFromResource(param1:XML, param2:Class) : Boolean;
      
      function unload() : void;
      
      function loadAssetFromFile(param1:String, param2:URLRequest, param3:String = null, param4:int = -1) : AssetLoaderStruct;
      
      function getAssetByName(param1:String) : ISoundAsset;
      
      function getAssetByContent(param1:Object) : ISoundAsset;
      
      function getAssetByIndex(param1:uint) : ISoundAsset;
      
      function getAssetIndex(param1:ISoundAsset) : int;
      
      function hasAsset(param1:String) : Boolean;
      
      function setAsset(param1:String, param2:ISoundAsset, param3:Boolean = true) : Boolean;
      
      function createAsset(param1:String, param2:AssetTypeDeclaration) : ISoundAsset;
      
      function removeAsset(param1:ISoundAsset) : ISoundAsset;
      
      function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean = true) : Boolean;
      
      function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean = true) : AssetTypeDeclaration;
      
      function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean = true) : AssetTypeDeclaration;
      
      function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean = true) : AssetTypeDeclaration;
   }
}

