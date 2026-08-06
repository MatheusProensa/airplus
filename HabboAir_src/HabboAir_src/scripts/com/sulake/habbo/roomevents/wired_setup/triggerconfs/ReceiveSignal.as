package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   public class ReceiveSignal extends DefaultTriggerConf
   {
      public function ReceiveSignal()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.RECEIVE_SIGNAL;
      }
   }
}

