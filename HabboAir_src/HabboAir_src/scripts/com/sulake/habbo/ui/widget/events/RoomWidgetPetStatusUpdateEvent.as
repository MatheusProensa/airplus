package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetStatusUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const PET_STATUS_UPDATE:String = "RWPIUE_PET_STATUS_UPDATE";
      
      private var _petId:int;
      
      private var _canBreed:Boolean;
      
      private var _canHarvest:Boolean;
      
      private var _canRevive:Boolean;
      
      private var _hasBreedingPermission:Boolean;
      
      public function RoomWidgetPetStatusUpdateEvent(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWPIUE_PET_STATUS_UPDATE",param6,param7);
         _petId = param1;
         _canBreed = param2;
         _canHarvest = param3;
         _canRevive = param4;
         _hasBreedingPermission = param5;
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

