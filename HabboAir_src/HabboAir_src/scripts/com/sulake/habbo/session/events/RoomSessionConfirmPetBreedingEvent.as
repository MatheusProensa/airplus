package com.sulake.habbo.session.events
{
   import com.sulake.habbo.communication.messages.incoming.room.pets.BreedingPetInfo;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionConfirmPetBreedingEvent extends RoomSessionEvent
   {
      public static const CONFIRM_PET_BREEDING:String = "RSPFUE_CONFIRM_PET_BREEDING";
      
      private var _nestId:int;
      
      private var _pet1:BreedingPetInfo;
      
      private var _pet2:BreedingPetInfo;
      
      private var _rarityCategories:Array;
      
      private var _resultPetTypeId:int;
      
      public function RoomSessionConfirmPetBreedingEvent(param1:IRoomSession, param2:int, param3:BreedingPetInfo, param4:BreedingPetInfo, param5:Array, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super("RSPFUE_CONFIRM_PET_BREEDING",param1,param7,param8);
         _nestId = param2;
         _pet1 = param3;
         _pet2 = param4;
         _rarityCategories = param5;
         _resultPetTypeId = param6;
      }
      
      public function get rarityCategories() : Array
      {
         return _rarityCategories;
      }
      
      public function get nestId() : int
      {
         return _nestId;
      }
      
      public function get pet1() : BreedingPetInfo
      {
         return _pet1;
      }
      
      public function get pet2() : BreedingPetInfo
      {
         return _pet2;
      }
      
      public function get resultPetTypeId() : int
      {
         return _resultPetTypeId;
      }
   }
}

