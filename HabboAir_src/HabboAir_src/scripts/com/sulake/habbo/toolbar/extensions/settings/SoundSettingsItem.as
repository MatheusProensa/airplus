package com.sulake.habbo.toolbar.extensions.settings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.memenu.soundsettings.MeMenuSoundSettingsSlider;
   
   public class SoundSettingsItem implements IComponentInterfaceQueue
   {
      public static const TYPE_UI_VOLUME:int = 0;
      
      public static const TYPE_FURNI_VOLUME:int = 1;
      
      public static const TYPE_TRAX_VOLUME:int = 2;
      
      private var UnknownVarFromSoundSettingsItem_Int_1:int;
      
      private var _volume:Number;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromSoundSettingsItem_MeMenuSoundSettingsSlider_1:MeMenuSoundSettingsSlider;
      
      private var UnknownVarFromSoundSettingsItem_SoundSettingsView_1:SoundSettingsView;
      
      public function SoundSettingsItem(param1:SoundSettingsView, param2:int, param3:IWindowController_1)
      {
         var _loc4_:IWindowModel = null;
         super();
         UnknownVarFromSoundSettingsItem_Int_1 = param2;
         UnknownVarFromSoundSettingsItem_SoundSettingsView_1 = param1;
         _window = param3;
         UnknownVarFromSoundSettingsItem_MeMenuSoundSettingsSlider_1 = new MeMenuSoundSettingsSlider(this,_window.findChildByName("volume_container") as IWindowController_1,param1.toolbar.assets,0,1);
         _loc4_ = _window.findChildByName("sounds_off");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onButtonClicked);
         }
         _loc4_ = _window.findChildByName("sounds_on");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onButtonClicked);
         }
         updateSoundIcons();
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromSoundSettingsItem_MeMenuSoundSettingsSlider_1)
            {
               UnknownVarFromSoundSettingsItem_MeMenuSoundSettingsSlider_1.dispose();
               UnknownVarFromSoundSettingsItem_MeMenuSoundSettingsSlider_1 = null;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromSoundSettingsItem_SoundSettingsView_1 == null;
      }
      
      public function saveVolume(param1:Number, param2:Boolean) : void
      {
         _volume = param1;
         switch(UnknownVarFromSoundSettingsItem_Int_1)
         {
            case 0:
               UnknownVarFromSoundSettingsItem_SoundSettingsView_1.saveVolume(param1,-1,-1,param2);
               break;
            case 1:
               UnknownVarFromSoundSettingsItem_SoundSettingsView_1.saveVolume(-1,param1,-1,param2);
               break;
            case 2:
               UnknownVarFromSoundSettingsItem_SoundSettingsView_1.saveVolume(-1,-1,param1,param2);
         }
         updateSoundIcons();
         UnknownVarFromSoundSettingsItem_SoundSettingsView_1.updateSettings();
      }
      
      private function updateSoundIcons() : void
      {
         if(_volume == 0)
         {
            setBitmap("sounds_on_icon","sounds_on_white");
            setBitmap("sounds_off_icon","sounds_off_color");
         }
         else
         {
            setBitmap("sounds_on_icon","sounds_on_color");
            setBitmap("sounds_off_icon","sounds_off_white");
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "sounds_off":
               saveVolume(0,false);
               break;
            case "sounds_on":
               saveVolume(1,false);
               break;
            default:
               Logger.log("Me Menu Settings, Sound settings item: unknown button: " + _loc3_);
         }
      }
      
      private function setBitmap(param1:String, param2:String) : void
      {
         IStaticBitmapWrapperWindow(_window.findChildByName(param1)).assetUri = "toolbar_memenu_settings_" + param2;
      }
      
      public function setValue(param1:Number) : void
      {
         UnknownVarFromSoundSettingsItem_MeMenuSoundSettingsSlider_1.setValue(param1);
         updateSoundIcons();
      }
   }
}

