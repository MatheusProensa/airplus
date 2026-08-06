package com.sulake.core.utils
{
   import flash.system.Capabilities;
   
   public class Player
   {
      private static var _majorVersion:int;
      
      private static var _majorRevision:int;
      
      private static var _operatingSystem:String;
      
      init();
      
      public function Player()
      {
         super();
      }
      
      public static function get majorVersion() : int
      {
         return _majorVersion;
      }
      
      public static function get majorRevision() : int
      {
         return _majorRevision;
      }
      
      public static function get operatingSystem() : String
      {
         return _operatingSystem;
      }
      
      private static function init() : void
      {
         var _loc1_:String = Capabilities.version;
         var _loc3_:Array = _loc1_.split(" ");
         var _loc2_:Array = _loc3_[1].split(",");
         _operatingSystem = _loc3_[0];
         _majorVersion = parseInt(_loc2_[0]);
         _majorRevision = parseInt(_loc2_[1]);
      }
   }
}

