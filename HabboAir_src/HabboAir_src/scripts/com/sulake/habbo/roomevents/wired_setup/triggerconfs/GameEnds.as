package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class GameEnds extends DefaultTriggerConf
   {
      public function GameEnds()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.GAME_ENDS;
      }
   }
}

