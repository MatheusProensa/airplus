package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetBreedingEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetPetBreedingEvent_Int_1:int = 0;
      
      public static const UnknownConstFromRoomWidgetPetBreedingEvent_Int_2:int = 1;
      
      public static const TYPE_ACCEPT:int = 2;
      
      public static const TYPE_REQUEST:int = 3;
      
      public static const PET_BREEDING:String = "RWPPBE_PET_BREEDING_";
      
      private var _state:int;
      
      private var _ownPetId:int;
      
      private var _otherPetId:int;
      
      public function RoomWidgetPetBreedingEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("RWPPBE_PET_BREEDING_",param1,param2);
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get ownPetId() : int
      {
         return _ownPetId;
      }
      
      public function set ownPetId(param1:int) : void
      {
         _ownPetId = param1;
      }
      
      public function get otherPetId() : int
      {
         return _otherPetId;
      }
      
      public function set otherPetId(param1:int) : void
      {
         _otherPetId = param1;
      }
   }
}

