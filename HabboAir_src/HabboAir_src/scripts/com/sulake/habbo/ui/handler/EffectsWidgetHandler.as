package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.effects.EffectsWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class EffectsWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromEffectsWidgetHandler_EffectsWidget_1:EffectsWidget;
      
      public function EffectsWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            container = null;
            UnknownVarFromEffectsWidgetHandler_EffectsWidget_1 = null;
            _disposed = true;
         }
      }
      
      public function get type() : String
      {
         return "RWE_EFFECTS";
      }
      
      public function set widget(param1:EffectsWidget) : void
      {
         UnknownVarFromEffectsWidgetHandler_EffectsWidget_1 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container && _container.inventory)
         {
            _container.inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         }
         _container = param1;
         if(_container && _container.inventory)
         {
            _container.inventory.events.addEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      private function onEffectsChanged(param1:HabboInventoryEffectsEvent) : void
      {
         if(UnknownVarFromEffectsWidgetHandler_EffectsWidget_1)
         {
            UnknownVarFromEffectsWidgetHandler_EffectsWidget_1.open();
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWRWM_EFFECTS"];
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:* = param1.type;
         if("RWRWM_EFFECTS" === _loc2_)
         {
            UnknownVarFromEffectsWidgetHandler_EffectsWidget_1.open();
         }
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

