package com.sulake.habbo.sound
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboSoundManagerFlash10 extends IUnknown
   {
      function set genericVolume(param1:Number) : void;
      
      function set traxVolume(param1:Number) : void;
      
      function set furniVolume(param1:Number) : void;
      
      function get genericVolume() : Number;
      
      function get traxVolume() : Number;
      
      function get furniVolume() : Number;
      
      function get musicController() : UnknownIHabboSound1;
      
      function playSound(param1:String, param2:int = 0) : void;
      
      function stopSound(param1:String) : void;
      
      function playSoundAtPitch(param1:String, param2:Number) : IHabboSoundBase_1;
      
      function loadTraxSong(param1:int, param2:String) : IHabboSoundBase_1;
      
      function mute(param1:Boolean) : void;
      
      function previewVolume(param1:Number, param2:Number, param3:Number) : void;
      
      function get events() : IEventDispatcher;
   }
}

