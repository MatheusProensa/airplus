package com.sulake.core.utils
{
   import flash.system.Capabilities;
   
   public class PlayerVersionCheck
   {
      private static var UnknownVarFromPlayerVersionCheck_Int_1:int;
      
      private static var UnknownVarFromPlayerVersionCheck_Int_2:int;
      
      private static var UnknownVarFromPlayerVersionCheck_Boolean_1:Boolean;
      
      public function PlayerVersionCheck()
      {
         super();
      }
      
      public static function isVersionAtLeast(param1:int, param2:int) : Boolean
      {
         if(param1 < PlayerVersionCheck.majorVersion)
         {
            return true;
         }
         if(param1 == PlayerVersionCheck.majorVersion && param2 <= PlayerVersionCheck.minorVersion)
         {
            return true;
         }
         return false;
      }
      
      public static function get majorVersion() : int
      {
         parseVersion();
         return UnknownVarFromPlayerVersionCheck_Int_1;
      }
      
      public static function get minorVersion() : int
      {
         parseVersion();
         return UnknownVarFromPlayerVersionCheck_Int_2;
      }
      
      private static function parseVersion() : void
      {
         if(UnknownVarFromPlayerVersionCheck_Boolean_1)
         {
            return;
         }
         var _loc2_:Array = Capabilities.version.split(" ");
         var _loc3_:Array = _loc2_[1].split(",");
         var _loc1_:int = int(_loc3_.length);
         UnknownVarFromPlayerVersionCheck_Int_1 = _loc1_ >= 1 ? parseInt(_loc3_[0]) : 0;
         UnknownVarFromPlayerVersionCheck_Int_2 = _loc1_ >= 2 ? parseInt(_loc3_[1]) : 0;
         UnknownVarFromPlayerVersionCheck_Boolean_1 = true;
      }
   }
}

