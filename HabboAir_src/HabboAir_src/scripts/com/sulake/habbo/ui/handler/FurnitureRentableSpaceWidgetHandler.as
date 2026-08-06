package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentOkMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceStatusMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceCancelRentMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceRentMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceStatusMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceRentFailedMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceStatusMessageParser;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.rentablespace.RentableSpaceDisplayWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class FurnitureRentableSpaceWidgetHandler implements IRoomWidgetHandler
   {
      private var _container:IRoomWidgetHandlerContainer;
      
      private var UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceDisplayWidget_1:RentableSpaceDisplayWidget;
      
      private var UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceStatusMessageEvent_1:RentableSpaceStatusMessageEvent;
      
      private var UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentOkMessageEvent_1:RentableSpaceRentOkMessageEvent;
      
      private var UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentFailedMessageEvent_1:RentableSpaceRentFailedMessageEvent;
      
      public function FurnitureRentableSpaceWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_RENTABLESPACE";
      }
      
      public function set widget(param1:RentableSpaceDisplayWidget) : void
      {
         UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceDisplayWidget_1 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceStatusMessageEvent_1 = new RentableSpaceStatusMessageEvent(onRentableSpaceStatusMessage);
         _container.connection.addMessageEvent(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceStatusMessageEvent_1);
         UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentOkMessageEvent_1 = new RentableSpaceRentOkMessageEvent(onRentableSpaceRentOkMessage);
         _container.connection.addMessageEvent(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentOkMessageEvent_1);
         UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentFailedMessageEvent_1 = new RentableSpaceRentFailedMessageEvent(onRentableSpaceRentFailedMessage);
         _container.connection.addMessageEvent(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentFailedMessageEvent_1);
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
         if(_container.roomEngine == null)
         {
            return;
         }
         var _loc3_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.objectId,_loc3_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(_loc2_ != null)
               {
                  UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceDisplayWidget_1.show(_loc2_);
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceDisplayWidget_1.hide(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceStatusMessageEvent_1 != null)
         {
            _container.connection.removeMessageEvent(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceStatusMessageEvent_1);
            UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceStatusMessageEvent_1 = null;
         }
         if(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentOkMessageEvent_1 != null)
         {
            _container.connection.removeMessageEvent(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentOkMessageEvent_1);
            UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentOkMessageEvent_1 = null;
         }
         if(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentFailedMessageEvent_1 != null)
         {
            _container.connection.removeMessageEvent(UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentFailedMessageEvent_1);
            UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceRentFailedMessageEvent_1 = null;
         }
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      public function onRentableSpaceRentOkMessage(param1:RentableSpaceRentOkMessageEvent) : void
      {
         UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceDisplayWidget_1.updateWidgetState();
      }
      
      public function onRentableSpaceRentFailedMessage(param1:RentableSpaceRentFailedMessageEvent) : void
      {
         var _loc2_:RentableSpaceRentFailedMessageParser = param1.getParser();
         UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceDisplayWidget_1.showErrorView(_loc2_.reason);
      }
      
      public function onRentableSpaceStatusMessage(param1:RentableSpaceStatusMessageEvent) : void
      {
         var _loc2_:RentableSpaceStatusMessageParser = param1.getParser();
         UnknownVarFromFurnitureRentableSpaceWidgetHandler_RentableSpaceDisplayWidget_1.populateRentInfo(_loc2_.rented,_loc2_.canRent,_loc2_.canRentErrorCode,_loc2_.renterId,_loc2_.renterName,_loc2_.timeRemaining,_loc2_.price);
      }
      
      public function getRentableSpaceStatus(param1:int) : void
      {
         _container.connection.send(new RentableSpaceStatusMessageComposer(param1));
      }
      
      public function cancelRent(param1:int) : void
      {
         _container.connection.send(new RentableSpaceCancelRentMessageComposer(param1));
      }
      
      public function rentSpace(param1:int) : void
      {
         _container.connection.send(new RentableSpaceRentMessageComposer(param1));
      }
      
      public function getUsersClubLevel() : int
      {
         return _container.sessionDataManager.clubLevel;
      }
      
      public function getUsersCreditAmount() : int
      {
         return _container.catalog.getPurse().credits;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
   }
}

