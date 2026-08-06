package com.sulake.habbo.ui.widget.memenu.soundsettings
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MeMenuSoundSettingsSlider
   {
      private var UnknownVarFromMeMenuSoundSettingsSlider_MeMenuSoundSettingsItem_1:MeMenuSoundSettingsItem;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1:BitmapData;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2:BitmapData;
      
      private var _referenceWidth:int;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_Number_1:Number = 0;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_Number_2:Number = 1;
      
      public function MeMenuSoundSettingsSlider(param1:MeMenuSoundSettingsItem, param2:IWindowController_1, param3:IAssetLibraryCollection, param4:Number = 0, param5:Number = 1)
      {
         super();
         UnknownVarFromMeMenuSoundSettingsSlider_MeMenuSoundSettingsItem_1 = param1;
         UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1 = param2;
         UnknownVarFromMeMenuSoundSettingsSlider_Number_1 = param4;
         UnknownVarFromMeMenuSoundSettingsSlider_Number_2 = param5;
         storeAssets(param3);
         displaySlider();
      }
      
      public function dispose() : void
      {
         UnknownVarFromMeMenuSoundSettingsSlider_MeMenuSoundSettingsItem_1 = null;
         UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1 = null;
         UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1 = null;
         UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2 = null;
      }
      
      public function setValue(param1:Number) : void
      {
         if(UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc2_:IWindowModel = UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1.findChildByName("slider_button");
         if(_loc2_ != null)
         {
            _loc2_.x = getSliderPosition(param1);
         }
      }
      
      private function getSliderPosition(param1:Number) : int
      {
         return int(_referenceWidth * ((param1 - UnknownVarFromMeMenuSoundSettingsSlider_Number_1) / (UnknownVarFromMeMenuSoundSettingsSlider_Number_2 - UnknownVarFromMeMenuSoundSettingsSlider_Number_1)));
      }
      
      private function getValue(param1:Number) : Number
      {
         return param1 / _referenceWidth * (UnknownVarFromMeMenuSoundSettingsSlider_Number_2 - UnknownVarFromMeMenuSoundSettingsSlider_Number_1) + UnknownVarFromMeMenuSoundSettingsSlider_Number_1;
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_RELOCATED")
         {
            return;
         }
         UnknownVarFromMeMenuSoundSettingsSlider_MeMenuSoundSettingsItem_1.saveVolume(getValue(param2.x),false);
      }
      
      private function displaySlider() : void
      {
         var _loc3_:IWindowController_1 = null;
         var _loc1_:IWindowController_1 = null;
         var _loc2_:IBitmapWrapperController = null;
         if(UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1 == null)
         {
            return;
         }
         _loc2_ = UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1.findChildByName("slider_base") as IBitmapWrapperController;
         if(_loc2_ != null && UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1 != null)
         {
            _loc2_.bitmap = new BitmapData(UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1.width,UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1.height,true,16777215);
            _loc2_.bitmap.copyPixels(UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1,UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1.rect,new Point(0,0),null,null,true);
         }
         _loc3_ = UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1.findChildByName("slider_movement_area") as IWindowController_1;
         if(_loc3_ != null)
         {
            _loc1_ = _loc3_.findChildByName("slider_button") as IWindowController_1;
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_.findChildByName("slider_bitmap") as IBitmapWrapperController;
               if(_loc2_ != null && UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2 != null)
               {
                  _loc2_.bitmap = new BitmapData(UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2.width,UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2.height,true,16777215);
                  _loc2_.bitmap.copyPixels(UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2,UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2.rect,new Point(0,0),null,null,true);
                  _loc1_.procedure = buttonProcedure;
                  _referenceWidth = _loc3_.width - _loc2_.width;
               }
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
         _loc2_ = BitmapDataAsset(param1.getAssetByName("memenu_settings_slider_base"));
         UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_1 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("memenu_settings_slider_button"));
         UnknownVarFromMeMenuSoundSettingsSlider_BitmapData_2 = BitmapData(_loc2_.content);
      }
   }
}

