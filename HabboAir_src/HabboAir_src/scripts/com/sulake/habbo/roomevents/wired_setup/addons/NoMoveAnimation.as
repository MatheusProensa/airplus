package com.sulake.habbo.roomevents.wired_setup.addons
{
   public class NoMoveAnimation extends DefaultAddonType
   {
      public function NoMoveAnimation()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.NO_MOVE_ANIMATION;
      }
   }
}

