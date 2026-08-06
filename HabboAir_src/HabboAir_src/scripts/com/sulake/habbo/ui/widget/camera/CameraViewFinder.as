package com.sulake.habbo.ui.widget.camera
{
   import adobe.serialization.json.JSON;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
   import com.sulake.habbo.tracking.HabboTracking;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class CameraViewFinder implements IProfiler_1
   {
      private static const UnknownConstFromCameraViewFinder_Number_1:Number = 350;
      
      private static const NUMBER_OF_SLOTS:int = 5;
      
      private static var UnknownVarFromCameraViewFinder_Boolean_1:Boolean = false;
      
      private static var _shotImages:Vector.<CameraSlotData> = new Vector.<CameraSlotData>(5);
      
      private static var _renderRoomMessages:Vector.<RenderRoomMessageComposer> = new Vector.<RenderRoomMessageComposer>(5);
      
      private var UnknownVarFromCameraViewFinder_CameraWidget_1:CameraWidget;
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromCameraViewFinder_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _flash:IBitmapWrapperController;
      
      private var _imageWidth:int;
      
      private var UnknownVarFromCameraViewFinder_Int_1:int;
      
      private var _previewImageMode:Boolean = false;
      
      private var UnknownVarFromCameraViewFinder_Int_2:int = 0;
      
      private var _isLoadingFromCache:Boolean = false;
      
      private var _imageLoader:Loader;
      
      private var _flashStartTime:uint = 0;
      
      public function CameraViewFinder(param1:CameraWidget)
      {
         var _loc2_:IWindowModel = null;
         super();
         UnknownVarFromCameraViewFinder_CameraWidget_1 = param1;
         openViewFinder();
         UnknownVarFromCameraViewFinder_Int_2 = 0;
         while(UnknownVarFromCameraViewFinder_Int_2 < 5)
         {
            clearCurrentSlot(true);
            UnknownVarFromCameraViewFinder_Int_2++;
         }
         UnknownVarFromCameraViewFinder_Int_2 = 0;
         var _loc3_:Boolean = getFromMemoryCache();
         if(_loc3_)
         {
            _loc2_ = _window.findChildByName("slot_container");
            _loc2_.visible = true;
         }
         setMode(false);
         setActiveSlot(0);
         _flash = _window.findChildByName("flash") as IBitmapWrapperController;
         _flash.bitmap = new BitmapData(_flash.width,_flash.height,false,16777215);
         _flash.visible = false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _flash = null;
         UnknownVarFromCameraViewFinder_IBitmapWrapperController_1 = null;
         UnknownVarFromCameraViewFinder_CameraWidget_1.component.removeUpdateReceiver(this);
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function openViewFinder() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = UnknownVarFromCameraViewFinder_CameraWidget_1.getXmlWindow("camera_interface") as IWindowController_1;
         _window.center();
         _window.visible = false;
         UnknownVarFromCameraViewFinder_IBitmapWrapperController_1 = _window.findChildByName("image") as IBitmapWrapperController;
         _imageWidth = UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.width;
         UnknownVarFromCameraViewFinder_Int_1 = UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.height;
         UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.visible = true;
         _window.procedure = windowProcedure;
      }
      
      public function update(param1:uint) : void
      {
         if(_previewImageMode)
         {
            return;
         }
         if(UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap == null)
         {
            UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap = new BitmapData(_imageWidth,UnknownVarFromCameraViewFinder_Int_1,false,0);
         }
         UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap.rect,UnknownVarFromCameraViewFinder_CameraWidget_1.handler.roomDesktop.roomBackgroundColor);
         var _loc3_:Matrix = new Matrix();
         var _loc2_:Rectangle = getViewPort();
         _loc3_.translate(-_loc2_.x,-_loc2_.y);
         UnknownVarFromCameraViewFinder_CameraWidget_1.snapShotRoomCanvas(UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap,_loc3_,false);
         UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.invalidate();
         if(_flashStartTime > 0)
         {
            updateFlash();
         }
      }
      
      private function updateFlash() : void
      {
         _flash.visible = true;
         var _loc2_:Number = getTimer() - _flashStartTime;
         var _loc1_:Number = (350 - _loc2_) / 350;
         _flash.blend = _loc1_;
         if(_loc2_ > 350)
         {
            _flashStartTime = 0;
            _flash.visible = false;
         }
      }
      
      public function getViewPort() : Rectangle
      {
         var _loc1_:IWindowModel = _window as IWindowModel;
         return new Rectangle(_window.x + UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.x,_window.y + UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.y,UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.width,UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.height);
      }
      
      public function toggleVisible(param1:String) : void
      {
         if(_window.visible)
         {
            hide();
         }
         else
         {
            HabboTracking.getInstance().trackEventLog("Stories","camera","stories.camera.opened",param1);
            show();
            setMode(false);
         }
      }
      
      public function show() : void
      {
         _window.visible = true;
         _window.center();
         UnknownVarFromCameraViewFinder_CameraWidget_1.component.registerUpdateReceiver(this,100);
      }
      
      public function hide() : void
      {
         _window.visible = false;
         UnknownVarFromCameraViewFinder_CameraWidget_1.component.removeUpdateReceiver(this);
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc5_:IStaticBitmapWrapperWindow = null;
         var _loc4_:RenderRoomMessageComposer = null;
         var _loc3_:IWindowModel = null;
         var _loc6_:String = null;
         var _loc7_:CameraSlotData = null;
         var _loc8_:int = 0;
         if(param2.name == "button_release")
         {
            _loc5_ = IStaticBitmapWrapperWindow(_window.findChildByName("release_bitmap"));
            switch(param1.type)
            {
               case "WME_DOWN":
                  _loc5_.assetUri = "camera_camera_btn_down";
                  break;
               case "WME_UP":
                  _loc5_.assetUri = "camera_cam_btn_hi";
                  break;
               case "WME_OVER":
                  _loc5_.assetUri = "camera_cam_btn_hi";
                  break;
               case "WME_OUT":
                  _loc5_.assetUri = "camera_camera_btn";
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
               hide();
               break;
            case "button_editor":
               hide();
               UnknownVarFromCameraViewFinder_CameraWidget_1.editPhoto(UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap.clone());
               break;
            case "delete_photo_button":
               clearCurrentSlot();
               setMode(false);
               break;
            case "header_button_help":
               UnknownVarFromCameraViewFinder_CameraWidget_1.component.context.createLinkEvent("habbopages/camera");
               break;
            case "button_release":
               if(_previewImageMode)
               {
                  setMode(false);
               }
               else
               {
                  UnknownVarFromCameraViewFinder_CameraWidget_1.triggetCameraShutterSound();
                  _loc4_ = UnknownVarFromCameraViewFinder_CameraWidget_1.handler.collectPhotoData();
                  if(_loc4_ != null && _loc4_.isSendable())
                  {
                     _renderRoomMessages[UnknownVarFromCameraViewFinder_Int_2] = _loc4_;
                     addToCurrentSlot(UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap.clone());
                     _flashStartTime = getTimer();
                     HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.taken");
                     _loc3_ = _window.findChildByName("slot_container");
                     _loc3_.visible = true;
                  }
                  else
                  {
                     UnknownVarFromCameraViewFinder_CameraWidget_1.windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
                  }
               }
         }
         if(param1.target.name.indexOf("cameraButton_") != -1)
         {
            _loc6_ = param1.target.name.charAt(param1.target.name.length - 1);
            if(_shotImages[int(_loc6_)].isEmpty)
            {
               setActiveSlot(int(_loc6_));
               setMode(false);
               return;
            }
            _loc7_ = _shotImages[int(_loc6_)];
            UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap = _loc7_.image.clone();
            setMode(true);
            setActiveSlot(int(_loc6_));
         }
         if(param1.target.name.indexOf("chooseSlotButton_") != -1)
         {
            _loc8_ = int(param1.target.name.charAt(param1.target.name.length - 1));
            if(_shotImages.length < _loc8_)
            {
               return;
            }
            setActiveSlot(_loc8_);
            setMode(false);
         }
      }
      
      private function setActiveSlot(param1:int) : void
      {
         (_window.findChildByName("slotImage_" + UnknownVarFromCameraViewFinder_Int_2) as IStaticBitmapWrapperWindow).assetUri = "camera_arrow_gray";
         UnknownVarFromCameraViewFinder_Int_2 = param1;
         (_window.findChildByName("slotImage_" + UnknownVarFromCameraViewFinder_Int_2) as IStaticBitmapWrapperWindow).assetUri = "camera_arrow_green";
         var _loc2_:IWindowModel = _window.findChildByName("photo_border");
         var _loc4_:IWindowModel = _window.findChildByName("cameraButton_" + UnknownVarFromCameraViewFinder_Int_2);
         _loc2_.x = _loc4_.x - 1 + _loc4_.parent.x;
         _loc2_.y = _loc4_.y - 3 + _loc4_.parent.y;
         _loc2_.visible = true;
         var _loc3_:IWindowModel = _window.findChildByName("delete_photo_button");
         _loc3_.y = _loc2_.y;
         _loc3_.x = _loc2_.right - _loc3_.width;
      }
      
      private function setMode(param1:Boolean) : void
      {
         _previewImageMode = param1;
         var _loc3_:IWindowModel = _window.findChildByName("button_editor");
         var _loc5_:IWindowModel = _window.findChildByName("camera_crosshair");
         var _loc2_:IWindowModel = _window.findChildByName("photo_date");
         var _loc7_:IWindowModel = _window.findChildByName("photo_roomname");
         var _loc6_:IWindowModel = _window.findChildByName("buyButtonBg");
         _loc2_.visible = _loc7_.visible = false;
         var _loc4_:IWindowModel = _window.findChildByName("delete_photo_button");
         _loc5_.visible = !param1;
         _loc4_.visible = _loc3_.visible = _loc6_.visible = param1;
      }
      
      private function onPurchaseError(param1:Event) : void
      {
         var _loc2_:Object = null;
         try
         {
            _loc2_ = adobe.serialization.json.JSON.decode(URLLoader(param1.target).data);
            switch(_loc2_.error.code)
            {
               case "PURCHASING_FAILED":
                  UnknownVarFromCameraViewFinder_CameraWidget_1.windowManager.alert("Something went wrong","sorry, purhcase failed. We will investigate the issue. #code 1",0,null);
                  break;
               case "MODERATED":
                  UnknownVarFromCameraViewFinder_CameraWidget_1.windowManager.alert("Inappropriate text","Your photo caption contained inappropriate words. They were changed to bobba. Please edit the text and try again.",0,null);
                  UnknownVarFromCameraViewFinder_CameraWidget_1.changeCaptionFieldText(_loc2_.error.message,true);
            }
         }
         catch(error:Error)
         {
            UnknownVarFromCameraViewFinder_CameraWidget_1.windowManager.alert("Something went wrong","sorry, purhcase failed. We will investigate the issue. # code 2",0,null);
         }
      }
      
      private function getFromMemoryCache() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _shotImages.length)
         {
            if(_shotImages[_loc2_].isEmpty == false)
            {
               drawImageToSlot(_loc2_,_shotImages[_loc2_]);
               _loc1_ = true;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function drawImageToSlot(param1:int, param2:CameraSlotData) : void
      {
         var _loc4_:IBitmapWrapperController = _window.findChildByName("cameraSlot_" + param1) as IBitmapWrapperController;
         _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height,false,0);
         var _loc3_:Number = (_loc4_.width - 2) / _imageWidth;
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(_loc3_,_loc3_);
         _loc5_.tx = _loc5_.ty = 1;
         _loc4_.bitmap.draw(param2.image,_loc5_,null,null,null,true);
      }
      
      private function getFromLocalCache() : Boolean
      {
         var _loc2_:SharedObject = null;
         try
         {
            _loc2_ = SharedObject.getLocal("camera_image_" + UnknownVarFromCameraViewFinder_Int_2);
         }
         catch(error:Error)
         {
            return false;
         }
         if(_loc2_.size == 0 || !_loc2_.data)
         {
            return false;
         }
         var _loc1_:ByteArray = _loc2_.data.photo as ByteArray;
         if(!_loc1_)
         {
            return false;
         }
         if(!_imageLoader)
         {
            _imageLoader = new Loader();
         }
         _imageLoader.loadBytes(_loc1_);
         _imageLoader.contentLoaderInfo.addEventListener("complete",onImageLoadedFromCache);
         var _loc3_:CameraSlotData = new CameraSlotData();
         _loc3_.setDate(new Date());
         if(int(_loc2_.data.date) > 0)
         {
            _loc3_.setDate(new Date(int(_loc2_.data.date)));
         }
         _shotImages[UnknownVarFromCameraViewFinder_Int_2] = _loc3_;
         return true;
      }
      
      private function onImageLoadedFromCache(param1:Event) : void
      {
         var _loc2_:BitmapData = new BitmapData(_imageLoader.width,_imageLoader.height,false);
         _loc2_.draw(_imageLoader);
         _shotImages[UnknownVarFromCameraViewFinder_Int_2].image = _loc2_.clone();
         addToCurrentSlot(_loc2_,false,true);
         if(UnknownVarFromCameraViewFinder_Int_2 < 5 && _isLoadingFromCache)
         {
            getFromLocalCache();
            if(UnknownVarFromCameraViewFinder_Int_2 == 5 - 1)
            {
               _isLoadingFromCache = false;
            }
         }
         else
         {
            UnknownVarFromCameraViewFinder_Boolean_1 = true;
         }
      }
      
      private function findNextEmptySlotIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _shotImages.length)
         {
            if(_shotImages[_loc1_].isEmpty)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function clearCurrentSlot(param1:Boolean = false) : void
      {
         if(param1 && _shotImages[UnknownVarFromCameraViewFinder_Int_2] && !_shotImages[UnknownVarFromCameraViewFinder_Int_2].isEmpty)
         {
            return;
         }
         _shotImages[UnknownVarFromCameraViewFinder_Int_2] = null;
         addToCurrentSlot(new BitmapData(320,320,false,13816530),true);
         UnknownVarFromCameraViewFinder_IBitmapWrapperController_1.bitmap = _shotImages[UnknownVarFromCameraViewFinder_Int_2].image.clone();
         setMode(false);
      }
      
      private function addToCurrentSlot(param1:BitmapData, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:CameraSlotData = new CameraSlotData();
         _loc4_.image = param1;
         if(param2)
         {
            _loc4_.isEmpty = true;
         }
         else
         {
            _loc4_.setDate(new Date());
            _loc4_.isEmpty = false;
         }
         if(!param3 && !param2 || _shotImages[UnknownVarFromCameraViewFinder_Int_2] == null)
         {
            _shotImages[UnknownVarFromCameraViewFinder_Int_2] = _loc4_;
         }
         drawImageToSlot(UnknownVarFromCameraViewFinder_Int_2,_loc4_);
         if(!param2)
         {
            _loc5_ = findNextEmptySlotIndex();
            if(_loc5_ >= 0)
            {
               setActiveSlot(_loc5_);
            }
            else if(!UnknownVarFromCameraViewFinder_Boolean_1 && !param3)
            {
               UnknownVarFromCameraViewFinder_CameraWidget_1.windowManager.alert(UnknownVarFromCameraViewFinder_CameraWidget_1.localizations.getLocalization("camera.full.header"),UnknownVarFromCameraViewFinder_CameraWidget_1.localizations.getLocalization("camera.full.body"),0,null);
               UnknownVarFromCameraViewFinder_Boolean_1 = true;
            }
         }
      }
      
      public function getRenderRoomMessage() : RenderRoomMessageComposer
      {
         return _renderRoomMessages[UnknownVarFromCameraViewFinder_Int_2];
      }
   }
}

