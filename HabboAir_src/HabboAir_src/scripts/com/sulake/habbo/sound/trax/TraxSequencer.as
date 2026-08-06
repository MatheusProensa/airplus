package com.sulake.habbo.sound.trax
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.sound.IHabboSoundBase_1;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import flash.events.IEventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class TraxSequencer implements IHabboSoundBase_1, IComponentInterfaceQueue
   {
      private static const SAMPLES_PER_SECOND:Number = 44100;
      
      private static const BUFFER_LENGTH:uint = 8192;
      
      private static const SAMPLES_BAR_LENGTH:uint = 88000;
      
      private static const BAR_LENGTH:uint = 88000;
      
      private static const SAMPLES_PER_BAR:Number = 88200;
      
      private static const ROUND_UP_THRESHOLD_BIAS:Number = 0.875;
      
      private static const MIXING_BUFFER:Vector.<int> = new Vector.<int>(8192,true);
      
      private static const INTERPOLATION_BUFFER:Vector.<int> = new Vector.<int>(8192,true);
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromTraxSequencer_IEventDispatcher_1:IEventDispatcher;
      
      private var _volume:Number;
      
      private var _sound:Sound;
      
      private var UnknownVarFromTraxSequencer_SoundChannel_1:SoundChannel;
      
      private var _traxData:TraxData;
      
      private var _samples:Map;
      
      private var _ready:Boolean;
      
      private var UnknownVarFromTraxSequencer_Int_1:int;
      
      private var _playLengthSamples:int = 0;
      
      private var UnknownVarFromTraxSequencer_Uint_1:uint;
      
      private var UnknownVarFromTraxSequencer_Array_1:Array;
      
      private var UnknownVarFromTraxSequencer_Boolean_1:Boolean;
      
      private var _finished:Boolean = true;
      
      private var _lengthSamples:uint;
      
      private var UnknownVarFromTraxSequencer_Uint_2:uint = 30;
      
      private var UnknownVarFromTraxSequencer_Boolean_2:Boolean;
      
      private var UnknownVarFromTraxSequencer_Boolean_3:Boolean;
      
      private var _fadeInLengthSamples:int;
      
      private var _fadeOutLengthSamples:int;
      
      private var UnknownVarFromTraxSequencer_Int_2:int;
      
      private var UnknownVarFromTraxSequencer_Int_3:int;
      
      private var UnknownVarFromTraxSequencer_Timer_1:Timer;
      
      private var UnknownVarFromTraxSequencer_Timer_2:Timer;
      
      private var _useCutMode:Boolean;
      
      private var UnknownVarFromTraxSequencer_Int_4:int = 0;
      
      private var UnknownVarFromTraxSequencer_Int_5:int = 0;
      
      public function TraxSequencer(param1:int, param2:TraxData, param3:Map, param4:IEventDispatcher)
      {
         super();
         UnknownVarFromTraxSequencer_IEventDispatcher_1 = param4;
         UnknownVarFromTraxSequencer_Int_1 = param1;
         _volume = 1;
         _sound = new Sound();
         UnknownVarFromTraxSequencer_SoundChannel_1 = null;
         _samples = param3;
         _traxData = param2;
         _ready = true;
         UnknownVarFromTraxSequencer_Uint_1 = 0;
         UnknownVarFromTraxSequencer_Array_1 = [];
         UnknownVarFromTraxSequencer_Boolean_1 = false;
         _lengthSamples = 0;
         _finished = false;
         UnknownVarFromTraxSequencer_Boolean_2 = false;
         UnknownVarFromTraxSequencer_Boolean_3 = false;
         _fadeInLengthSamples = 0;
         _fadeOutLengthSamples = 0;
         UnknownVarFromTraxSequencer_Int_2 = 0;
         UnknownVarFromTraxSequencer_Int_3 = 0;
      }
      
      public function set position(param1:Number) : void
      {
         UnknownVarFromTraxSequencer_Uint_1 = param1 * 44100;
      }
      
      public function get volume() : Number
      {
         return _volume;
      }
      
      public function get position() : Number
      {
         return UnknownVarFromTraxSequencer_Uint_1 / 44100;
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function set ready(param1:Boolean) : void
      {
         _ready = param1;
      }
      
      public function get finished() : Boolean
      {
         return _finished;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return _fadeOutLengthSamples / 44100;
      }
      
      public function set fadeOutSeconds(param1:Number) : void
      {
         _fadeOutLengthSamples = param1 * 44100;
      }
      
      public function get fadeInSeconds() : Number
      {
         return _fadeInLengthSamples / 44100;
      }
      
      public function set fadeInSeconds(param1:Number) : void
      {
         _fadeInLengthSamples = param1 * 44100;
      }
      
      public function get traxData() : TraxData
      {
         return _traxData;
      }
      
      public function set volume(param1:Number) : void
      {
         _volume = param1;
         if(UnknownVarFromTraxSequencer_SoundChannel_1 != null)
         {
            UnknownVarFromTraxSequencer_SoundChannel_1.soundTransform = new SoundTransform(_volume);
         }
      }
      
      public function get length() : Number
      {
         return _lengthSamples / 44100;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            stopImmediately();
            _traxData = null;
            _samples = null;
            UnknownVarFromTraxSequencer_Array_1 = null;
            UnknownVarFromTraxSequencer_IEventDispatcher_1 = null;
            _sound = null;
            _disposed = true;
         }
      }
      
      public function prepare() : Boolean
      {
         if(!_ready)
         {
            Logger.log("Cannot start trax playback until samples ready!");
            return false;
         }
         if(!UnknownVarFromTraxSequencer_Boolean_1)
         {
            if(_traxData != null)
            {
               _useCutMode = false;
               if(_traxData.hasMetaData)
               {
                  _useCutMode = _traxData.metaCutMode;
               }
               if(_useCutMode)
               {
                  if(!prepareSequence())
                  {
                     Logger.log("Cannot start playback, prepare sequence failed!");
                     return false;
                  }
               }
               else if(!prepareLegacySequence())
               {
                  Logger.log("Cannot start playback, prepare legacy sequence failed!");
                  return false;
               }
            }
         }
         return true;
      }
      
      private function prepareLegacySequence() : Boolean
      {
         var _loc8_:int = 0;
         var _loc3_:Map = null;
         var _loc7_:TraxChannel = null;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc12_:TraxSample = null;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         if(UnknownVarFromTraxSequencer_Array_1 == null)
         {
            return false;
         }
         var _loc1_:uint = uint(getTimer());
         _loc8_ = 0;
         while(_loc8_ < _traxData.channels.length)
         {
            _loc3_ = new Map();
            _loc7_ = _traxData.channels[_loc8_] as TraxChannel;
            _loc4_ = 0;
            _loc2_ = 0;
            _loc9_ = 0;
            while(_loc9_ < _loc7_.itemCount)
            {
               _loc5_ = _loc7_.getItem(_loc9_).id;
               _loc12_ = _samples.getValue(_loc5_) as TraxSample;
               _loc12_.setUsageFromSong(UnknownVarFromTraxSequencer_Int_1,_loc1_);
               if(_loc12_ == null)
               {
                  Logger.log("Error in prepareLegacySequence(), sample was null!");
                  return false;
               }
               _loc11_ = getSampleBars(_loc12_.length);
               _loc6_ = _loc7_.getItem(_loc9_).length / _loc11_;
               _loc10_ = 0;
               while(_loc10_ < _loc6_)
               {
                  if(_loc5_ != 0)
                  {
                     _loc3_.add(_loc4_,_loc12_);
                  }
                  _loc2_ += _loc11_;
                  _loc4_ = _loc2_ * 88000;
                  _loc10_++;
               }
               if(_lengthSamples < _loc4_)
               {
                  _lengthSamples = _loc4_;
               }
               _loc9_++;
            }
            UnknownVarFromTraxSequencer_Array_1.push(_loc3_);
            _loc8_++;
         }
         UnknownVarFromTraxSequencer_Boolean_1 = true;
         return true;
      }
      
      private function prepareSequence() : Boolean
      {
         var _loc6_:int = 0;
         var _loc12_:Map = null;
         var _loc5_:TraxChannel = null;
         var _loc2_:* = 0;
         var _loc11_:* = 0;
         var _loc13_:Boolean = false;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:TraxSample = null;
         var _loc3_:int = 0;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:int = 0;
         if(UnknownVarFromTraxSequencer_Array_1 == null)
         {
            return false;
         }
         var _loc10_:uint = uint(getTimer());
         _loc6_ = 0;
         while(_loc6_ < _traxData.channels.length)
         {
            _loc12_ = new Map();
            _loc5_ = _traxData.channels[_loc6_] as TraxChannel;
            _loc2_ = 0;
            _loc11_ = 0;
            _loc13_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.itemCount)
            {
               _loc4_ = _loc5_.getItem(_loc7_).id;
               _loc9_ = _samples.getValue(_loc4_) as TraxSample;
               _loc9_.setUsageFromSong(UnknownVarFromTraxSequencer_Int_1,_loc10_);
               if(_loc9_ == null)
               {
                  Logger.log("Error in prepareSequence(), sample was null!");
                  return false;
               }
               _loc3_ = int(_loc11_);
               _loc14_ = int(_loc2_);
               _loc8_ = getSampleBars(_loc9_.length);
               _loc1_ = _loc5_.getItem(_loc7_).length;
               while(_loc3_ < _loc11_ + _loc1_)
               {
                  if(_loc4_ != 0 || _loc13_)
                  {
                     _loc12_.add(_loc14_,_loc9_);
                     _loc13_ = false;
                  }
                  _loc3_ += _loc8_;
                  _loc14_ = _loc3_ * 88000;
                  if(_loc3_ > _loc11_ + _loc1_)
                  {
                     _loc13_ = true;
                  }
               }
               _loc11_ += _loc5_.getItem(_loc7_).length;
               _loc2_ = _loc11_ * 88000;
               if(_lengthSamples < _loc2_)
               {
                  _lengthSamples = _loc2_;
               }
               _loc7_++;
            }
            UnknownVarFromTraxSequencer_Array_1.push(_loc12_);
            _loc6_++;
         }
         UnknownVarFromTraxSequencer_Boolean_1 = true;
         return true;
      }
      
      public function play(param1:Number = 0) : Boolean
      {
         if(!prepare())
         {
            return false;
         }
         removeFadeoutStopTimer();
         if(UnknownVarFromTraxSequencer_SoundChannel_1 != null)
         {
            stopImmediately();
         }
         if(_fadeInLengthSamples > 0)
         {
            UnknownVarFromTraxSequencer_Boolean_2 = true;
            UnknownVarFromTraxSequencer_Int_2 = 0;
         }
         UnknownVarFromTraxSequencer_Boolean_3 = false;
         UnknownVarFromTraxSequencer_Int_3 = 0;
         _finished = false;
         _sound.addEventListener("sampleData",onSampleData);
         _playLengthSamples = param1 * 44100;
         UnknownVarFromTraxSequencer_Int_4 = 0;
         UnknownVarFromTraxSequencer_Int_5 = 0;
         UnknownVarFromTraxSequencer_SoundChannel_1 = _sound.play();
         volume = _volume;
         return true;
      }
      
      public function render(param1:SampleDataEvent) : Boolean
      {
         if(!prepare())
         {
            return false;
         }
         while(!_finished)
         {
            onSampleData(param1);
         }
         return true;
      }
      
      public function stop() : Boolean
      {
         if(_fadeOutLengthSamples > 0 && !_finished)
         {
            stopWithFadeout();
         }
         else
         {
            playingComplete();
         }
         return true;
      }
      
      private function stopImmediately() : void
      {
         removeStopTimer();
         if(UnknownVarFromTraxSequencer_SoundChannel_1 != null)
         {
            UnknownVarFromTraxSequencer_SoundChannel_1.stop();
            UnknownVarFromTraxSequencer_SoundChannel_1 = null;
         }
         if(_sound != null)
         {
            _sound.removeEventListener("sampleData",onSampleData);
         }
      }
      
      private function stopWithFadeout() : void
      {
         if(UnknownVarFromTraxSequencer_Timer_1 == null)
         {
            UnknownVarFromTraxSequencer_Boolean_3 = true;
            UnknownVarFromTraxSequencer_Int_3 = 0;
            UnknownVarFromTraxSequencer_Timer_1 = new Timer(UnknownVarFromTraxSequencer_Uint_2 + _fadeOutLengthSamples / (44100 / 1000),1);
            UnknownVarFromTraxSequencer_Timer_1.start();
            UnknownVarFromTraxSequencer_Timer_1.addEventListener("timerComplete",onFadeOutComplete);
         }
      }
      
      private function getSampleBars(param1:uint) : int
      {
         var _loc2_:Number = param1 / 88200;
         if(_useCutMode)
         {
            return Math.round(_loc2_);
         }
         return Math.floor(_loc2_ + 0.875);
      }
      
      private function getChannelSequenceOffsets() : Array
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Map = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(UnknownVarFromTraxSequencer_Array_1 != null)
         {
            _loc1_ = int(UnknownVarFromTraxSequencer_Array_1.length);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc5_ = UnknownVarFromTraxSequencer_Array_1[_loc3_];
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length && _loc5_.getKey(_loc4_) < UnknownVarFromTraxSequencer_Uint_1)
               {
                  _loc4_++;
               }
               _loc2_.push(_loc4_ - 1);
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function mixChannelsIntoBuffer() : void
      {
         var _loc6_:int = 0;
         var _loc7_:Map = null;
         var _loc14_:int = 0;
         var _loc8_:TraxSample = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc13_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:* = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         if(UnknownVarFromTraxSequencer_Array_1 == null)
         {
            return;
         }
         var _loc4_:Array = getChannelSequenceOffsets();
         var _loc1_:int = int(UnknownVarFromTraxSequencer_Array_1.length);
         var _loc12_:TraxChannelSample = null;
         _loc6_ = _loc1_ - 1;
         while(_loc6_ >= 0)
         {
            _loc7_ = UnknownVarFromTraxSequencer_Array_1[_loc6_];
            _loc14_ = int(_loc4_[_loc6_]);
            _loc8_ = _loc7_.getWithIndex(_loc14_);
            if(_loc8_ == null)
            {
               _loc12_ = null;
            }
            else
            {
               _loc2_ = _loc7_.getKey(_loc14_);
               _loc5_ = UnknownVarFromTraxSequencer_Uint_1 - _loc2_;
               if(_loc8_.id == 0 || _loc5_ < 0)
               {
                  _loc12_ = null;
               }
               else
               {
                  _loc12_ = new TraxChannelSample(_loc8_,_loc5_);
               }
            }
            _loc13_ = 8192;
            if(_lengthSamples - UnknownVarFromTraxSequencer_Uint_1 < _loc13_)
            {
               _loc13_ = _lengthSamples - UnknownVarFromTraxSequencer_Uint_1;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc13_)
            {
               _loc3_ = _loc13_;
               if(_loc14_ < _loc7_.length - 1)
               {
                  _loc10_ = _loc7_.getKey(_loc14_ + 1);
                  if(_loc13_ + UnknownVarFromTraxSequencer_Uint_1 >= _loc10_)
                  {
                     _loc3_ = _loc10_ - UnknownVarFromTraxSequencer_Uint_1;
                  }
               }
               if(_loc3_ > _loc13_ - _loc11_)
               {
                  _loc3_ = _loc13_ - _loc11_;
               }
               if(_loc6_ == _loc1_ - 1)
               {
                  if(_loc12_ != null)
                  {
                     _loc12_.setSample(MIXING_BUFFER,_loc11_,_loc3_);
                     _loc11_ += _loc3_;
                  }
                  else
                  {
                     _loc9_ = 0;
                     while(_loc9_ < _loc3_)
                     {
                        MIXING_BUFFER[_loc11_++] = 0;
                        _loc9_++;
                     }
                  }
               }
               else
               {
                  if(_loc12_ != null)
                  {
                     _loc12_.addSample(MIXING_BUFFER,_loc11_,_loc3_);
                  }
                  _loc11_ += _loc3_;
               }
               if(_loc11_ < _loc13_)
               {
                  _loc14_++;
                  _loc8_ = _loc7_.getWithIndex(_loc14_);
                  if(_loc8_ == null || _loc8_.id == 0)
                  {
                     _loc12_ = null;
                  }
                  else
                  {
                     _loc12_ = new TraxChannelSample(_loc8_,0);
                  }
               }
            }
            _loc6_--;
         }
      }
      
      private function checkSongFinishing() : void
      {
         var _loc1_:int = int(_lengthSamples < _playLengthSamples ? _lengthSamples : (_playLengthSamples > 0 ? _playLengthSamples : _lengthSamples));
         if(UnknownVarFromTraxSequencer_Uint_1 > _loc1_ + UnknownVarFromTraxSequencer_Uint_2 * (44100 / 1000) && !_finished)
         {
            _finished = true;
            if(UnknownVarFromTraxSequencer_Timer_2 != null)
            {
               UnknownVarFromTraxSequencer_Timer_2.reset();
               UnknownVarFromTraxSequencer_Timer_2.removeEventListener("timerComplete",onPlayingComplete);
            }
            UnknownVarFromTraxSequencer_Timer_2 = new Timer(2,1);
            UnknownVarFromTraxSequencer_Timer_2.start();
            UnknownVarFromTraxSequencer_Timer_2.addEventListener("timerComplete",onPlayingComplete);
         }
         else if(UnknownVarFromTraxSequencer_Uint_1 > _loc1_ - _fadeOutLengthSamples && !UnknownVarFromTraxSequencer_Boolean_3)
         {
            UnknownVarFromTraxSequencer_Boolean_2 = false;
            UnknownVarFromTraxSequencer_Boolean_3 = true;
            UnknownVarFromTraxSequencer_Int_3 = 0;
         }
      }
      
      private function onSampleData(param1:SampleDataEvent) : void
      {
         if(param1.position > UnknownVarFromTraxSequencer_Int_4)
         {
            UnknownVarFromTraxSequencer_Int_5++;
            Logger.log("Audio buffer under run...");
            UnknownVarFromTraxSequencer_Int_4 = param1.position;
         }
         if(volume > 0)
         {
            mixChannelsIntoBuffer();
         }
         var _loc2_:int = 8192;
         if(_lengthSamples - UnknownVarFromTraxSequencer_Uint_1 < _loc2_)
         {
            _loc2_ = _lengthSamples - UnknownVarFromTraxSequencer_Uint_1;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
         }
         if(volume <= 0)
         {
            _loc2_ = 0;
         }
         writeAudioToOutputStream(param1.data,_loc2_);
         UnknownVarFromTraxSequencer_Uint_1 += 8192;
         UnknownVarFromTraxSequencer_Int_4 += 8192;
         if(UnknownVarFromTraxSequencer_SoundChannel_1 != null)
         {
            UnknownVarFromTraxSequencer_Uint_2 = param1.position / 44100 * 1000 - UnknownVarFromTraxSequencer_SoundChannel_1.position;
         }
         checkSongFinishing();
      }
      
      private function writeAudioToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:* = 0;
         if(param2 > 0)
         {
            if(!UnknownVarFromTraxSequencer_Boolean_2 && !UnknownVarFromTraxSequencer_Boolean_3)
            {
               writeMixingBufferToOutputStream(param1,param2);
            }
            else
            {
               if(UnknownVarFromTraxSequencer_Boolean_2)
               {
                  _loc3_ = 1 / _fadeInLengthSamples;
                  _loc4_ = UnknownVarFromTraxSequencer_Int_2 / _fadeInLengthSamples;
                  UnknownVarFromTraxSequencer_Int_2 += 8192;
                  if(UnknownVarFromTraxSequencer_Int_2 > _fadeInLengthSamples)
                  {
                     UnknownVarFromTraxSequencer_Boolean_2 = false;
                  }
               }
               else if(UnknownVarFromTraxSequencer_Boolean_3)
               {
                  _loc3_ = -1 / _fadeOutLengthSamples;
                  _loc4_ = 1 - UnknownVarFromTraxSequencer_Int_3 / _fadeOutLengthSamples;
                  UnknownVarFromTraxSequencer_Int_3 += 8192;
                  if(UnknownVarFromTraxSequencer_Int_3 > _fadeOutLengthSamples)
                  {
                     UnknownVarFromTraxSequencer_Int_3 = _fadeOutLengthSamples;
                  }
               }
               writeMixingBufferToOutputStreamWithFade(param1,param2,_loc4_,_loc3_);
            }
         }
         var _loc5_:Number = 0;
         _loc6_ = param2;
         while(_loc6_ < 8192)
         {
            param1.writeFloat(_loc5_);
            param1.writeFloat(_loc5_);
            _loc6_++;
         }
      }
      
      private function writeMixingBufferToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = MIXING_BUFFER[_loc3_] * 0.000030517578125;
            param1.writeFloat(_loc4_);
            param1.writeFloat(_loc4_);
            _loc3_++;
         }
      }
      
      private function writeMixingBufferToOutputStreamWithFade(param1:ByteArray, param2:int, param3:Number, param4:Number) : void
      {
         var _loc6_:Number = 0;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            if(param3 < 0 || param3 > 1)
            {
               break;
            }
            _loc6_ = MIXING_BUFFER[_loc5_] * 0.000030517578125 * param3;
            param3 += param4;
            param1.writeFloat(_loc6_);
            param1.writeFloat(_loc6_);
            _loc5_++;
         }
         if(param3 < 0)
         {
            while(_loc5_ < param2)
            {
               param1.writeFloat(0);
               param1.writeFloat(0);
               _loc5_++;
            }
         }
         else if(param3 > 1)
         {
            while(_loc5_ < param2)
            {
               _loc6_ = MIXING_BUFFER[_loc5_] * 0.000030517578125;
               param3 += param4;
               param1.writeFloat(_loc6_);
               param1.writeFloat(_loc6_);
               _loc5_++;
            }
         }
      }
      
      private function onPlayingComplete(param1:TimerEvent) : void
      {
         if(_finished)
         {
            playingComplete();
         }
      }
      
      private function onFadeOutComplete(param1:TimerEvent) : void
      {
         removeFadeoutStopTimer();
         playingComplete();
      }
      
      private function playingComplete() : void
      {
         stopImmediately();
         UnknownVarFromTraxSequencer_IEventDispatcher_1.dispatchEvent(new SoundCompleteEvent("SCE_TRAX_SONG_COMPLETE",UnknownVarFromTraxSequencer_Int_1));
      }
      
      private function removeFadeoutStopTimer() : void
      {
         if(UnknownVarFromTraxSequencer_Timer_1 != null)
         {
            UnknownVarFromTraxSequencer_Timer_1.removeEventListener("timerComplete",onFadeOutComplete);
            UnknownVarFromTraxSequencer_Timer_1.reset();
            UnknownVarFromTraxSequencer_Timer_1 = null;
         }
      }
      
      private function removeStopTimer() : void
      {
         if(UnknownVarFromTraxSequencer_Timer_2 != null)
         {
            UnknownVarFromTraxSequencer_Timer_2.reset();
            UnknownVarFromTraxSequencer_Timer_2.removeEventListener("timerComplete",onPlayingComplete);
            UnknownVarFromTraxSequencer_Timer_2 = null;
         }
      }
   }
}

