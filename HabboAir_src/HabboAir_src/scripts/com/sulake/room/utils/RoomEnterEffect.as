package com.sulake.room.utils
{
   import flash.utils.getTimer;
   
   public class RoomEnterEffect
   {
      public static const STATE_NOT_INITIALIZED:int = 0;
      
      public static const STATE_START_DELAY:int = 1;
      
      public static const STATE_RUNNING:int = 2;
      
      public static const STATE_OVER:int = 3;
      
      private static var UnknownVarFromRoomEnterEffect_Int_1:int = 0;
      
      private static var UnknownVarFromRoomEnterEffect_Boolean_1:Boolean = false;
      
      private static var UnknownVarFromRoomEnterEffect_Number_1:Number;
      
      private static var UnknownVarFromRoomEnterEffect_Int_2:int = 0;
      
      private static var UnknownVarFromRoomEnterEffect_Int_3:int = 20000;
      
      private static var UnknownVarFromRoomEnterEffect_Int_4:int = 2000;
      
      public function RoomEnterEffect()
      {
         super();
      }
      
      public static function init(param1:int, param2:int) : void
      {
         UnknownVarFromRoomEnterEffect_Number_1 = 0;
         UnknownVarFromRoomEnterEffect_Int_3 = param1;
         UnknownVarFromRoomEnterEffect_Int_4 = param2;
         UnknownVarFromRoomEnterEffect_Int_2 = getTimer();
         UnknownVarFromRoomEnterEffect_Int_1 = 1;
      }
      
      public static function turnVisualizationOn() : void
      {
         if(UnknownVarFromRoomEnterEffect_Int_1 == 0 || UnknownVarFromRoomEnterEffect_Int_1 == 3)
         {
            return;
         }
         var _loc1_:int = getTimer() - UnknownVarFromRoomEnterEffect_Int_2;
         if(_loc1_ > UnknownVarFromRoomEnterEffect_Int_3 + UnknownVarFromRoomEnterEffect_Int_4)
         {
            UnknownVarFromRoomEnterEffect_Int_1 = 3;
            return;
         }
         UnknownVarFromRoomEnterEffect_Boolean_1 = true;
         if(_loc1_ < UnknownVarFromRoomEnterEffect_Int_3)
         {
            UnknownVarFromRoomEnterEffect_Int_1 = 1;
            return;
         }
         UnknownVarFromRoomEnterEffect_Int_1 = 2;
         UnknownVarFromRoomEnterEffect_Number_1 = (_loc1_ - UnknownVarFromRoomEnterEffect_Int_3) / UnknownVarFromRoomEnterEffect_Int_4;
      }
      
      public static function turnVisualizationOff() : void
      {
         UnknownVarFromRoomEnterEffect_Boolean_1 = false;
      }
      
      public static function isVisualizationOn() : Boolean
      {
         return UnknownVarFromRoomEnterEffect_Boolean_1 && isRunning();
      }
      
      public static function isRunning() : Boolean
      {
         if(UnknownVarFromRoomEnterEffect_Int_1 == 1 || UnknownVarFromRoomEnterEffect_Int_1 == 2)
         {
            return true;
         }
         return false;
      }
      
      public static function getDelta(param1:Number = 0, param2:Number = 1) : Number
      {
         return Math.min(Math.max(UnknownVarFromRoomEnterEffect_Number_1,param1),param2);
      }
      
      public static function get totalRunningTime() : int
      {
         return UnknownVarFromRoomEnterEffect_Int_3 + UnknownVarFromRoomEnterEffect_Int_4;
      }
   }
}

