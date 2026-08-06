package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import flash.utils.getTimer;
   
   public class FurnitureChestLogic extends FurnitureLogic
   {
      private static const IS_WIRED_ENABLED_KEY:String = "is_wired_enabled";
      
      private var UnknownVarFromFurnitureChestLogic_Boolean_1:Boolean = false;
      
      public function FurnitureChestLogic()
      {
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:MapStuffData = null;
         var _loc4_:* = false;
         super.processUpdateMessage(param1);
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.data as MapStuffData;
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.getValue("is_wired_enabled") == "1";
               if(_loc4_ != UnknownVarFromFurnitureChestLogic_Boolean_1)
               {
                  UnknownVarFromFurnitureChestLogic_Boolean_1 = _loc4_;
                  object.getModelController().setNumber("furniture_chest_is_wired_enabled",_loc4_ ? 1 : 0);
                  this.update(getTimer());
               }
            }
         }
      }
   }
}

