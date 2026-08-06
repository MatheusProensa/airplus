package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class GameStarts extends DefaultTriggerConf
   {
      public function GameStarts()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.GAME_STARTS;
      }
   }
}

