package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.CustomStackHeightWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class FurnitureCustomStackHeightWidgetHandler implements IRoomWidgetHandler
   {
      private var _container:IRoomWidgetHandlerContainer;
      
      private var UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1:CustomStackHeightWidget;
      
      private var UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_1:int = -1;
      
      private var UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_2:int = -1;
      
      private var UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Number_1:Number = NaN;
      
      public function FurnitureCustomStackHeightWidgetHandler()
      {
         super();
      }
      
      public function set widget(param1:CustomStackHeightWidget) : void
      {
         UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1 = param1;
      }
      
      public function get type() : String
      {
         return "RWE_CUSTOM_STACK_HEIGHT";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null)
         {
            _container.removeUpdateListener(this);
         }
         _container = param1;
         if(_container != null)
         {
            _container.addUpdateListener(this);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc6_:RoomEngineToWidgetEvent = null;
         var _loc3_:IRoomObject = null;
         var _loc7_:int = 0;
         var _loc5_:IFurnitureData = null;
         var _loc2_:* = false;
         var _loc4_:* = false;
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               _loc6_ = param1 as RoomEngineToWidgetEvent;
               if(param1 != null && _container.roomEngine != null)
               {
                  UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_1 = _loc6_.roomId;
                  UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_2 = _loc6_.objectId;
                  _loc3_ = _container.roomEngine.getRoomObject(_loc6_.roomId,_loc6_.objectId,_loc6_.category);
                  if(_loc3_ && validateRights(_loc3_))
                  {
                     if(UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1)
                     {
                        _loc7_ = _loc3_.getModel().getNumber("furniture_type_id");
                        _loc5_ = container.sessionDataManager.getFloorItemData(_loc7_);
                        _loc2_ = _loc5_.className.indexOf("tile_walkmagic") == 0;
                        _loc4_ = _loc3_.getModel().getNumber("furniture_extra") == 1;
                        UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1.open(UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_2,getCurrentStackHeight(_loc3_),_loc2_,_loc4_);
                        UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Number_1 = getCurrentStackHeight(_loc3_);
                     }
                  }
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               _loc6_ = param1 as RoomEngineToWidgetEvent;
               if(param1 != null && _container.roomEngine != null && UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1 != null)
               {
                  if(UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_2 == _loc6_.objectId)
                  {
                     UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1.hide();
                     resetTrackedFurni();
                  }
               }
         }
      }
      
      public function update() : void
      {
         if(_container == null || _container.roomEngine == null || UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1 == null || UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1.mainWindow == null || !UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1.mainWindow.visible)
         {
            return;
         }
         if(UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_1 < 0 || UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_2 < 0)
         {
            return;
         }
         var _loc1_:IRoomObject = _container.roomEngine.getRoomObject(UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_1,UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_2,10);
         if(_loc1_ == null || !validateRights(_loc1_))
         {
            return;
         }
         var _loc2_:Number = getCurrentStackHeight(_loc1_);
         if(isNaN(UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Number_1) || UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Number_1 != _loc2_)
         {
            UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Number_1 = _loc2_;
            UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1.updateHeight(_loc1_.getId(),_loc2_);
         }
      }
      
      public function dispose() : void
      {
         if(_container != null)
         {
            _container.removeUpdateListener(this);
         }
         resetTrackedFurni();
         _container = null;
         UnknownVarFromFurnitureCustomStackHeightWidgetHandler_CustomStackHeightWidget_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      private function getCurrentStackHeight(param1:IRoomObject) : Number
      {
         if(param1 == null || param1.getLocation() == null)
         {
            return 0;
         }
         var _loc2_:Number = param1.getLocation().z;
         return isNaN(_loc2_) ? 0 : _loc2_;
      }
      
      private function validateRights(param1:IRoomObject = null) : Boolean
      {
         var _loc2_:Boolean = _container.roomSession.isRoomOwner;
         var _loc3_:* = _container.roomSession.roomControllerLevel >= 1;
         var _loc4_:Boolean = _container.sessionDataManager.isAnyRoomController;
         var _loc5_:Boolean = param1 && _container.isOwnerOfFurniture(param1);
         return _loc2_ || _loc4_ || _loc3_ || _loc5_;
      }
      
      private function resetTrackedFurni() : void
      {
         UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_1 = -1;
         UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Int_2 = -1;
         UnknownVarFromFurnitureCustomStackHeightWidgetHandler_Number_1 = NaN;
      }
   }
}

