package com.sulake.core.assets
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface ISoundAsset extends IComponentInterfaceQueue
   {
      function get url() : String;
      
      function get content() : Object;
      
      function get declaration() : AssetTypeDeclaration;
      
      function setUnknownContent(param1:Object) : void;
      
      function setFromOtherAsset(param1:ISoundAsset) : void;
      
      function setParamsDesc(param1:XMLList) : void;
   }
}

