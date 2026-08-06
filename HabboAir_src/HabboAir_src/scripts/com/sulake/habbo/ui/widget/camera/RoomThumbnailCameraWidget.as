package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.RoomThumbnailCameraWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomThumbnailCameraWidget extends RoomWidgetBase implements IProfiler_1, ILinkEventTracker
   {
      private var UnknownVarFromRoomThumbnailCameraWidget_RoomUI_1:RoomUI;
      
      private var _window:IFrameController = null;
      
      private var UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1:IBitmapWrapperController;
      
      public function RoomThumbnailCameraWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IComponent_1, param5:IHabboLocalizationManager, param6:RoomUI)
      {
         super(param1,param2,param3,param5);
         UnknownVarFromRoomThumbnailCameraWidget_RoomUI_1 = param6;
         this.handler.widget = this;
         if(roomEngine)
         {
            roomEngine.events.addEventListener("REE_DISPOSED",onRoomDisposed);
            roomEngine.events.addEventListener("REE_ROOM_ZOOMED",onRoomZoomed);
         }
         (param2 as Component).context.addLinkEventTracker(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         (windowManager as Component).context.removeLinkEventTracker(this);
         super.dispose();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return !!handler ? handler.container : null;
      }
      
      public function get handler() : RoomThumbnailCameraWidgetHandler
      {
         return _widgetHandler as RoomThumbnailCameraWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return !!container ? container.roomEngine : null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Matrix = null;
         var _loc4_:IRoomSession = null;
         if(_window && UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1)
         {
            if(UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.bitmap == null)
            {
               UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.width,UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.height,false,0);
            }
            UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.bitmap.rect,handler.roomDesktop.roomBackgroundColor);
            _loc2_ = new Point(0,0);
            UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.getGlobalPosition(_loc2_);
            _loc3_ = new Matrix();
            _loc3_.translate(-_loc2_.x,-_loc2_.y);
            _loc4_ = container.roomSession;
            roomEngine.snapshotRoomCanvasToBitmap(_loc4_.roomId,container.getFirstCanvasId(),UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.bitmap,_loc3_,false);
            UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.invalidate();
         }
      }
      
      public function startTakingPhoto() : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            windowManager.alert("Camera only works on normal zoom!","Return to normal zoom level and try again!",0,null);
            return;
         }
         if(!_window)
         {
            createWindow();
         }
      }
      
      private function createWindow() : void
      {
         if(_window)
         {
            destroy();
         }
         _window = IFrameController(windowManager.buildFromXML(XML(UnknownVarFromRoomThumbnailCameraWidget_RoomUI_1.assets.getAssetByName("iro_room_thumbnail_camera_xml").content)));
         UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1 = IBitmapWrapperController(_window.findChildByName("viewfinder"));
         _window.procedure = windowProcedure;
         _window.center();
         UnknownVarFromRoomThumbnailCameraWidget_RoomUI_1.registerUpdateReceiver(this,10);
      }
      
      public function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
            _window = null;
            UnknownVarFromRoomThumbnailCameraWidget_RoomUI_1.removeUpdateReceiver(this);
         }
      }
      
      public function get viewPort() : Rectangle
      {
         var _loc1_:Point = new Point(0,0);
         UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.getGlobalPosition(_loc1_);
         return new Rectangle(_loc1_.x,_loc1_.y,UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.width,UnknownVarFromRoomThumbnailCameraWidget_IBitmapWrapperController_1.height);
      }
      
      private function onRoomDisposed(param1:RoomEngineEvent) : void
      {
         destroy();
      }
      
      private function onRoomZoomed(param1:RoomEngineEvent) : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            destroy();
         }
      }
      
      public function triggerCameraShutterSound() : void
      {
         container.soundManager.playSound("CAMERA_shutter");
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:RenderRoomThumbnailMessageComposer = null;
         var _loc4_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc4_ && _loc4_.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_capture":
                  triggerCameraShutterSound();
                  _loc3_ = RoomThumbnailCameraWidgetHandler(handler).collectPhotoData();
                  if(_loc3_ != null && _loc3_.isSendable())
                  {
                     handler.sendPhotoData(_loc3_);
                     _window.findChildByName("button_capture").disable();
                     _window.findChildByName("button_cancel").disable();
                     UnknownVarFromRoomThumbnailCameraWidget_RoomUI_1.removeUpdateReceiver(this);
                  }
                  else
                  {
                     windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
                  }
                  return;
               case "header_button_close":
               case "button_cancel":
                  destroy();
            }
         }
      }
      
      public function get linkPattern() : String
      {
         return "roomThumbnailCamera";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         var _loc3_:int = int(_loc2_.length);
         if(_loc3_ < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            startTakingPhoto();
         }
      }
   }
}

