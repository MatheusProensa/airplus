package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class AvatarLeavesRoom extends DefaultTriggerConf
   {
      public function AvatarLeavesRoom()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.AVATAR_LEAVES_ROOM;
      }
   }
}

