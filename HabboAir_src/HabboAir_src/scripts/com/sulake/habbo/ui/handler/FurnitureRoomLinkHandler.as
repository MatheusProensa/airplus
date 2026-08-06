package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureRoomLinkHandler implements IRoomWidgetHandler
   {
      private static const INTERNAL_LINK_KEY:String = "internalLink";
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var _confirmDialog:UnknownICoreWindowUtils2;
      
      private var _communicationManagerMessageEvents:Vector.<IMessageEvent> = new Vector.<IMessageEvent>();
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var UnknownVarFromFurnitureRoomLinkHandler_Int_1:int = 0;
      
      private var UnknownVarFromFurnitureRoomLinkHandler_String_1:String;
      
      public function FurnitureRoomLinkHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_LINK";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set communicationManager(param1:IHabboCommunicationManager) : void
      {
         _communicationManager = param1;
         _communicationManagerMessageEvents.push(_communicationManager.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo)));
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var message:String;
         var roomName:String;
         var ownerName:String;
         var event:IMessageEvent = param1;
         var p:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(event).getParser();
         var roomData:GuestRoomData = p.data;
         if(roomData && roomData.flatId == UnknownVarFromFurnitureRoomLinkHandler_Int_1)
         {
            UnknownVarFromFurnitureRoomLinkHandler_Int_1 = 0;
            message = "${room.link.confirmation.message}";
            roomName = roomData.roomName;
            ownerName = roomData.ownerName;
            message = _container.localization.getLocalization("room.link.confirmation.message");
            if(message != null && message.indexOf("%%room_name%%") > -1)
            {
               message = message.replace("%%room_name%%",roomName);
            }
            if(message != null && message.indexOf("%%room_owner%%") > -1)
            {
               message = message.replace("%%room_owner%%",ownerName);
            }
            _confirmDialog = _container.windowManager.confirm("${room.link.confirmation.title}",message,0x10 | 0x20,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               if(_container.roomEngine != null && param2.type == "WE_OK")
               {
                  if(UnknownVarFromFurnitureRoomLinkHandler_String_1 != null && UnknownVarFromFurnitureRoomLinkHandler_String_1.length > 0)
                  {
                     (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/" + UnknownVarFromFurnitureRoomLinkHandler_String_1);
                  }
               }
               param1.dispose();
            });
         }
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
         return ["RETWE_REQUEST_ROOM_LINK"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc5_:RoomEngineToWidgetEvent = null;
         var _loc2_:IRoomObject = null;
         var _loc4_:IRoomObjectModel = null;
         var _loc3_:String = null;
         var _loc6_:* = param1.type;
         if("RETWE_REQUEST_ROOM_LINK" === _loc6_)
         {
            _loc5_ = param1 as RoomEngineToWidgetEvent;
            if(param1 != null && _container.roomEngine != null)
            {
               _loc2_ = _container.roomEngine.getRoomObject(_loc5_.roomId,_loc5_.objectId,_loc5_.category);
               if(_loc2_ != null)
               {
                  _loc4_ = _loc2_.getModel();
                  _loc3_ = _loc4_.getStringToStringMap("furniture_data").getValue("internalLink");
                  if(_loc3_ == null || _loc3_.length == 0)
                  {
                     _loc3_ = _loc4_.getString("furniture_internal_link");
                  }
                  if(_loc3_ != null)
                  {
                     if(_container.navigator != null && _container.localization != null)
                     {
                        if(_confirmDialog != null)
                        {
                           _confirmDialog.dispose();
                           _confirmDialog = null;
                        }
                        UnknownVarFromFurnitureRoomLinkHandler_String_1 = _loc3_;
                        UnknownVarFromFurnitureRoomLinkHandler_Int_1 = parseInt(_loc3_,10);
                        _communicationManager.connection.send(new GetGuestRoomMessageComposer(UnknownVarFromFurnitureRoomLinkHandler_Int_1,false,false));
                     }
                     else
                     {
                        (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/" + _loc3_);
                     }
                  }
               }
            }
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(_communicationManager)
         {
            for each(var _loc1_ in _communicationManagerMessageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
            _communicationManagerMessageEvents = null;
            _communicationManager = null;
         }
         if(_confirmDialog != null)
         {
            _confirmDialog.dispose();
            _confirmDialog = null;
         }
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
   }
}

