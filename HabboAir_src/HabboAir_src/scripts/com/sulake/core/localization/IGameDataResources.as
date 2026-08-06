package com.sulake.core.localization
{
   public interface IGameDataResources
   {
      function isValid() : Boolean;
      
      function getExternalTextsUrl() : String;
      
      function getExternalTextsHash() : String;
      
      function getExternalVariablesUrl() : String;
      
      function getExternalVariablesHash() : String;
      
      function getFurniDataUrl() : String;
      
      function getFurniDataHash() : String;
      
      function getProductDataUrl() : String;
      
      function getProductDataHash() : String;
      
      function getResourceUrl(param1:String) : String;
      
      function getResourceHash(param1:String) : String;
   }
}

