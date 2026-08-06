package com.sulake.habbo.sound.music
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.sound.HabboSoundManagerFlash10;
   import com.sulake.habbo.sound.events.TraxSongLoadEvent;
   import com.sulake.habbo.sound.trax.TraxSample;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class TraxSampleManager implements IComponentInterfaceQueue
   {
      private static const SAMPLE_PROCESS_LIMIT_MS:int = 60;
      
      private static const SAMPLE_LENGTH_MEMORY_LIMIT:int = 25165823;
      
      private static const SAMPLE_LENGTH_PURGE_TO:int = 16777215;
      
      private var _soundManager:HabboSoundManagerFlash10;
      
      private var _loadingSamples:Map = new Map();
      
      private var _loadedSamples:Array = [];
      
      private var _traxSamples:Map = new Map();
      
      private var UnknownVarFromTraxSampleManager_ByteArray_1:ByteArray = new ByteArray();
      
      private var _loadErrorCallback:Function;
      
      private var UnknownVarFromTraxSampleManager_Boolean_1:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function TraxSampleManager(param1:HabboSoundManagerFlash10, param2:Function)
      {
         super();
         _loadErrorCallback = param2;
         _soundManager = param1;
         if(_soundManager.getBoolean("trax.player.sample.memory.purge.enabled"))
         {
            UnknownVarFromTraxSampleManager_Boolean_1 = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromTraxSampleManager_ByteArray_1 = null;
            _loadedSamples = null;
            if(_traxSamples != null)
            {
               _traxSamples.dispose();
               _traxSamples = null;
            }
            if(_loadingSamples != null)
            {
               _loadingSamples.dispose();
               _loadingSamples = null;
            }
            _soundManager = null;
            _disposed = true;
         }
      }
      
      public function get traxSamples() : Map
      {
         return _traxSamples;
      }
      
      public function loadSample(param1:int) : void
      {
         var _loc4_:String = _soundManager.getProperty("flash.dynamic.download.url");
         _loc4_ = _loc4_ + _soundManager.getProperty("flash.dynamic.download.samples.template");
         _loc4_ = _loc4_.replace(/%typeid%/,param1.toString());
         var _loc2_:URLRequest = new URLRequest(_loc4_);
         var _loc3_:Sound = new Sound();
         _loc3_.addEventListener("complete",onSampleLoadComplete);
         _loc3_.addEventListener("ioError",ioErrorHandler);
         _loc3_.load(_loc2_);
         _loadingSamples.add(_loc3_,param1);
      }
      
      public function update(param1:uint) : void
      {
         processLoadedSamples();
      }
      
      private function onSampleLoadComplete(param1:Event) : void
      {
         var _loc2_:Sound = param1.target as Sound;
         _loadedSamples.push(_loc2_);
      }
      
      private function ioErrorHandler(param1:Event) : void
      {
         _soundManager.events.dispatchEvent(new TraxSongLoadEvent("TSLE_TRAX_LOAD_FAILED",_soundManager.loadingSongId));
         _loadErrorCallback.call();
      }
      
      private function processLoadedSample(param1:Sound) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc2_:TraxSample = null;
         if(_loadingSamples.getValue(param1) != null)
         {
            _loc3_ = _loadingSamples.remove(param1);
            if(_traxSamples.getValue(_loc3_) == null)
            {
               UnknownVarFromTraxSampleManager_ByteArray_1.clear();
               _loc4_ = param1.length;
               param1.extract(UnknownVarFromTraxSampleManager_ByteArray_1,int(_loc4_ * 44.1));
               _loc2_ = new TraxSample(UnknownVarFromTraxSampleManager_ByteArray_1,_loc3_,"sample_44khz","sample_16bit");
               _traxSamples.add(_loc3_,_loc2_);
            }
         }
      }
      
      private function processLoadedSamples() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = 0;
         var _loc2_:Sound = null;
         if(_loadedSamples.length > 0)
         {
            _loc3_ = getTimer();
            _loc1_ = _loc3_;
            while(_loc1_ - _loc3_ < 60 && _loadedSamples.length > 0)
            {
               _loc2_ = _loadedSamples.splice(0,1)[0];
               processLoadedSample(_loc2_);
               _loc1_ = getTimer();
            }
            if(_loadingSamples.length == 0 && _soundManager.loadingSongId != -1)
            {
               _soundManager.events.dispatchEvent(new TraxSongLoadEvent("TSLE_TRAX_LOAD_COMPLETE",_soundManager.loadingSongId));
               if(UnknownVarFromTraxSampleManager_Boolean_1)
               {
                  processSampleMemoryUsage();
               }
            }
         }
      }
      
      private function logSampleUsage() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
      }
      
      private function processSampleMemoryUsage() : void
      {
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TraxSample = null;
         var _loc3_:Array = null;
         var _loc6_:* = 0;
         var _loc9_:int = 0;
         var _loc12_:TraxSample = null;
         var _loc2_:TraxSample = null;
         var _loc10_:uint = 0;
         var _loc7_:Array = [];
         var _loc1_:Array = _soundManager.musicController.samplesIdsInUse;
         _loc8_ = 0;
         while(_loc8_ < _traxSamples.length)
         {
            _loc4_ = _traxSamples.getKey(_loc8_);
            _loc5_ = _traxSamples.getWithIndex(_loc8_);
            if(_loc5_.usageCount != 0 && _loc1_.indexOf(_loc4_) == -1)
            {
               _loc7_.push(_loc5_);
            }
            _loc10_ += _loc5_.length;
            _loc8_++;
         }
         if(_loc10_ > 25165823)
         {
            _loc3_ = [];
            Logger.log("Sample memory limit reached, clearing the oldest and least frequently used samples");
            _loc7_.sort(orderUsageAndTimeStamp);
            _loc6_ = 0;
            _loc9_ = 0;
            while(_loc6_ < _loc10_ - 16777215 && _loc9_ < _loc7_.length)
            {
               _loc12_ = _loc7_[_loc9_++];
               _loc6_ += _loc12_.length;
               _loc3_.push(_loc12_.id);
            }
            _loc7_ = null;
            if(_loc3_.length > 0)
            {
               for each(var _loc11_ in _loc3_)
               {
                  Logger.log("Purging sample : " + _loc11_);
                  _loc2_ = _traxSamples.getValue(_loc11_) as TraxSample;
                  _loc2_.dispose();
                  _traxSamples.remove(_loc11_);
               }
               _soundManager.musicController.samplesUnloaded(_loc3_);
            }
         }
      }
      
      private function orderUsageAndTimeStamp(param1:TraxSample, param2:TraxSample) : int
      {
         if(param1.usageCount < param2.usageCount)
         {
            return -1;
         }
         if(param1.usageCount > param2.usageCount)
         {
            return 1;
         }
         if(param1.usageTimeStamp < param2.usageTimeStamp)
         {
            return -1;
         }
         if(param1.usageTimeStamp > param2.usageTimeStamp)
         {
            return 1;
         }
         return 0;
      }
   }
}

