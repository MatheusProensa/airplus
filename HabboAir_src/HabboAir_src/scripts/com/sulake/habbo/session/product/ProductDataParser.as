package com.sulake.habbo.session.product
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class ProductDataParser extends EventDispatcherWrapper
   {
      public static const READY:String = "PDP_product_data_ready";
      
      private static const MAX_DOWNLOAD_RETRIES:int = 2;
      
      private var UnknownVarFromProductDataParser_Dictionary_1:Dictionary;
      
      private var UnknownVarFromProductDataParser_AssetLibrary_1:AssetLibrary;
      
      private var UnknownVarFromProductDataParser_String_1:String;
      
      private var _downloadRetriesLeft:int;
      
      public function ProductDataParser(param1:String, param2:Dictionary)
      {
         super();
         UnknownVarFromProductDataParser_Dictionary_1 = param2;
         UnknownVarFromProductDataParser_AssetLibrary_1 = new AssetLibrary("ProductDataParserAssetLib");
         UnknownVarFromProductDataParser_String_1 = param1;
         _downloadRetriesLeft = 2;
         requestData(param1);
      }
      
      private static function appendRetryParam(param1:String, param2:int) : String
      {
         if(param1.indexOf("?") > 0)
         {
            return param1 + "&retry=" + param2;
         }
         return param1 + "?retry=" + param2;
      }
      
      private function requestData(param1:String) : void
      {
         var _loc2_:ISoundAsset = null;
         var _loc4_:ISoundAsset = UnknownVarFromProductDataParser_AssetLibrary_1.getAssetByName("productdata");
         if(_loc4_ != null)
         {
            _loc2_ = UnknownVarFromProductDataParser_AssetLibrary_1.removeAsset(_loc4_);
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
         }
         var _loc3_:AssetLoaderStruct = UnknownVarFromProductDataParser_AssetLibrary_1.loadAssetFromFile("productdata",new URLRequest(param1),"text/plain");
         _loc3_.addEventListener("AssetLoaderEventComplete",parseProductsData);
         _loc3_.addEventListener("AssetLoaderEventError",productsDataError);
      }
      
      private function removeLoaderListeners(param1:AssetLoaderStruct) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("AssetLoaderEventComplete",parseProductsData);
         param1.removeEventListener("AssetLoaderEventError",productsDataError);
      }
      
      private function retryLoadIfPossible() : Boolean
      {
         if(UnknownVarFromProductDataParser_String_1 == null || _downloadRetriesLeft <= 0)
         {
            return false;
         }
         var _loc1_:String = appendRetryParam(UnknownVarFromProductDataParser_String_1,_downloadRetriesLeft);
         _downloadRetriesLeft--;
         requestData(_loc1_);
         return true;
      }
      
      private function onMalformedData(param1:int) : void
      {
         if(retryLoadIfPossible())
         {
            return;
         }
         HabboWebTools.logEventLog("productdata malformed data " + param1);
         Core.error("XML Product data was malformed",true,7);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(UnknownVarFromProductDataParser_AssetLibrary_1)
         {
            UnknownVarFromProductDataParser_AssetLibrary_1.dispose();
            UnknownVarFromProductDataParser_AssetLibrary_1 = null;
         }
         UnknownVarFromProductDataParser_Dictionary_1 = null;
      }
      
      private function parseProductsData(param1:AssetLoaderEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ByteArray = null;
         var _loc4_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         removeLoaderListeners(_loc4_);
         if(_loc4_ == null)
         {
            onMalformedData(param1.status);
            return;
         }
         if(_loc4_.assetLoader == null || _loc4_.assetLoader.content == null)
         {
            onMalformedData(param1.status);
            return;
         }
         if(_loc4_.assetLoader.content is ByteArray)
         {
            _loc3_ = _loc4_.assetLoader.content as ByteArray;
            _loc3_.position = 0;
            _loc2_ = _loc3_.readUTFBytes(_loc3_.length);
         }
         else
         {
            _loc2_ = _loc4_.assetLoader.content as String;
         }
         if(_loc2_ == null || _loc2_.length == 0)
         {
            onMalformedData(param1.status);
            return;
         }
         var _loc5_:String = _loc2_.replace(/^\s+/,"");
         if(_loc5_.charAt(0) == "<")
         {
            if(!parseXmlFormat(_loc5_))
            {
               onMalformedData(param1.status);
            }
         }
         else
         {
            parseLingoFormat(_loc2_);
         }
      }
      
      private function parseXmlFormat(param1:String) : Boolean
      {
         var _loc4_:XML = null;
         var _loc2_:String = null;
         try
         {
            _loc4_ = new XML(param1);
         }
         catch(e:Error)
         {
            return false;
         }
         if(_loc4_ == null)
         {
            return false;
         }
         var _loc5_:XMLList = _loc4_.product;
         for each(var _loc3_ in _loc5_)
         {
            _loc2_ = _loc3_.@code;
            UnknownVarFromProductDataParser_Dictionary_1[_loc2_] = new ProductData(_loc2_,_loc3_.name);
         }
         dispatchEvent(new Event("PDP_product_data_ready"));
         return true;
      }
      
      private function parseLingoFormat(param1:String) : void
      {
         var _loc5_:Array = null;
         var _loc12_:Array = null;
         var _loc10_:String = null;
         var _loc6_:String = null;
         var _loc2_:ProductData = null;
         var _loc3_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/gm;
         var _loc4_:RegExp = /\[+?((.)*?)\]/g;
         param1 = param1.replace(/"{1,}/gm,"");
         var _loc9_:Array = param1.split(_loc3_);
         var _loc11_:int = 0;
         for each(var _loc8_ in _loc9_)
         {
            _loc5_ = _loc8_.match(_loc4_);
            for each(var _loc7_ in _loc5_)
            {
               _loc7_ = _loc7_.replace(/\[{1,}/gm,"");
               _loc7_ = _loc7_.replace(/\]{1,}/gm,"");
               _loc12_ = _loc7_.split(",");
               _loc10_ = _loc12_.shift();
               _loc6_ = _loc12_.shift();
               _loc2_ = new ProductData(_loc10_,_loc6_);
               UnknownVarFromProductDataParser_Dictionary_1[_loc10_] = _loc2_;
            }
            _loc11_++;
         }
         dispatchEvent(new Event("PDP_product_data_ready"));
      }
      
      private function productsDataError(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         removeLoaderListeners(_loc2_);
         if(retryLoadIfPossible())
         {
            return;
         }
         HabboWebTools.logEventLog("productdata download error " + param1.status);
         Core.error("Could not download productdata",true,7);
      }
   }
}

