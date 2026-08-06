package com.sulake.habbo.session.events
{
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultData;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetBreedingResultEvent extends RoomSessionEvent
   {
      public static const PET_BREEDING_RESULT:String = "RSPFUE_PET_BREEDING_RESULT";
      
      private var _resultData:PetBreedingResultData;
      
      private var _otherResultData:PetBreedingResultData;
      
      public function RoomSessionPetBreedingResultEvent(param1:IRoomSession, param2:PetBreedingResultData, param3:PetBreedingResultData, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPFUE_PET_BREEDING_RESULT",param1,param4,param5);
         _resultData = param2;
         _otherResultData = param3;
      }
      
      public function get resultData() : PetBreedingResultData
      {
         return _resultData;
      }
      
      public function get otherResultData() : PetBreedingResultData
      {
         return _otherResultData;
      }
   }
}

