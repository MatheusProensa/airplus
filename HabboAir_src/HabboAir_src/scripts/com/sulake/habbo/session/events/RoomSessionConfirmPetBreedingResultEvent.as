package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionConfirmPetBreedingResultEvent extends RoomSessionEvent
   {
      public static const CONFIRM_PET_BREEDING_RESULT:String = "RSPFUE_CONFIRM_PET_BREEDING_RESULT";
      
      private var _breedingNestStuffId:int;
      
      private var _result:int;
      
      public function RoomSessionConfirmPetBreedingResultEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPFUE_CONFIRM_PET_BREEDING_RESULT",param1,param4,param5);
         _breedingNestStuffId = param2;
         _result = param3;
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

