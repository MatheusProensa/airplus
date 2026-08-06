package com.sulake.core.utils
{
   public class Resources
   {
      private static var _resources:Map = new Map();
      
      public function Resources()
      {
         super();
      }
      
      public static function get(param1:String) : Object
      {
         return _resources[param1];
      }
      
      public static function assign(param1:String, param2:Object) : Object
      {
         return _resources[param1] = param2;
      }
      
      public static function remove(param1:String) : Object
      {
         return _resources.remove(param1);
      }
   }
}

