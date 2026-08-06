package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetBreedingResultEvent extends RoomWidgetUpdateEvent
   {
      public static const PET_BREEDING_RESULT:String = "RWPBRE_PET_BREEDING_RESULT";
      
      private var _resultData:PetBreedingResultEventData;
      
      private var _resultData2:PetBreedingResultEventData;
      
      public function RoomWidgetPetBreedingResultEvent(param1:PetBreedingResultEventData, param2:PetBreedingResultEventData, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWPBRE_PET_BREEDING_RESULT",param3,param4);
         _resultData = param1;
         _resultData2 = param2;
      }
      
      public function get resultData() : PetBreedingResultEventData
      {
         return _resultData;
      }
      
      public function get resultData2() : PetBreedingResultEventData
      {
         return _resultData2;
      }
   }
}

