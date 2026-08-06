package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class UseStuff extends DefaultTriggerConf
   {
      public function UseStuff()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.USE_STUFF;
      }
   }
}

