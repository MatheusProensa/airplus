package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class AvatarClicksFurni extends DefaultTriggerConf
   {
      public function AvatarClicksFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.AVATAR_CLICKS_FURNI;
      }
   }
}

