package com.sulake.room.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomShakingEffect
   {
      public static const STATE_NOT_INITIALIZED:int = 0;
      
      public static const STATE_START_DELAY:int = 1;
      
      public static const STATE_RUNNING:int = 2;
      
      public static const STATE_OVER:int = 3;
      
      private static var UnknownVarFromRoomShakingEffect_Int_1:int = 0;
      
      private static var UnknownVarFromRoomShakingEffect_Boolean_1:Boolean = false;
      
      private static var UnknownVarFromRoomShakingEffect_Number_1:Number;
      
      private static var UnknownVarFromRoomShakingEffect_Int_2:int = 0;
      
      private static var UnknownVarFromRoomShakingEffect_Int_3:int = 20000;
      
      private static var UnknownVarFromRoomShakingEffect_Int_4:int = 5000;
      
      private static var UnknownVarFromRoomShakingEffect_Timer_1:Timer;
      
      public function RoomShakingEffect()
      {
         super();
      }
      
      public static function init(param1:int, param2:int) : void
      {
         UnknownVarFromRoomShakingEffect_Number_1 = 0;
         UnknownVarFromRoomShakingEffect_Int_3 = param1;
         UnknownVarFromRoomShakingEffect_Int_4 = param2;
         UnknownVarFromRoomShakingEffect_Int_2 = getTimer();
         UnknownVarFromRoomShakingEffect_Int_1 = 1;
      }
      
      public static function turnVisualizationOn() : void
      {
         if(UnknownVarFromRoomShakingEffect_Int_1 == 0 || UnknownVarFromRoomShakingEffect_Int_1 == 3)
         {
            return;
         }
         if(UnknownVarFromRoomShakingEffect_Timer_1 == null || !UnknownVarFromRoomShakingEffect_Timer_1.running)
         {
            UnknownVarFromRoomShakingEffect_Timer_1 = new Timer(UnknownVarFromRoomShakingEffect_Int_4,1);
            UnknownVarFromRoomShakingEffect_Timer_1.addEventListener("timerComplete",turnVisualizationOff);
            UnknownVarFromRoomShakingEffect_Timer_1.start();
         }
         var _loc1_:int = getTimer() - UnknownVarFromRoomShakingEffect_Int_2;
         if(_loc1_ > UnknownVarFromRoomShakingEffect_Int_3 + UnknownVarFromRoomShakingEffect_Int_4)
         {
            UnknownVarFromRoomShakingEffect_Int_1 = 3;
            return;
         }
         UnknownVarFromRoomShakingEffect_Boolean_1 = true;
         if(_loc1_ < UnknownVarFromRoomShakingEffect_Int_3)
         {
            UnknownVarFromRoomShakingEffect_Int_1 = 1;
            return;
         }
         UnknownVarFromRoomShakingEffect_Int_1 = 2;
         UnknownVarFromRoomShakingEffect_Number_1 = (_loc1_ - UnknownVarFromRoomShakingEffect_Int_3) / UnknownVarFromRoomShakingEffect_Int_4;
      }
      
      public static function turnVisualizationOff(param1:TimerEvent) : void
      {
         UnknownVarFromRoomShakingEffect_Boolean_1 = false;
         UnknownVarFromRoomShakingEffect_Timer_1.stop();
         UnknownVarFromRoomShakingEffect_Timer_1.removeEventListener("timerComplete",turnVisualizationOff);
         UnknownVarFromRoomShakingEffect_Timer_1 = null;
      }
      
      public static function isVisualizationOn() : Boolean
      {
         return UnknownVarFromRoomShakingEffect_Boolean_1 && isRunning();
      }
      
      private static function isRunning() : Boolean
      {
         if(UnknownVarFromRoomShakingEffect_Int_1 == 1 || UnknownVarFromRoomShakingEffect_Int_1 == 2)
         {
            return true;
         }
         return false;
      }
   }
}

