package com.sulake.core.window.motion
{
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class Wait extends Motion
   {
      private var UnknownVarFromWait_Int_1:int;
      
      private var UnknownVarFromWait_Int_2:int;
      
      public function Wait(param1:int)
      {
         super(null);
         UnknownVarFromWait_Int_2 = param1;
      }
      
      override public function get running() : Boolean
      {
         return _running;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         _complete = false;
         UnknownVarFromWait_Int_1 = getTimer();
      }
      
      override friend function tick(param1:int) : void
      {
         _complete = param1 - UnknownVarFromWait_Int_1 >= UnknownVarFromWait_Int_2;
         if(_complete)
         {
            friend::stop();
         }
         super.friend::tick(param1);
      }
   }
}

