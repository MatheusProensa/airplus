package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class DimmerViewAlphaSlider
   {
      private var UnknownVarFromDimmerViewAlphaSlider_DimmerView_1:DimmerView;
      
      private var UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromDimmerViewAlphaSlider_BitmapData_1:BitmapData;
      
      private var UnknownVarFromDimmerViewAlphaSlider_BitmapData_2:BitmapData;
      
      private var _referenceWidth:int;
      
      private var UnknownVarFromDimmerViewAlphaSlider_Int_1:int;
      
      private var UnknownVarFromDimmerViewAlphaSlider_Int_2:int = 0;
      
      private var UnknownVarFromDimmerViewAlphaSlider_Int_3:int = 255;
      
      public function DimmerViewAlphaSlider(param1:DimmerView, param2:IWindowController_1, param3:IAssetLibraryCollection, param4:int = 0, param5:int = 255)
      {
         super();
         UnknownVarFromDimmerViewAlphaSlider_DimmerView_1 = param1;
         UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1 = param2;
         UnknownVarFromDimmerViewAlphaSlider_Int_2 = param4;
         UnknownVarFromDimmerViewAlphaSlider_Int_3 = param5;
         storeAssets(param3);
         displaySlider();
      }
      
      public function dispose() : void
      {
         UnknownVarFromDimmerViewAlphaSlider_DimmerView_1 = null;
         UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1 = null;
         UnknownVarFromDimmerViewAlphaSlider_BitmapData_1 = null;
         UnknownVarFromDimmerViewAlphaSlider_BitmapData_2 = null;
      }
      
      public function setValue(param1:int) : void
      {
         if(UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc2_:IWindowModel = UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1.findChildByName("slider_button");
         if(_loc2_ != null)
         {
            _loc2_.x = getSliderPosition(param1);
         }
      }
      
      public function set min(param1:Number) : void
      {
         UnknownVarFromDimmerViewAlphaSlider_Int_2 = param1;
         setValue(UnknownVarFromDimmerViewAlphaSlider_DimmerView_1.selectedBrightness);
      }
      
      public function set max(param1:Number) : void
      {
         UnknownVarFromDimmerViewAlphaSlider_Int_3 = param1;
         setValue(UnknownVarFromDimmerViewAlphaSlider_DimmerView_1.selectedBrightness);
      }
      
      private function getSliderPosition(param1:int) : int
      {
         return int(_referenceWidth * ((param1 - UnknownVarFromDimmerViewAlphaSlider_Int_2) / (UnknownVarFromDimmerViewAlphaSlider_Int_3 - UnknownVarFromDimmerViewAlphaSlider_Int_2)));
      }
      
      private function getValue(param1:Number) : int
      {
         return int(param1 / _referenceWidth * (UnknownVarFromDimmerViewAlphaSlider_Int_3 - UnknownVarFromDimmerViewAlphaSlider_Int_2)) + UnknownVarFromDimmerViewAlphaSlider_Int_2;
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE")
         {
            return;
         }
         UnknownVarFromDimmerViewAlphaSlider_DimmerView_1.selectedBrightness = getValue(param2.x);
      }
      
      private function displaySlider() : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc1_:IBitmapWrapperController = null;
         if(UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1 == null)
         {
            return;
         }
         _loc1_ = UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1.findChildByName("slider_base") as IBitmapWrapperController;
         if(_loc1_ != null && UnknownVarFromDimmerViewAlphaSlider_BitmapData_1 != null)
         {
            _loc1_.bitmap = new BitmapData(UnknownVarFromDimmerViewAlphaSlider_BitmapData_1.width,UnknownVarFromDimmerViewAlphaSlider_BitmapData_1.height,true,16777215);
            _loc1_.bitmap.copyPixels(UnknownVarFromDimmerViewAlphaSlider_BitmapData_1,UnknownVarFromDimmerViewAlphaSlider_BitmapData_1.rect,new Point(0,0),null,null,true);
         }
         _loc2_ = UnknownVarFromDimmerViewAlphaSlider_IWindowController_1_1.findChildByName("slider_movement_area") as IWindowController_1;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.findChildByName("slider_button") as IBitmapWrapperController;
            if(_loc1_ != null && UnknownVarFromDimmerViewAlphaSlider_BitmapData_2 != null)
            {
               _loc1_.bitmap = new BitmapData(UnknownVarFromDimmerViewAlphaSlider_BitmapData_2.width,UnknownVarFromDimmerViewAlphaSlider_BitmapData_2.height,true,16777215);
               _loc1_.bitmap.copyPixels(UnknownVarFromDimmerViewAlphaSlider_BitmapData_2,UnknownVarFromDimmerViewAlphaSlider_BitmapData_2.rect,new Point(0,0),null,null,true);
               _loc1_.procedure = buttonProcedure;
               _referenceWidth = _loc2_.width - _loc1_.width;
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
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_base"));
         UnknownVarFromDimmerViewAlphaSlider_BitmapData_1 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_button"));
         UnknownVarFromDimmerViewAlphaSlider_BitmapData_2 = BitmapData(_loc2_.content);
      }
   }
}

