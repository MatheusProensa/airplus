package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class CameraFxStrengthSlider
   {
      private var UnknownVarFromCameraFxStrengthSlider_CameraPhotoLab_1:CameraPhotoLab;
      
      private var UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromCameraFxStrengthSlider_BitmapData_1:BitmapData;
      
      private var UnknownVarFromCameraFxStrengthSlider_BitmapData_2:BitmapData;
      
      private var _activeBaseArea:IBitmapWrapperController;
      
      private var _sliderBaseWidth:int;
      
      private var _referenceWidth:int;
      
      private var UnknownVarFromCameraFxStrengthSlider_Int_1:int = 0;
      
      public function CameraFxStrengthSlider(param1:CameraPhotoLab, param2:IWindowController_1, param3:IAssetLibraryCollection)
      {
         super();
         UnknownVarFromCameraFxStrengthSlider_CameraPhotoLab_1 = param1;
         UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1 = param2;
         storeAssets(param3);
         displaySlider();
      }
      
      public function dispose() : void
      {
         UnknownVarFromCameraFxStrengthSlider_CameraPhotoLab_1 = null;
         UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1 = null;
         UnknownVarFromCameraFxStrengthSlider_BitmapData_1 = null;
         UnknownVarFromCameraFxStrengthSlider_BitmapData_2 = null;
      }
      
      public function disable() : void
      {
         UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1.visible = false;
      }
      
      public function enable() : void
      {
         UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1.visible = true;
      }
      
      public function getScale() : int
      {
         return _referenceWidth;
      }
      
      public function setValue(param1:int) : void
      {
         var _loc2_:IWindowModel = null;
         if(UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1 != null)
         {
            _loc2_ = UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1.findChildByName("slider_button");
            if(_loc2_ != null)
            {
               _loc2_.x = param1;
            }
         }
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_RELOCATED")
         {
            if(_activeBaseArea)
            {
               _activeBaseArea.width = param2.x / _referenceWidth * _sliderBaseWidth;
            }
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            UnknownVarFromCameraFxStrengthSlider_CameraPhotoLab_1.setSelectedFxValue(param2.x);
         }
      }
      
      private function shaftProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_DOWN" && param2.name == "shaft_click_area")
         {
            _loc3_ = WindowMouseEvent(param1).localX - UnknownVarFromCameraFxStrengthSlider_Int_1;
            setValue(_loc3_);
            UnknownVarFromCameraFxStrengthSlider_CameraPhotoLab_1.setSelectedFxValue(_loc3_);
         }
      }
      
      private function displaySlider() : void
      {
         var _loc3_:IWindowController_1 = null;
         var _loc2_:IBitmapWrapperController = null;
         if(UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc1_:IRegionWindow = UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1.findChildByName("shaft_click_area") as IRegionWindow;
         if(_loc1_)
         {
            _loc1_.procedure = shaftProcedure;
         }
         _loc2_ = UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1.findChildByName("slider_base") as IBitmapWrapperController;
         if(_loc2_ != null && UnknownVarFromCameraFxStrengthSlider_BitmapData_1 != null)
         {
            _sliderBaseWidth = _loc2_.width;
            _loc2_.bitmap = new BitmapData(UnknownVarFromCameraFxStrengthSlider_BitmapData_1.width,UnknownVarFromCameraFxStrengthSlider_BitmapData_1.height,true,16777215);
            _loc2_.bitmap.copyPixels(UnknownVarFromCameraFxStrengthSlider_BitmapData_1,UnknownVarFromCameraFxStrengthSlider_BitmapData_1.rect,new Point(0,0),null,null,true);
            _activeBaseArea = _loc2_;
         }
         _loc3_ = UnknownVarFromCameraFxStrengthSlider_IWindowController_1_1.findChildByName("slider_movement_area") as IWindowController_1;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.findChildByName("slider_button") as IBitmapWrapperController;
            if(_loc2_ != null && UnknownVarFromCameraFxStrengthSlider_BitmapData_2 != null)
            {
               _loc2_.bitmap = new BitmapData(UnknownVarFromCameraFxStrengthSlider_BitmapData_2.width,UnknownVarFromCameraFxStrengthSlider_BitmapData_2.height,true,16777215);
               _loc2_.bitmap.copyPixels(UnknownVarFromCameraFxStrengthSlider_BitmapData_2,UnknownVarFromCameraFxStrengthSlider_BitmapData_2.rect,new Point(0,0),null,null,true);
               _loc2_.procedure = buttonProcedure;
               _referenceWidth = _loc3_.width - _loc2_.width;
               UnknownVarFromCameraFxStrengthSlider_Int_1 = (_sliderBaseWidth - _referenceWidth) / 2;
            }
         }
      }
      
      private function storeAssets(param1:IAssetLibraryCollection) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = BitmapDataAsset(param1.getAssetByName("camera_fx_slider_bottom_active"));
         UnknownVarFromCameraFxStrengthSlider_BitmapData_1 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("camera_fx_slider_button"));
         UnknownVarFromCameraFxStrengthSlider_BitmapData_2 = BitmapData(_loc2_.content);
      }
   }
}

