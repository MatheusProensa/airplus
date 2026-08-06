package com.sulake.room.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomRotatingEffect
   {
      public static const STATE_NOT_INITIALIZED:int = 0;
      
      public static const STATE_START_DELAY:int = 1;
      
      public static const STATE_RUNNING:int = 2;
      
      public static const STATE_OVER:int = 3;
      
      private static var UnknownVarFromRoomRotatingEffect_Int_1:int = 0;
      
      private static var UnknownVarFromRoomRotatingEffect_Boolean_1:Boolean = false;
      
      private static var UnknownVarFromRoomRotatingEffect_Number_1:Number;
      
      private static var UnknownVarFromRoomRotatingEffect_Int_2:int = 0;
      
      private static var UnknownVarFromRoomRotatingEffect_Int_3:int = 20000;
      
      private static var UnknownVarFromRoomRotatingEffect_Int_4:int = 5000;
      
      private static var UnknownVarFromRoomRotatingEffect_Timer_1:Timer;
      
      public function RoomRotatingEffect()
      {
         super();
      }
      
      public static function init(param1:int, param2:int) : void
      {
         UnknownVarFromRoomRotatingEffect_Number_1 = 0;
         UnknownVarFromRoomRotatingEffect_Int_3 = param1;
         UnknownVarFromRoomRotatingEffect_Int_4 = param2;
         UnknownVarFromRoomRotatingEffect_Int_2 = getTimer();
         UnknownVarFromRoomRotatingEffect_Int_1 = 1;
      }
      
      public static function turnVisualizationOn() : void
      {
         if(UnknownVarFromRoomRotatingEffect_Int_1 == 0 || UnknownVarFromRoomRotatingEffect_Int_1 == 3)
         {
            return;
         }
         if(UnknownVarFromRoomRotatingEffect_Timer_1 == null || !UnknownVarFromRoomRotatingEffect_Timer_1.running)
         {
            UnknownVarFromRoomRotatingEffect_Timer_1 = new Timer(UnknownVarFromRoomRotatingEffect_Int_4,1);
            UnknownVarFromRoomRotatingEffect_Timer_1.addEventListener("timerComplete",turnVisualizationOff);
            UnknownVarFromRoomRotatingEffect_Timer_1.start();
         }
         var _loc1_:int = getTimer() - UnknownVarFromRoomRotatingEffect_Int_2;
         if(_loc1_ > UnknownVarFromRoomRotatingEffect_Int_3 + UnknownVarFromRoomRotatingEffect_Int_4)
         {
            UnknownVarFromRoomRotatingEffect_Int_1 = 3;
            return;
         }
         UnknownVarFromRoomRotatingEffect_Boolean_1 = true;
         if(_loc1_ < UnknownVarFromRoomRotatingEffect_Int_3)
         {
            UnknownVarFromRoomRotatingEffect_Int_1 = 1;
            return;
         }
         UnknownVarFromRoomRotatingEffect_Int_1 = 2;
         UnknownVarFromRoomRotatingEffect_Number_1 = (_loc1_ - UnknownVarFromRoomRotatingEffect_Int_3) / UnknownVarFromRoomRotatingEffect_Int_4;
      }
      
      public static function turnVisualizationOff(param1:TimerEvent) : void
      {
         UnknownVarFromRoomRotatingEffect_Boolean_1 = false;
         UnknownVarFromRoomRotatingEffect_Timer_1.stop();
         UnknownVarFromRoomRotatingEffect_Timer_1.removeEventListener("timerComplete",turnVisualizationOff);
         UnknownVarFromRoomRotatingEffect_Timer_1 = null;
      }
      
      public static function isVisualizationOn() : Boolean
      {
         return UnknownVarFromRoomRotatingEffect_Boolean_1 && isRunning();
      }
      
      private static function isRunning() : Boolean
      {
         if(UnknownVarFromRoomRotatingEffect_Int_1 == 1 || UnknownVarFromRoomRotatingEffect_Int_1 == 2)
         {
            return true;
         }
         return false;
      }
   }
}

