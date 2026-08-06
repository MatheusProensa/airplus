package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.quest.IHabboQuestEngine;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.CameraWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class CameraWidget extends RoomWidgetBase
   {
      private var _component:RoomUI;
      
      private var UnknownVarFromCameraWidget_CameraViewFinder_1:CameraViewFinder;
      
      private var UnknownVarFromCameraWidget_CameraPhotoLab_1:CameraPhotoLab;
      
      public var url:String;
      
      public function CameraWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IComponent_1, param5:IHabboLocalizationManager, param6:RoomUI)
      {
         super(param1,param2,param3,param5);
         _component = param6;
         this.handler.widget = this;
         UnknownVarFromCameraWidget_CameraViewFinder_1 = new CameraViewFinder(this);
         if(roomEngine)
         {
            roomEngine.events.addEventListener("REE_DISPOSED",onRoomDisposed);
            roomEngine.events.addEventListener("REE_ROOM_ZOOMED",onRoomZoomed);
         }
         this.handler.sendInitCameraMessage();
         var _loc7_:IHabboQuestEngine = this.handler.roomDesktop.questEngine;
         if(_loc7_ != null)
         {
            _loc7_.ensureAchievementsInitialized();
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _component.catalog;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromCameraWidget_CameraViewFinder_1)
         {
            UnknownVarFromCameraWidget_CameraViewFinder_1.dispose();
            UnknownVarFromCameraWidget_CameraViewFinder_1 = null;
         }
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.dispose();
            UnknownVarFromCameraWidget_CameraPhotoLab_1 = null;
         }
         super.dispose();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return !!handler ? handler.container : null;
      }
      
      public function get handler() : CameraWidgetHandler
      {
         return _widgetHandler as CameraWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return !!container ? container.roomEngine : null;
      }
      
      public function startTakingPhoto(param1:String) : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            windowManager.alert(_localizations.getLocalization("camera.zoom.missing.header"),_localizations.getLocalization("camera.zoom.missing.body"),0,null);
            return;
         }
         if(component.getProperty("camera.effects.enabled") == "true")
         {
            CameraPhotoLab.preloadEffects(_component.context.configuration.getProperty("image.library.url"),_component.getProperty("camera.available.effects"),_localizations);
         }
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.dispose();
         }
         UnknownVarFromCameraWidget_CameraViewFinder_1.toggleVisible(param1);
      }
      
      public function get component() : RoomUI
      {
         return _component;
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : IWindowModel
      {
         var _loc5_:ISoundAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:IWindowModel = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      private function onRoomDisposed(param1:RoomEngineEvent) : void
      {
         hide();
      }
      
      private function onRoomZoomed(param1:RoomEngineEvent) : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            hide();
         }
      }
      
      private function hide() : void
      {
         if(UnknownVarFromCameraWidget_CameraViewFinder_1)
         {
            UnknownVarFromCameraWidget_CameraViewFinder_1.hide();
         }
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.dispose();
         }
      }
      
      public function snapShotRoomCanvas(param1:BitmapData, param2:Matrix, param3:Boolean) : Boolean
      {
         var _loc4_:IRoomSession = container.roomSession;
         return roomEngine.snapshotRoomCanvasToBitmap(_loc4_.roomId,container.getFirstCanvasId(),param1,param2,param3);
      }
      
      public function triggetCameraShutterSound() : void
      {
         container.soundManager.playSound("CAMERA_shutter");
      }
      
      public function editPhoto(param1:BitmapData) : void
      {
         UnknownVarFromCameraWidget_CameraPhotoLab_1 = new CameraPhotoLab(this);
         UnknownVarFromCameraWidget_CameraPhotoLab_1.openPhotoLab(param1);
      }
      
      public function changeCaptionFieldText(param1:String, param2:Boolean = false) : void
      {
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.setCaptionText(param1);
            if(param2)
            {
               UnknownVarFromCameraWidget_CameraPhotoLab_1.show();
               UnknownVarFromCameraWidget_CameraPhotoLab_1.closePurchaseConfirmation();
            }
         }
      }
      
      public function getViewPort() : Rectangle
      {
         if(UnknownVarFromCameraWidget_CameraViewFinder_1)
         {
            return UnknownVarFromCameraWidget_CameraViewFinder_1.getViewPort();
         }
         return new Rectangle(0,0,0,0);
      }
      
      public function purchaseSuccessful() : void
      {
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.animateSuccessfulPurchase();
         }
      }
      
      public function setRenderedPhotoUrl(param1:String) : void
      {
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.setRenderedPhotoUrl(param1);
         }
      }
      
      public function publishingStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.publishingStatus(param1);
         }
      }
      
      public function competitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            UnknownVarFromCameraWidget_CameraPhotoLab_1.competitionStatus(param1);
         }
      }
      
      public function sendPhotoData() : Boolean
      {
         var _loc1_:RenderRoomMessageComposer = UnknownVarFromCameraWidget_CameraViewFinder_1.getRenderRoomMessage();
         if(UnknownVarFromCameraWidget_CameraPhotoLab_1)
         {
            _loc1_.addEffectData(UnknownVarFromCameraWidget_CameraPhotoLab_1.getEffectDataJson());
            _loc1_.setZoom(UnknownVarFromCameraWidget_CameraPhotoLab_1.getZoom());
         }
         _loc1_.compressData();
         if(_loc1_.isSendable())
         {
            handler.sendPhotoData(_loc1_);
            return true;
         }
         return false;
      }
      
      override public function release() : void
      {
         super.release();
         (_widgetHandler as CameraWidgetHandler).roomDesktop = null;
      }
      
      override public function reuse(param1:IRoomDesktop) : void
      {
         super.reuse(param1);
         (_widgetHandler as CameraWidgetHandler).roomDesktop = param1 as RoomDesktop;
      }
   }
}

