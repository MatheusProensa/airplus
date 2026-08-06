package com.sulake.habbo.ui.handler
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.camera.ThumbnailStatusMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.camera.RoomThumbnailCameraWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class RoomThumbnailCameraWidgetHandler implements IRoomWidgetHandler, IComponentInterfaceQueue
   {
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _roomDesktop:RoomDesktop;
      
      private var UnknownVarFromRoomThumbnailCameraWidgetHandler_RoomThumbnailCameraWidget_1:RoomThumbnailCameraWidget;
      
      private var UnknownVarFromRoomThumbnailCameraWidgetHandler_ThumbnailStatusMessageEvent_1:ThumbnailStatusMessageEvent;
      
      public function RoomThumbnailCameraWidgetHandler(param1:RoomDesktop)
      {
         super();
         _roomDesktop = param1;
      }
      
      public function get roomDesktop() : RoomDesktop
      {
         return _roomDesktop;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function set widget(param1:RoomThumbnailCameraWidget) : void
      {
         UnknownVarFromRoomThumbnailCameraWidgetHandler_RoomThumbnailCameraWidget_1 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         UnknownVarFromRoomThumbnailCameraWidgetHandler_ThumbnailStatusMessageEvent_1 = new ThumbnailStatusMessageEvent(onThumbnailStatus);
         _container.connection.addMessageEvent(UnknownVarFromRoomThumbnailCameraWidgetHandler_ThumbnailStatusMessageEvent_1);
      }
      
      public function dispose() : void
      {
         if(_container && _container.connection && UnknownVarFromRoomThumbnailCameraWidgetHandler_ThumbnailStatusMessageEvent_1)
         {
            _container.connection.removeMessageEvent(UnknownVarFromRoomThumbnailCameraWidgetHandler_ThumbnailStatusMessageEvent_1);
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_THUMBNAIL_CAMERA";
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function collectPhotoData() : RenderRoomThumbnailMessageComposer
      {
         return RenderRoomThumbnailMessageComposer(_roomDesktop.roomEngine.getRenderRoomMessage(UnknownVarFromRoomThumbnailCameraWidgetHandler_RoomThumbnailCameraWidget_1.viewPort,_roomDesktop.roomBackgroundColor,true));
      }
      
      public function sendPhotoData(param1:RenderRoomThumbnailMessageComposer) : void
      {
         _container.connection.send(param1);
      }
      
      private function onThumbnailStatus(param1:ThumbnailStatusMessageEvent) : void
      {
         UnknownVarFromRoomThumbnailCameraWidgetHandler_RoomThumbnailCameraWidget_1.destroy();
         if(param1.getParser().isOk())
         {
            _container.windowManager.alert("${navigator.thumbnail.camera.title}","${navigator.thumbnail.camera.success}",16,null);
         }
         else if(param1.getParser().isRenderLimitHit())
         {
            _container.windowManager.alert("${generic.alert.title}","${camera.render.count.info}",0,null);
         }
      }
   }
}

