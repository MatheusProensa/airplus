package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
   [SecureSWF(rename="true")]
   public class AvatarEffect
   {
      private var _type:int;
      
      private var _subType:int;
      
      private var _duration:int;
      
      private var _inactiveEffectsInInventory:int;
      
      private var _secondsLeftIfActive:int;
      
      private var _isPermanent:Boolean;
      
      public function AvatarEffect()
      {
         super();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get subType() : int
      {
         return _subType;
      }
      
      public function set subType(param1:int) : void
      {
         _subType = param1;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function set duration(param1:int) : void
      {
         _duration = param1;
      }
      
      public function get inactiveEffectsInInventory() : int
      {
         return _inactiveEffectsInInventory;
      }
      
      public function set inactiveEffectsInInventory(param1:int) : void
      {
         _inactiveEffectsInInventory = param1;
      }
      
      public function get secondsLeftIfActive() : int
      {
         return _secondsLeftIfActive;
      }
      
      public function set secondsLeftIfActive(param1:int) : void
      {
         _secondsLeftIfActive = param1;
      }
      
      public function get isPermanent() : Boolean
      {
         return _isPermanent;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         _isPermanent = param1;
      }
   }
}

