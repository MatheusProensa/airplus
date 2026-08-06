package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class FurnitureIceStormLogic extends FurnitureMultiStateLogic
   {
      private var UnknownVarFromFurnitureIceStormLogic_Int_1:int = 0;
      
      private var UnknownVarFromFurnitureIceStormLogic_Number_1:Number = 0;
      
      private var UnknownVarFromFurnitureIceStormLogic_Int_2:int = 0;
      
      public function FurnitureIceStormLogic()
      {
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null)
         {
            handleDataUpdateMessage(_loc2_);
            return;
         }
         super.processUpdateMessage(param1);
      }
      
      private function handleDataUpdateMessage(param1:RoomObjectDataUpdateMessage) : void
      {
         var _loc3_:LegacyStuffData = null;
         var _loc4_:int = param1.state / 1000;
         var _loc2_:int = param1.state % 1000;
         if(_loc2_ == 0)
         {
            UnknownVarFromFurnitureIceStormLogic_Int_2 = 0;
            _loc3_ = new LegacyStuffData();
            _loc3_.setString(String(_loc4_));
            param1 = new RoomObjectDataUpdateMessage(_loc4_,_loc3_,param1.extra);
            super.processUpdateMessage(param1);
         }
         else
         {
            UnknownVarFromFurnitureIceStormLogic_Int_1 = _loc4_;
            UnknownVarFromFurnitureIceStormLogic_Number_1 = param1.extra;
            UnknownVarFromFurnitureIceStormLogic_Int_2 = lastUpdateTime + _loc2_;
         }
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:LegacyStuffData = null;
         var _loc3_:RoomObjectDataUpdateMessage = null;
         if(UnknownVarFromFurnitureIceStormLogic_Int_2 > 0 && param1 >= UnknownVarFromFurnitureIceStormLogic_Int_2)
         {
            UnknownVarFromFurnitureIceStormLogic_Int_2 = 0;
            _loc2_ = new LegacyStuffData();
            _loc2_.setString(String(UnknownVarFromFurnitureIceStormLogic_Int_1));
            _loc3_ = new RoomObjectDataUpdateMessage(UnknownVarFromFurnitureIceStormLogic_Int_1,_loc2_,UnknownVarFromFurnitureIceStormLogic_Number_1);
            super.processUpdateMessage(_loc3_);
         }
         super.update(param1);
      }
   }
}

