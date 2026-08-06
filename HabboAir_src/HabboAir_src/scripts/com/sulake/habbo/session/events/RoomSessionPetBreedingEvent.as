package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetBreedingEvent extends RoomSessionEvent
   {
      public static const PET_BREEDING:String = "RSPFUE_PET_BREEDING";
      
      private var _state:int;
      
      private var _ownPetId:int;
      
      private var _otherPetId:int;
      
      public function RoomSessionPetBreedingEvent(param1:IRoomSession, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSPFUE_PET_BREEDING",param1,param5,param6);
         _state = param2;
         _ownPetId = param3;
         _otherPetId = param4;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get ownPetId() : int
      {
         return _ownPetId;
      }
      
      public function get otherPetId() : int
      {
         return _otherPetId;
      }
   }
}

