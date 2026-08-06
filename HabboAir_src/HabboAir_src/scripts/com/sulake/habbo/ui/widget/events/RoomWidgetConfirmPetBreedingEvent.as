package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetConfirmPetBreedingEvent extends RoomWidgetUpdateEvent
   {
      public static const CONFIRM_PET_BREEDING:String = "RWPPBE_CONFIRM_PET_BREEDING_";
      
      private var _nestId:int;
      
      private var _pet1:ConfirmPetBreedingPetData;
      
      private var _pet2:ConfirmPetBreedingPetData;
      
      private var _rarityCategories:Array;
      
      private var _resultPetTypeId:int;
      
      public function RoomWidgetConfirmPetBreedingEvent(param1:int, param2:ConfirmPetBreedingPetData, param3:ConfirmPetBreedingPetData, param4:Array, param5:int, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWPPBE_CONFIRM_PET_BREEDING_",param6,param7);
         _nestId = param1;
         _pet1 = param2;
         _pet2 = param3;
         _rarityCategories = param4;
         _resultPetTypeId = param5;
      }
      
      public function get rarityCategories() : Array
      {
         return _rarityCategories;
      }
      
      public function get nestId() : int
      {
         return _nestId;
      }
      
      public function get pet1() : ConfirmPetBreedingPetData
      {
         return _pet1;
      }
      
      public function get pet2() : ConfirmPetBreedingPetData
      {
         return _pet2;
      }
      
      public function get resultPetTypeId() : int
      {
         return _resultPetTypeId;
      }
   }
}

