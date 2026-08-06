package com.hurlant.util
{
   import flash.system.System;
   
   public class UnknownHurlantUtil2
   {
      public function UnknownHurlantUtil2()
      {
         super();
      }
      
      public static function gc() : void
      {
         System.pauseForGCIfCollectionImminent();
      }
      
      public static function get used() : uint
      {
         return System.totalMemory;
      }
   }
}

