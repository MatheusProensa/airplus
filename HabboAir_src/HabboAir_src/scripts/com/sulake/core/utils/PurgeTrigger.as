package com.sulake.core.utils
{
   import com.sulake.core.Core;
   import flash.system.System;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class PurgeTrigger
   {
      private static var _softPurgeTriggerMegaBytes:uint = 300;
      
      private static var _hardPurgeTriggerMegaBytes:uint = 400;
      
      private static var _frequencyMilliSeconds:uint = 60000;
      
      private static var _isRunning:Boolean = false;
      
      public function PurgeTrigger()
      {
         super();
      }
      
      public static function get softPurgeTriggerMegaBytes() : uint
      {
         return _softPurgeTriggerMegaBytes;
      }
      
      public static function set softPurgeTriggerMegaBytes(param1:uint) : void
      {
         _softPurgeTriggerMegaBytes = param1;
      }
      
      public static function get hardPurgeTriggerMegaBytes() : uint
      {
         return _hardPurgeTriggerMegaBytes;
      }
      
      public static function set hardPurgeTriggerMegaBytes(param1:uint) : void
      {
         _hardPurgeTriggerMegaBytes = Math.max(param1,_softPurgeTriggerMegaBytes);
      }
      
      public static function get frequencyMilliSeconds() : uint
      {
         return _frequencyMilliSeconds;
      }
      
      public static function set frequencyMilliSeconds(param1:uint) : void
      {
         _frequencyMilliSeconds = param1;
      }
      
      public static function get isRunning() : Boolean
      {
         return _isRunning;
      }
      
      protected static function get isMemoryDataAvailable() : Boolean
      {
         return Player.majorVersion > 10 || Player.majorVersion == 10 && Player.majorRevision >= 1;
      }
      
      public static function start() : void
      {
         if(!_isRunning)
         {
            if(!isMemoryDataAvailable)
            {
               _frequencyMilliSeconds *= 2;
               _softPurgeTriggerMegaBytes = 0;
               _hardPurgeTriggerMegaBytes = 2147483647;
            }
            setTimeout(onInterval,_frequencyMilliSeconds);
            _isRunning = true;
         }
      }
      
      public static function stop() : void
      {
         if(_isRunning)
         {
            _isRunning = false;
         }
      }
      
      public static function trigger() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc1_:Object = System;
         var _loc4_:Number = isMemoryDataAvailable ? (_loc1_.totalMemory - _loc1_.freeMemory) / 1024 / 1024 : softPurgeTriggerMegaBytes + 1;
         if(_loc4_ > softPurgeTriggerMegaBytes)
         {
            _loc2_ = getTimer();
            Core.purge();
            _loc3_ = isMemoryDataAvailable ? (_loc1_.totalMemory - _loc1_.freeMemory) / 1024 / 1024 : 0;
            if(_loc3_ > _hardPurgeTriggerMegaBytes)
            {
               triggerGC();
            }
         }
      }
      
      public static function triggerGC() : void
      {
         System.pauseForGCIfCollectionImminent(0.25);
      }
      
      private static function onInterval() : void
      {
         if(_isRunning)
         {
            trigger();
            setTimeout(onInterval,_frequencyMilliSeconds);
         }
      }
   }
}

