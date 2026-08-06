package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionNestBreedingSuccessEvent extends RoomSessionEvent
   {
      public static const NEST_BREEDING_SUCCESS:String = "RSPFUE_NEST_BREEDING_SUCCESS";
      
      private var _rarityCategory:int;
      
      private var _petId:int;
      
      public function RoomSessionNestBreedingSuccessEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPFUE_NEST_BREEDING_SUCCESS",param1,param4,param5);
         _petId = param2;
         _rarityCategory = param3;
      }
      
      public function get rarityCategory() : int
      {
         return _rarityCategory;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
   }
}

