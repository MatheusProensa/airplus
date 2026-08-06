package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectPlaySoundIdEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class FurnitureCuckooClockLogic extends FurnitureMultiStateLogic
   {
      private var UnknownVarFromFurnitureCuckooClockLogic_Int_1:int = -1;
      
      private var UnknownVarFromFurnitureCuckooClockLogic_IVector3d_1:IVector3d;
      
      public function FurnitureCuckooClockLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROPSIE_PLAY_SOUND_AT_PITCH"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null)
         {
            if(UnknownVarFromFurnitureCuckooClockLogic_Int_1 != -1 && _loc2_.state != UnknownVarFromFurnitureCuckooClockLogic_Int_1)
            {
               playSoundAt(UnknownVarFromFurnitureCuckooClockLogic_IVector3d_1.z);
            }
            UnknownVarFromFurnitureCuckooClockLogic_Int_1 = _loc2_.state;
         }
         else
         {
            UnknownVarFromFurnitureCuckooClockLogic_IVector3d_1 = param1.loc;
         }
      }
      
      private function playSoundAt(param1:Number) : void
      {
         var _loc2_:Number = Math.pow(2,param1 - 1.2);
         eventDispatcher.dispatchEvent(new RoomObjectPlaySoundIdEvent("ROPSIE_PLAY_SOUND_AT_PITCH",object,"FURNITURE_cuckoo_clock",_loc2_));
      }
   }
}

