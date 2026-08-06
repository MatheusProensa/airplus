package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomUserNotificationMessageEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.requirementsmissing.CustomUserNotificationWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class CustomUserNotificationWidgetHandler implements IRoomWidgetHandler
   {
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1:CustomUserNotificationWidget;
      
      private var UnknownVarFromCustomUserNotificationWidgetHandler_IMessageEvent_1:IMessageEvent;
      
      public function CustomUserNotificationWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_CUSTOM_USER_NOTIFICATION";
      }
      
      public function set widget(param1:CustomUserNotificationWidget) : void
      {
         UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         if(!UnknownVarFromCustomUserNotificationWidgetHandler_IMessageEvent_1)
         {
            UnknownVarFromCustomUserNotificationWidgetHandler_IMessageEvent_1 = new CustomUserNotificationMessageEvent(onFurnitureUsageRequirementMissingMessage);
            _container.connection.addMessageEvent(UnknownVarFromCustomUserNotificationWidgetHandler_IMessageEvent_1);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function getWidgetMessages() : Array
      {
         return [];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(_container.connection && UnknownVarFromCustomUserNotificationWidgetHandler_IMessageEvent_1)
            {
               _container.connection.removeMessageEvent(UnknownVarFromCustomUserNotificationWidgetHandler_IMessageEvent_1);
            }
            UnknownVarFromCustomUserNotificationWidgetHandler_IMessageEvent_1 = null;
            UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1 = null;
            _container = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function onFurnitureUsageRequirementMissingMessage(param1:CustomUserNotificationMessageEvent) : void
      {
         var _loc2_:int = param1.getParser().code;
         if(UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1)
         {
            switch(_loc2_ - 1)
            {
               case 0:
                  UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1.open("costumehopper");
                  break;
               case 1:
                  UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1.open("viphopper");
                  break;
               case 2:
                  UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1.open("vipgate");
                  break;
               case 3:
                  UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1.open("respectfailedstage");
                  break;
               case 4:
                  UnknownVarFromCustomUserNotificationWidgetHandler_CustomUserNotificationWidget_1.open("respectfailedaudience");
            }
         }
      }
   }
}

