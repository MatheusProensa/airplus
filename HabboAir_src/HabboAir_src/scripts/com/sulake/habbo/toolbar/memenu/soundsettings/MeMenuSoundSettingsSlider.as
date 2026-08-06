package com.sulake.habbo.toolbar.memenu.soundsettings
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   
   public class MeMenuSoundSettingsSlider
   {
      private var UnknownVarFromMeMenuSoundSettingsSlider_Null_1:*;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1:IWindowController_1;
      
      private var _referenceWidth:int;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_Number_1:Number = 0;
      
      private var UnknownVarFromMeMenuSoundSettingsSlider_Number_2:Number = 1;
      
      public function MeMenuSoundSettingsSlider(param1:*, param2:IWindowController_1, param3:IAssetLibraryCollection, param4:Number = 0, param5:Number = 1)
      {
         super();
         UnknownVarFromMeMenuSoundSettingsSlider_Null_1 = param1;
         UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1 = param2;
         UnknownVarFromMeMenuSoundSettingsSlider_Number_1 = param4;
         UnknownVarFromMeMenuSoundSettingsSlider_Number_2 = param5;
         displaySlider();
      }
      
      public function dispose() : void
      {
         UnknownVarFromMeMenuSoundSettingsSlider_Null_1 = null;
         UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1 = null;
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
         UnknownVarFromMeMenuSoundSettingsSlider_Null_1.saveVolume(getValue(param2.x),false);
      }
      
      private function displaySlider() : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc1_:IWindowController_1 = null;
         if(UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1 == null)
         {
            return;
         }
         _loc2_ = UnknownVarFromMeMenuSoundSettingsSlider_IWindowController_1_1.findChildByName("slider_movement_area") as IWindowController_1;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.findChildByName("slider_button") as IWindowController_1;
            if(_loc1_ != null)
            {
               _loc1_.procedure = buttonProcedure;
               _referenceWidth = _loc2_.width - _loc1_.width;
            }
         }
      }
   }
}

