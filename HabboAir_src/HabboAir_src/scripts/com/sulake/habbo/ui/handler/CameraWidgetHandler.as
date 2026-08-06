package com.sulake.habbo.ui.handler
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPurchaseOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraStorageUrlMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.InitCameraMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.camera.PhotoCompetitionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.PublishPhotoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.PurchasePhotoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.RequestCameraConfigurationMessageComposer;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.camera.CameraWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class CameraWidgetHandler implements IRoomWidgetHandler, ILinkEventTracker, IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromCameraWidgetHandler_Component_1:Component;
      
      private var UnknownVarFromCameraWidgetHandler_CameraWidget_1:CameraWidget;
      
      private var UnknownVarFromCameraWidgetHandler_CameraStorageUrlMessageEvent_1:CameraStorageUrlMessageEvent;
      
      private var UnknownVarFromCameraWidgetHandler_CameraPurchaseOKMessageEvent_1:CameraPurchaseOKMessageEvent;
      
      private var UnknownVarFromCameraWidgetHandler_CameraPublishStatusMessageEvent_1:CameraPublishStatusMessageEvent;
      
      private var UnknownVarFromCameraWidgetHandler_CompetitionStatusMessageEvent_1:CompetitionStatusMessageEvent;
      
      private var UnknownVarFromCameraWidgetHandler_InitCameraMessageEvent_1:InitCameraMessageEvent;
      
      private var _roomDesktop:RoomDesktop;
      
      private var _creditPrice:int = 999;
      
      private var _ducketPrice:int = 999;
      
      private var _publishDucketPrice:int = 999;
      
      public function CameraWidgetHandler(param1:RoomDesktop)
      {
         super();
         _roomDesktop = param1;
         UnknownVarFromCameraWidgetHandler_CameraStorageUrlMessageEvent_1 = new CameraStorageUrlMessageEvent(onCameraStorageUrlEvent);
         UnknownVarFromCameraWidgetHandler_CameraPurchaseOKMessageEvent_1 = new CameraPurchaseOKMessageEvent(onPurchaseOK);
         UnknownVarFromCameraWidgetHandler_CameraPublishStatusMessageEvent_1 = new CameraPublishStatusMessageEvent(onPublishStatus);
         UnknownVarFromCameraWidgetHandler_CompetitionStatusMessageEvent_1 = new CompetitionStatusMessageEvent(onCompetitionStatus);
         UnknownVarFromCameraWidgetHandler_InitCameraMessageEvent_1 = new InitCameraMessageEvent(onInitCameraEvent);
      }
      
      public function get creditPrice() : int
      {
         return _creditPrice;
      }
      
      public function get ducketPrice() : int
      {
         return _ducketPrice;
      }
      
      public function get publishDucketPrice() : int
      {
         return _publishDucketPrice;
      }
      
      public function get type() : String
      {
         return "RWE_CAMERA";
      }
      
      public function get roomDesktop() : RoomDesktop
      {
         return _roomDesktop;
      }
      
      public function set roomDesktop(param1:RoomDesktop) : void
      {
         _roomDesktop = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container && _container.toolbar)
         {
            _container.toolbar.events.removeEventListener("HTE_ICON_CAMERA",onCameraRequested);
         }
         unregisterLinkEventTracker();
         if(_container && _container.connection)
         {
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CameraStorageUrlMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CameraPurchaseOKMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CameraPublishStatusMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CompetitionStatusMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_InitCameraMessageEvent_1);
         }
         _container = param1;
         if(_container && _container.toolbar)
         {
            _container.toolbar.events.addEventListener("HTE_ICON_CAMERA",onCameraRequested);
         }
         registerLinkEventTracker();
         if(_container)
         {
            _container.connection.addMessageEvent(UnknownVarFromCameraWidgetHandler_CameraStorageUrlMessageEvent_1);
            _container.connection.addMessageEvent(UnknownVarFromCameraWidgetHandler_CameraPurchaseOKMessageEvent_1);
            _container.connection.addMessageEvent(UnknownVarFromCameraWidgetHandler_CameraPublishStatusMessageEvent_1);
            _container.connection.addMessageEvent(UnknownVarFromCameraWidgetHandler_CompetitionStatusMessageEvent_1);
            _container.connection.addMessageEvent(UnknownVarFromCameraWidgetHandler_InitCameraMessageEvent_1);
         }
      }
      
      public function sendInitCameraMessage() : void
      {
         if(_container.sessionDataManager.isPerkAllowed("CAMERA"))
         {
            _container.connection.send(new RequestCameraConfigurationMessageComposer());
         }
      }
      
      private function onInitCameraEvent(param1:InitCameraMessageEvent) : void
      {
         _creditPrice = param1.getParser().getCreditPrice();
         _ducketPrice = param1.getParser().getDucketPrice();
         _publishDucketPrice = param1.getParser().getPublishDucketPrice();
      }
      
      private function onPurchaseOK(param1:CameraPurchaseOKMessageEvent) : void
      {
         if(UnknownVarFromCameraWidgetHandler_CameraWidget_1)
         {
            UnknownVarFromCameraWidgetHandler_CameraWidget_1.purchaseSuccessful();
         }
      }
      
      private function onPublishStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         if(UnknownVarFromCameraWidgetHandler_CameraWidget_1)
         {
            UnknownVarFromCameraWidgetHandler_CameraWidget_1.publishingStatus(param1);
         }
      }
      
      private function onCompetitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         if(UnknownVarFromCameraWidgetHandler_CameraWidget_1)
         {
            UnknownVarFromCameraWidgetHandler_CameraWidget_1.competitionStatus(param1);
         }
      }
      
      private function onCameraStorageUrlEvent(param1:CameraStorageUrlMessageEvent) : void
      {
         if(!UnknownVarFromCameraWidgetHandler_CameraWidget_1)
         {
            return;
         }
         var _loc2_:String = param1.getParser().url;
         UnknownVarFromCameraWidgetHandler_CameraWidget_1.setRenderedPhotoUrl(_loc2_);
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
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(_container && container.connection)
         {
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CameraStorageUrlMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CameraPurchaseOKMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CameraPublishStatusMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_CompetitionStatusMessageEvent_1);
            _container.connection.removeMessageEvent(UnknownVarFromCameraWidgetHandler_InitCameraMessageEvent_1);
         }
         if(_container && _container.toolbar)
         {
            _container.toolbar.events.removeEventListener("HTE_ICON_CAMERA",onCameraRequested);
         }
         unregisterLinkEventTracker();
         _disposed = true;
         _container = null;
         _roomDesktop = null;
         UnknownVarFromCameraWidgetHandler_CameraWidget_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set widget(param1:CameraWidget) : void
      {
         UnknownVarFromCameraWidgetHandler_CameraWidget_1 = param1;
      }
      
      public function get linkPattern() : String
      {
         return "camera/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            openCamera("chatCameraCommand");
         }
      }
      
      private function registerLinkEventTracker() : void
      {
         if(_container == null || _container.windowManager == null)
         {
            return;
         }
         UnknownVarFromCameraWidgetHandler_Component_1 = _container.windowManager as Component;
         if(UnknownVarFromCameraWidgetHandler_Component_1 != null)
         {
            UnknownVarFromCameraWidgetHandler_Component_1.context.addLinkEventTracker(this);
         }
      }
      
      private function unregisterLinkEventTracker() : void
      {
         if(UnknownVarFromCameraWidgetHandler_Component_1 == null)
         {
            return;
         }
         UnknownVarFromCameraWidgetHandler_Component_1.context.removeLinkEventTracker(this);
         UnknownVarFromCameraWidgetHandler_Component_1 = null;
      }
      
      private function openCamera(param1:String) : void
      {
         if(_container == null || _container.toolbar == null || !_container.sessionDataManager.isPerkAllowed("CAMERA"))
         {
            return;
         }
         var _loc2_:HabboToolbarEvent = new HabboToolbarEvent("HTE_ICON_CAMERA");
         _loc2_.iconName = param1;
         _container.toolbar.events.dispatchEvent(_loc2_);
      }
      
      private function onCameraRequested(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_ICON_CAMERA")
         {
            if(UnknownVarFromCameraWidgetHandler_CameraWidget_1)
            {
               UnknownVarFromCameraWidgetHandler_CameraWidget_1.startTakingPhoto(param1.iconName);
            }
         }
      }
      
      public function confirmPhotoPurchase() : void
      {
         _container.connection.send(new PurchasePhotoMessageComposer());
      }
      
      public function confirmPhotoPublish() : void
      {
         _container.connection.send(new PublishPhotoMessageComposer());
      }
      
      public function confirmPhotoCompetitionSubmit() : void
      {
         _container.connection.send(new PhotoCompetitionMessageComposer());
      }
      
      public function collectPhotoData() : RenderRoomMessageComposer
      {
         if(_roomDesktop == null)
         {
            return null;
         }
         return _roomDesktop.roomEngine.getRenderRoomMessage(UnknownVarFromCameraWidgetHandler_CameraWidget_1.getViewPort(),_roomDesktop.roomBackgroundColor) as RenderRoomMessageComposer;
      }
      
      public function sendPhotoData(param1:RenderRoomMessageComposer) : void
      {
         _container.connection.send(param1);
      }
   }
}

