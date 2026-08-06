package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class FurnitureRoomDimmerLogic extends FurnitureLogic
   {
      private var UnknownVarFromFurnitureRoomDimmerLogic_Boolean_1:Boolean = false;
      
      public function FurnitureRoomDimmerLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_DIMMER","ROWRE_WIDGET_REMOVE_DIMMER","RODSUE_DIMMER_STATE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_DIMMER",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         var _loc3_:RoomObjectDimmerStateUpdateEvent = null;
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc4_:RoomObjectEvent = null;
         if(UnknownVarFromFurnitureRoomDimmerLogic_Boolean_1)
         {
            if(eventDispatcher != null && object != null)
            {
               if(object.getModelController().getNumber("furniture_real_room_object") == 1)
               {
                  _loc1_ = 16777215;
                  _loc2_ = 255;
                  _loc3_ = new RoomObjectDimmerStateUpdateEvent(object,0,1,1,_loc1_,_loc2_);
                  eventDispatcher.dispatchEvent(_loc3_);
                  _loc4_ = new RoomObjectWidgetRequestEvent("ROWRE_WIDGET_REMOVE_DIMMER",object);
                  eventDispatcher.dispatchEvent(_loc4_);
               }
               UnknownVarFromFurnitureRoomDimmerLogic_Boolean_1 = false;
            }
         }
         super.dispose();
      }
      
      private function dispatchColorUpdateEvent(param1:String) : void
      {
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc8_:RoomObjectDimmerStateUpdateEvent = null;
         if(param1 == null)
         {
            return;
         }
         var _loc7_:Array = param1.split(",");
         if(_loc7_.length >= 5)
         {
            _loc6_ = readState(param1);
            _loc9_ = parseInt(_loc7_[1]);
            _loc2_ = parseInt(_loc7_[2]);
            _loc5_ = _loc7_[3];
            _loc3_ = parseInt(_loc5_.substr(1),16);
            _loc4_ = parseInt(_loc7_[4]);
            if(_loc6_ == 0)
            {
               _loc3_ = 16777215;
               _loc4_ = 255;
            }
            if(eventDispatcher != null && object != null)
            {
               _loc8_ = new RoomObjectDimmerStateUpdateEvent(object,_loc6_,_loc9_,_loc2_,_loc3_,_loc4_);
               eventDispatcher.dispatchEvent(_loc8_);
               UnknownVarFromFurnitureRoomDimmerLogic_Boolean_1 = true;
            }
         }
      }
      
      private function readState(param1:String) : int
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return 0;
         }
         var _loc3_:Array = param1.split(",");
         if(_loc3_.length >= 5)
         {
            return int(parseInt(_loc3_[0]) - 1);
         }
         return 0;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            if(_loc3_.data != null)
            {
               if(object.getModelController().getNumber("furniture_real_room_object") == 1)
               {
                  dispatchColorUpdateEvent(_loc3_.data.getLegacyString());
               }
               _loc2_ = readState(_loc3_.data.getLegacyString());
               _loc3_ = new RoomObjectDataUpdateMessage(_loc2_,_loc3_.data);
               super.processUpdateMessage(_loc3_);
            }
            return;
         }
         super.processUpdateMessage(param1);
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:String = null;
         super.update(param1);
         if(object != null && object.getModelController() != null)
         {
            if(object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
               _loc2_ = object.getModelController().getString("furniture_data");
               if(_loc2_ != null && _loc2_.length > 0)
               {
                  object.getModelController().setString("furniture_data","");
                  dispatchColorUpdateEvent(_loc2_);
               }
            }
         }
      }
   }
}

