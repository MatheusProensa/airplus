package com.sulake.habbo.sound
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class HabboSoundBase implements IHabboSoundBase_1
   {
      private var _soundChannel:SoundChannel = null;
      
      private var UnknownVarFromHabboSoundBase_Boolean_1:Boolean;
      
      private var _volume:Number;
      
      private var UnknownVarFromHabboSoundBase_Int_1:int;
      
      protected var _soundObject:Sound = null;
      
      public function HabboSoundBase(param1:Sound, param2:int = 0)
      {
         super();
         _soundObject = param1;
         _soundObject.addEventListener("complete",onComplete);
         _volume = 1;
         UnknownVarFromHabboSoundBase_Boolean_1 = false;
         UnknownVarFromHabboSoundBase_Int_1 = param2;
      }
      
      protected function getSoundObject() : Sound
      {
         return _soundObject;
      }
      
      protected function getSoundChannel() : SoundChannel
      {
         return _soundChannel;
      }
      
      protected function setSoundChannel(param1:SoundChannel) : void
      {
         _soundChannel = param1;
      }
      
      protected function setComplete(param1:Boolean) : void
      {
         UnknownVarFromHabboSoundBase_Boolean_1 = param1;
      }
      
      public function dispose() : void
      {
         stop();
         _soundChannel = null;
         _soundObject = null;
      }
      
      public function play(param1:Number = 0) : Boolean
      {
         UnknownVarFromHabboSoundBase_Boolean_1 = false;
         _soundChannel = _soundObject.play(0,UnknownVarFromHabboSoundBase_Int_1);
         setChannelVolume(_volume);
         return true;
      }
      
      public function stop() : Boolean
      {
         if(_soundChannel)
         {
            _soundChannel.stop();
         }
         return true;
      }
      
      public function get volume() : Number
      {
         return _volume;
      }
      
      public function set volume(param1:Number) : void
      {
         _volume = param1;
         setChannelVolume(param1);
      }
      
      protected function setChannelVolume(param1:Number) : void
      {
         if(_soundChannel != null)
         {
            _soundChannel.soundTransform = new SoundTransform(param1);
         }
      }
      
      public function get position() : Number
      {
         return _soundChannel.position;
      }
      
      public function set position(param1:Number) : void
      {
      }
      
      public function get length() : Number
      {
         return _soundObject.length;
      }
      
      public function get ready() : Boolean
      {
         return !_soundObject.isBuffering;
      }
      
      public function get finished() : Boolean
      {
         return !UnknownVarFromHabboSoundBase_Boolean_1;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return 0;
      }
      
      public function set fadeOutSeconds(param1:Number) : void
      {
      }
      
      public function get fadeInSeconds() : Number
      {
         return 0;
      }
      
      public function set fadeInSeconds(param1:Number) : void
      {
      }
      
      private function onComplete(param1:Event) : void
      {
         UnknownVarFromHabboSoundBase_Boolean_1 = true;
      }
   }
}

