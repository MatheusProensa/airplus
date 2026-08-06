package com.sulake.habbo.communication.messages.outgoing.camera.json
{
   [SecureSWF(rename="false")]
   public class JsonTextureColumnData
   {
      private var _assetNames:Array = [];
      
      public function JsonTextureColumnData()
      {
         super();
      }
      
      public function addAssetName(param1:String) : void
      {
         _assetNames.push(param1);
      }
      
      public function get assetNames() : Array
      {
         return _assetNames;
      }
   }
}

