package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class FurnitureSoundMachineLogic extends FurnitureMultiStateLogic
   {
      private var UnknownVarFromFurnitureSoundMachineLogic_Boolean_1:Boolean;
      
      private var UnknownVarFromFurnitureSoundMachineLogic_Boolean_2:Boolean = false;
      
      private var UnknownVarFromFurnitureSoundMachineLogic_Int_1:int = -1;
      
      public function FurnitureSoundMachineLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROFCAE_SOUND_MACHINE_START","ROFCAE_SOUND_MACHINE_STOP","ROFCAE_SOUND_MACHINE_DISPOSE","ROFCAE_SOUND_MACHINE_INIT"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         requestDispose();
         super.dispose();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:RoomObjectDataUpdateMessage = null;
         var _loc2_:int = 0;
         super.processUpdateMessage(param1);
         if(object == null)
         {
            return;
         }
         if(object.getModelController().getNumber("furniture_real_room_object") == 1)
         {
            if(!UnknownVarFromFurnitureSoundMachineLogic_Boolean_2)
            {
               requestInitialize();
            }
            _loc3_ = param1 as RoomObjectDataUpdateMessage;
            if(_loc3_ == null)
            {
               return;
            }
            _loc2_ = int(object.getState(0));
            if(_loc2_ != UnknownVarFromFurnitureSoundMachineLogic_Int_1)
            {
               UnknownVarFromFurnitureSoundMachineLogic_Int_1 = _loc2_;
               if(_loc2_ == 1)
               {
                  requestPlayList();
               }
               else if(_loc2_ == 0)
               {
                  requestStopPlaying();
               }
            }
         }
      }
      
      private function requestInitialize() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         UnknownVarFromFurnitureSoundMachineLogic_Boolean_1 = true;
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_INIT",object);
         eventDispatcher.dispatchEvent(_loc1_);
         UnknownVarFromFurnitureSoundMachineLogic_Boolean_2 = true;
      }
      
      private function requestPlayList() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         UnknownVarFromFurnitureSoundMachineLogic_Boolean_1 = true;
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_START",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function requestStopPlaying() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_STOP",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function requestDispose() : void
      {
         if(!UnknownVarFromFurnitureSoundMachineLogic_Boolean_1)
         {
            return;
         }
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_DISPOSE",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
   }
}

