package com.sulake.habbo.sound
{
   import com.sulake.core.runtime.IProfiler_1;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public class HabboSoundWithPitch extends HabboSoundBase implements IProfiler_1
   {
      private const SILENCE_MS:uint = 50;
      
      private const FADEIN_MS:uint = 175;
      
      private var UnknownVarFromHabboSoundWithPitch_Number_1:Number;
      
      private var UnknownVarFromHabboSoundWithPitch_Sound_1:Sound;
      
      private var _loadedSamples:ByteArray;
      
      private var _numSamples:int;
      
      private var UnknownVarFromHabboSoundWithPitch_Uint_1:uint = 0;
      
      private var UnknownVarFromHabboSoundWithPitch_Uint_2:uint = 0;
      
      private var UnknownVarFromHabboSoundWithPitch_Boolean_1:Boolean = false;
      
      public function HabboSoundWithPitch(param1:Sound, param2:Number = 1)
      {
         super(param1);
         UnknownVarFromHabboSoundWithPitch_Number_1 = param2;
         UnknownVarFromHabboSoundWithPitch_Sound_1 = new Sound();
         extractMonoSamples();
         setPitch(UnknownVarFromHabboSoundWithPitch_Number_1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromHabboSoundWithPitch_Sound_1 = null;
         if(_loadedSamples != null)
         {
            _loadedSamples.clear();
            _loadedSamples = null;
         }
      }
      
      override public function play(param1:Number = 0) : Boolean
      {
         stop();
         UnknownVarFromHabboSoundWithPitch_Uint_2 = UnknownVarFromHabboSoundWithPitch_Uint_1;
         UnknownVarFromHabboSoundWithPitch_Boolean_1 = false;
         setComplete(false);
         setSoundChannel(UnknownVarFromHabboSoundWithPitch_Sound_1.play(0,0,new SoundTransform(0)));
         return true;
      }
      
      override public function stop() : Boolean
      {
         if(getSoundChannel() != null)
         {
            getSoundChannel().stop();
         }
         return true;
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromHabboSoundWithPitch_Uint_1 += param1;
         var _loc2_:uint = uint(UnknownVarFromHabboSoundWithPitch_Uint_1 - UnknownVarFromHabboSoundWithPitch_Uint_2);
         if(UnknownVarFromHabboSoundWithPitch_Uint_2 > 0 && _loc2_ < 50)
         {
            setChannelVolume(0);
         }
         else if(UnknownVarFromHabboSoundWithPitch_Uint_2 > 0 && _loc2_ >= 50 && _loc2_ < 175)
         {
            setChannelVolume(volume * (_loc2_ / 175));
         }
         else if(!UnknownVarFromHabboSoundWithPitch_Boolean_1)
         {
            setChannelVolume(volume);
            UnknownVarFromHabboSoundWithPitch_Boolean_1 = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _loadedSamples == null;
      }
      
      public function setPitch(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         UnknownVarFromHabboSoundWithPitch_Number_1 = param1;
         var _loc6_:ByteArray = new ByteArray();
         var _loc3_:uint = uint(int(_loadedSamples.length / 4 * UnknownVarFromHabboSoundWithPitch_Number_1));
         var _loc2_:Number = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_ && int(_loc2_) * 4 < _loadedSamples.length)
         {
            _loadedSamples.position = int(_loc2_) * 4;
            _loc5_ = _loadedSamples.readFloat();
            _loc6_.writeFloat(_loc5_);
            _loc6_.writeFloat(_loc5_);
            _loc2_ += UnknownVarFromHabboSoundWithPitch_Number_1;
            _loc4_++;
         }
         _loc6_.position = 0;
         UnknownVarFromHabboSoundWithPitch_Sound_1.loadPCMFromByteArray(_loc6_,_loc6_.length / 8,"float");
      }
      
      private function extractMonoSamples() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc1_:ByteArray = new ByteArray();
         _soundObject.extract(_loc1_,int(_soundObject.length * 44.1),0);
         _loadedSamples = new ByteArray();
         _numSamples = _loc1_.length / 8;
         _loc1_.position = 0;
         _loc2_ = 0;
         while(_loc2_ < _numSamples)
         {
            _loc3_ = _loc1_.readFloat();
            _loc1_.readFloat();
            _loadedSamples.writeFloat(_loc3_);
            _loc2_++;
         }
      }
   }
}

