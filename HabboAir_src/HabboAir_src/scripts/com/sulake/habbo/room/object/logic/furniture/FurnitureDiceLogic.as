package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureDiceLogic extends FurnitureLogic
   {
      private var UnknownVarFromFurnitureDiceLogic_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFurnitureDiceLogic_Boolean_2:Boolean = false;
      
      public function FurnitureDiceLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROFCAE_DICE_ACTIVATE","ROFCAE_DICE_OFF"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.allspritesactivate;
         if(_loc2_.length() == 0)
         {
            UnknownVarFromFurnitureDiceLogic_Boolean_1 = false;
         }
         else
         {
            UnknownVarFromFurnitureDiceLogic_Boolean_1 = true;
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc3_:RoomObjectEvent = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc4_:* = param1.type;
         if("doubleClick" !== _loc4_)
         {
            super.mouseEvent(param1,param2);
         }
         else if(eventDispatcher != null)
         {
            if(UnknownVarFromFurnitureDiceLogic_Boolean_1)
            {
               if(!UnknownVarFromFurnitureDiceLogic_Boolean_2 || object.getState(0) == 0 || object.getState(0) == 100)
               {
                  _loc3_ = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_ACTIVATE",object);
                  UnknownVarFromFurnitureDiceLogic_Boolean_2 = true;
               }
               else
               {
                  _loc3_ = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_OFF",object);
                  UnknownVarFromFurnitureDiceLogic_Boolean_2 = false;
               }
            }
            else if(param1.spriteTag == "activate" || object.getState(0) == 0 || object.getState(0) == 100)
            {
               _loc3_ = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_ACTIVATE",object);
            }
            else if(param1.spriteTag == "deactivate")
            {
               _loc3_ = new RoomObjectFurnitureActionEvent("ROFCAE_DICE_OFF",object);
            }
            if(_loc3_ != null)
            {
               eventDispatcher.dispatchEvent(_loc3_);
            }
         }
      }
   }
}

