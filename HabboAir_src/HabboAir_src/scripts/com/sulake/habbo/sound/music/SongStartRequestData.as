package com.sulake.habbo.sound.music
{
   import flash.utils.getTimer;
   
   public class SongStartRequestData
   {
      private var _songId:int;
      
      private var UnknownVarFromSongStartRequestData_Number_1:Number;
      
      private var _playLength:Number;
      
      private var _playRequestTime:int;
      
      private var _fadeInSeconds:Number;
      
      private var _fadeOutSeconds:Number;
      
      public function SongStartRequestData(param1:int, param2:Number, param3:Number, param4:Number = 2, param5:Number = 1)
      {
         super();
         _songId = param1;
         UnknownVarFromSongStartRequestData_Number_1 = param2;
         _playLength = param3;
         _fadeInSeconds = param4;
         _fadeOutSeconds = param5;
         _playRequestTime = getTimer();
      }
      
      public function get songId() : int
      {
         return _songId;
      }
      
      public function get startPos() : Number
      {
         if(UnknownVarFromSongStartRequestData_Number_1 < 0)
         {
            return 0;
         }
         return UnknownVarFromSongStartRequestData_Number_1 + (getTimer() - _playRequestTime) / 1000;
      }
      
      public function get playLength() : Number
      {
         return _playLength;
      }
      
      public function get fadeInSeconds() : Number
      {
         return _fadeInSeconds;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return _fadeOutSeconds;
      }
   }
}

