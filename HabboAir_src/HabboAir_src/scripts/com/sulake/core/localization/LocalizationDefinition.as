package com.sulake.core.localization
{
   public class LocalizationDefinition implements ILocalizationDefinition
   {
      private var _languageCode:String;
      
      private var _countryCode:String;
      
      private var _encoding:String;
      
      private var _name:String;
      
      private var _url:String;
      
      public function LocalizationDefinition(param1:String, param2:String, param3:String)
      {
         super();
         var _loc4_:Array = param1.split("_");
         _languageCode = _loc4_[0];
         var _loc5_:Array = String(_loc4_[1]).split(".");
         _countryCode = _loc5_[0];
         _encoding = _loc5_[1];
         _name = param2;
         _url = param3;
      }
      
      public function get id() : String
      {
         return _languageCode + "_" + _countryCode + "." + _encoding;
      }
      
      public function get languageCode() : String
      {
         return _languageCode;
      }
      
      public function get countryCode() : String
      {
         return _countryCode;
      }
      
      public function get encoding() : String
      {
         return _encoding;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get url() : String
      {
         return _url;
      }
   }
}

