package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.VoteResultStuffData;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class UnknownHabboRoomObjectLogicFurniture15 extends FurnitureMultiStateLogic
   {
      public function UnknownHabboRoomObjectLogicFurniture15()
      {
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:VoteResultStuffData = null;
         super.processUpdateMessage(param1);
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.data as VoteResultStuffData;
            if(_loc2_ != null)
            {
               object.getModelController().setNumber("furniture_vote_majority_result",_loc2_.result);
            }
         }
      }
   }
}

