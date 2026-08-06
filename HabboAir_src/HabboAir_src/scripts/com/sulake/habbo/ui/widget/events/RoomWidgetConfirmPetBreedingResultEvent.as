package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetConfirmPetBreedingResultEvent extends RoomWidgetUpdateEvent
   {
      public static const CONFIRM_PET_BREEDING_RESULT:String = "RWPPBE_CONFIRM_PET_BREEDING_RESULT";
      
      public static const SUCCESS:int = 0;
      
      public static const NO_NEST_FOUND:int = 1;
      
      public static const PETS_MISSING:int = 2;
      
      public static const INVALID_NAME:int = 3;
      
      private var _breedingNestStuffId:int;
      
      private var _result:int;
      
      public function RoomWidgetConfirmPetBreedingResultEvent(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWPPBE_CONFIRM_PET_BREEDING_RESULT",param3,param4);
         _breedingNestStuffId = param1;
         _result = param2;
      }
      
      public function get breedingNestStuffId() : int
      {
         return _breedingNestStuffId;
      }
      
      public function get result() : int
      {
         return _result;
      }
   }
}

