package com.sulake.core.localization
{
   import flash.utils.Dictionary;
   
   public class GameDataResources implements IGameDataResources
   {
      private var _resourceUrls:Dictionary;
      
      private var _resourceHashes:Dictionary;
      
      private var _externalTextsUrl:String;
      
      private var _externalTextsHash:String;
      
      private var _externalVariablesUrl:String;
      
      private var _externalVariablesHash:String;
      
      private var _furniDataUrl:String;
      
      private var _furniDataHash:String;
      
      private var _productDataUrl:String;
      
      private var _productDataHash:String;
      
      public function GameDataResources()
      {
         super();
         _resourceUrls = new Dictionary();
         _resourceHashes = new Dictionary();
      }
      
      public static function parse(param1:String) : GameDataResources
      {
         var _loc2_:Object = JSON.parse(param1);
         var _loc4_:GameDataResources = new GameDataResources();
         for each(var _loc3_ in _loc2_.hashes)
         {
            _loc4_.setResource(_loc3_.name,_loc3_.url,_loc3_.hash);
            if(_loc3_.name == "external_texts")
            {
               _loc4_._externalTextsUrl = _loc3_.url;
               _loc4_._externalTextsHash = _loc3_.hash;
            }
            else if(_loc3_.name == "external_variables")
            {
               _loc4_._externalVariablesUrl = _loc3_.url;
               _loc4_._externalVariablesHash = _loc3_.hash;
            }
            else if(_loc3_.name == "furnidata")
            {
               _loc4_._furniDataUrl = _loc3_.url;
               _loc4_._furniDataHash = _loc3_.hash;
            }
            else if(_loc3_.name == "productdata")
            {
               _loc4_._productDataUrl = _loc3_.url;
               _loc4_._productDataHash = _loc3_.hash;
            }
         }
         return _loc4_;
      }
      
      private function setResource(param1:String, param2:String, param3:String) : void
      {
         if(!param1 || param1 == "")
         {
            return;
         }
         _resourceUrls[param1] = param2;
         _resourceHashes[param1] = param3;
      }
      
      public function isValid() : Boolean
      {
         return _externalTextsUrl && _externalTextsHash && _externalVariablesUrl && _externalVariablesHash && _furniDataUrl && _furniDataHash && _productDataUrl && _productDataHash;
      }
      
      public function getExternalTextsUrl() : String
      {
         return _externalTextsUrl;
      }
      
      public function getExternalTextsHash() : String
      {
         return _externalTextsHash;
      }
      
      public function getExternalVariablesUrl() : String
      {
         return _externalVariablesUrl;
      }
      
      public function getExternalVariablesHash() : String
      {
         return _externalVariablesHash;
      }
      
      public function getFurniDataUrl() : String
      {
         return _furniDataUrl;
      }
      
      public function getFurniDataHash() : String
      {
         return _furniDataHash;
      }
      
      public function getProductDataUrl() : String
      {
         return _productDataUrl;
      }
      
      public function getProductDataHash() : String
      {
         return _productDataHash;
      }
      
      public function getResourceUrl(param1:String) : String
      {
         return _resourceUrls[param1];
      }
      
      public function getResourceHash(param1:String) : String
      {
         return _resourceHashes[param1];
      }
   }
}

