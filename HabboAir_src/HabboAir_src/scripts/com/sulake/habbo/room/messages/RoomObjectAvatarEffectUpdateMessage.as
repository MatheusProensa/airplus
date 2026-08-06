package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _effect:int;
      
      private var _delayMilliSeconds:int;
      
      public function RoomObjectAvatarEffectUpdateMessage(param1:int = 0, param2:int = 0)
      {
         super();
         _effect = param1;
         _delayMilliSeconds = param2;
      }
      
      public function get effect() : int
      {
         return _effect;
      }
      
      public function get delayMilliSeconds() : int
      {
         return _delayMilliSeconds;
      }
   }
}

