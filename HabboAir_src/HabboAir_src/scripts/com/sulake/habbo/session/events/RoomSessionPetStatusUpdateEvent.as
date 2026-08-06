package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetStatusUpdateEvent extends RoomSessionEvent
   {
      public static const PET_STATUS_UPDATE:String = "RSPFUE_PET_STATUS_UPDATE";
      
      private var _petId:int;
      
      private var _canBreed:Boolean;
      
      private var _canHarvest:Boolean;
      
      private var _canRevive:Boolean;
      
      private var _hasBreedingPermission:Boolean;
      
      public function RoomSessionPetStatusUpdateEvent(param1:IRoomSession, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean = false, param8:Boolean = false)
      {
         super("RSPFUE_PET_STATUS_UPDATE",param1,param7,param8);
         _petId = param2;
         _canBreed = param3;
         _canHarvest = param4;
         _canRevive = param5;
         _hasBreedingPermission = param6;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get canBreed() : Boolean
      {
         return _canBreed;
      }
      
      public function get canHarvest() : Boolean
      {
         return _canHarvest;
      }
      
      public function get canRevive() : Boolean
      {
         return _canRevive;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return _hasBreedingPermission;
      }
   }
}

