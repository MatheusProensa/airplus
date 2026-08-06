package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
   import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEventPresetItem;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class FurnitureDimmerWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FurnitureDimmerWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_DIMMER";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_DIMMER","RWSDPM_SAVE_PRESET","RWCDSM_CHANGE_STATE","RWDPM_PREVIEW_DIMMER_PRESET"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:RoomWidgetFurniToWidgetMessage = null;
         var _loc2_:RoomWidgetDimmerSavePresetMessage = null;
         var _loc5_:RoomWidgetDimmerChangeStateMessage = null;
         var _loc6_:int = 0;
         var _loc3_:RoomWidgetDimmerPreviewMessage = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_DIMMER":
               if(validateRights())
               {
                  _loc4_ = param1 as RoomWidgetFurniToWidgetMessage;
                  _container.roomSession.sendRoomDimmerGetPresetsMessage(_loc4_.id);
               }
               break;
            case "RWSDPM_SAVE_PRESET":
               if(validateRights())
               {
                  _loc2_ = param1 as RoomWidgetDimmerSavePresetMessage;
                  _container.roomSession.sendRoomDimmerSavePresetMessage(_loc2_.presetNumber,_loc2_.effectTypeId,_loc2_.color,_loc2_.brightness,_loc2_.apply,_loc2_.objectId);
               }
               break;
            case "RWCDSM_CHANGE_STATE":
               if(validateRights())
               {
                  _loc5_ = param1 as RoomWidgetDimmerChangeStateMessage;
                  _container.roomSession.sendRoomDimmerChangeStateMessage(_loc5_.objectId);
               }
               break;
            case "RWDPM_PREVIEW_DIMMER_PRESET":
               _loc6_ = _container.roomSession.roomId;
               _loc3_ = param1 as RoomWidgetDimmerPreviewMessage;
               if(_loc3_ == null || _container.roomEngine == null)
               {
                  return null;
               }
               _container.roomEngine.updateObjectRoomColor(_loc6_,_loc3_.color,_loc3_.brightness,_loc3_.bgOnly);
               break;
         }
         return null;
      }
      
      private function validateRights() : Boolean
      {
         var _loc1_:Boolean = _container.roomSession.isRoomOwner;
         var _loc2_:* = _container.roomSession.roomControllerLevel >= 1;
         var _loc3_:Boolean = _container.sessionDataManager.isAnyRoomController;
         return _loc1_ || _loc3_ || _loc2_;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RSDPE_PRESETS");
         _loc1_.push("REDSE_ROOM_COLOR");
         _loc1_.push("RETWE_REMOVE_DIMMER");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc6_:RoomSessionDimmerPresetsEvent = null;
         var _loc2_:RoomWidgetDimmerUpdateEvent = null;
         var _loc7_:int = 0;
         var _loc8_:RoomSessionDimmerPresetsEventPresetItem = null;
         var _loc3_:RoomEngineDimmerStateEvent = null;
         var _loc4_:RoomWidgetDimmerStateUpdateEvent = null;
         var _loc9_:RoomEngineToWidgetEvent = null;
         var _loc5_:RoomWidgetDimmerUpdateEvent = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSDPE_PRESETS":
               _loc6_ = param1 as RoomSessionDimmerPresetsEvent;
               _loc2_ = new RoomWidgetDimmerUpdateEvent("RWDUE_PRESETS");
               _loc2_.selectedPresetId = _loc6_.selectedPresetId;
               _loc2_.itemId = _loc6_.itemId;
               _loc2_.isOn = _loc6_.isOn;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.presetCount)
               {
                  _loc8_ = _loc6_.getPreset(_loc7_);
                  if(_loc8_ != null)
                  {
                     _loc2_.storePreset(_loc8_.id,_loc8_.type,_loc8_.color,_loc8_.light);
                  }
                  _loc7_++;
               }
               _container.events.dispatchEvent(_loc2_);
               break;
            case "REDSE_ROOM_COLOR":
               _loc3_ = param1 as RoomEngineDimmerStateEvent;
               _loc4_ = new RoomWidgetDimmerStateUpdateEvent(_loc3_.objectId,_loc3_.state,_loc3_.presetId,_loc3_.effectId,_loc3_.color,_loc3_.brightness);
               _container.events.dispatchEvent(_loc4_);
               break;
            case "RETWE_REMOVE_DIMMER":
               _loc9_ = param1 as RoomEngineToWidgetEvent;
               _loc5_ = new RoomWidgetDimmerUpdateEvent("RWDUE_HIDE");
               _loc5_.itemId = _loc9_.objectId;
               _container.events.dispatchEvent(_loc5_);
         }
      }
      
      public function update() : void
      {
      }
   }
}

