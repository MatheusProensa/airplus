package com.sulake.habbo.toolbar.memenu.soundsettings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.memenu.MeMenuController;
   import com.sulake.habbo.toolbar.memenu.MeMenuSettingsMenuView;
   import flash.display.BitmapData;
   
   public class MeMenuSoundSettingsView
   {
      private var UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1:MeMenuSettingsMenuView;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_1:MeMenuSoundSettingsItem;
      
      private var UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_2:MeMenuSoundSettingsItem;
      
      private var UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_3:MeMenuSoundSettingsItem;
      
      private var _soundsOffIconColor:BitmapData;
      
      private var _soundsOffIconWhite:BitmapData;
      
      private var _soundsOnIconColor:BitmapData;
      
      private var _soundsOnIconWhite:BitmapData;
      
      private var _genericVolume:Number = 1;
      
      private var _furniVolume:Number = 1;
      
      private var _traxVolume:Number = 1;
      
      private var UnknownVarFromMeMenuSoundSettingsView_ToolbarView_1:ToolbarView;
      
      public function MeMenuSoundSettingsView()
      {
         super();
      }
      
      public function init(param1:MeMenuSettingsMenuView, param2:ToolbarView) : void
      {
         UnknownVarFromMeMenuSoundSettingsView_ToolbarView_1 = param2;
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1 = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         saveVolume(_genericVolume,_furniVolume,_traxVolume);
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1 = null;
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         if(UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_1 != null)
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_1.dispose();
         }
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_1 = null;
         if(UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_2 != null)
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_2.dispose();
         }
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_2 = null;
         if(UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_3 != null)
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_3.dispose();
         }
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_3 = null;
         if(_soundsOffIconColor)
         {
            _soundsOffIconColor.dispose();
            _soundsOffIconColor = null;
         }
         if(_soundsOffIconWhite)
         {
            _soundsOffIconWhite.dispose();
            _soundsOffIconWhite = null;
         }
         if(_soundsOnIconColor)
         {
            _soundsOnIconColor.dispose();
            _soundsOnIconColor = null;
         }
         if(_soundsOnIconWhite)
         {
            _soundsOnIconWhite.dispose();
            _soundsOnIconWhite = null;
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function updateSettings() : void
      {
         _genericVolume = UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.soundManager.genericVolume;
         _furniVolume = UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.soundManager.furniVolume;
         _traxVolume = UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.soundManager.traxVolume;
         if(UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_1 != null)
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_1.setValue(_genericVolume);
         }
         if(UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_2 != null)
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_2.setValue(_furniVolume);
         }
         if(UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_3 != null)
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_3.setValue(_traxVolume);
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:IWindowModel = null;
         var _loc3_:int = 0;
         var _loc2_:XmlAsset = UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.assets.getAssetByName("me_menu_sound_settings_xml") as XmlAsset;
         _window = UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         _window.x = UnknownVarFromMeMenuSoundSettingsView_ToolbarView_1.window.width + 10;
         _window.y = UnknownVarFromMeMenuSoundSettingsView_ToolbarView_1.window.bottom - _window.height;
         _loc3_ = 0;
         while(_loc3_ < _window.numChildren)
         {
            _loc1_ = _window.getChildAt(_loc3_);
            _loc1_.addEventListener("WME_CLICK",onButtonClicked);
            _loc3_++;
         }
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_1 = new MeMenuSoundSettingsItem(this,0,uiVolumeContainer);
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_2 = new MeMenuSoundSettingsItem(this,1,furniVolumeContainer);
         UnknownVarFromMeMenuSoundSettingsView_MeMenuSoundSettingsItem_3 = new MeMenuSoundSettingsItem(this,2,traxVolumeContainer);
         updateSettings();
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc3_:String = _loc2_.name;
         Logger.log(_loc3_);
         var _loc4_:* = _loc3_;
         if("back_btn" !== _loc4_)
         {
            Logger.log("Me Menu Settings View: unknown button: " + _loc3_);
         }
         else
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.window.visible = true;
            dispose();
         }
      }
      
      public function saveVolume(param1:Number, param2:Number, param3:Number, param4:Boolean = true) : void
      {
         var _loc6_:Number = param2 != -1 ? param2 : _furniVolume;
         var _loc5_:Number = param1 != -1 ? param1 : _genericVolume;
         var _loc7_:Number = param3 != -1 ? param3 : _traxVolume;
         if(param4)
         {
            if(UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1 == null)
            {
               return;
            }
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.soundManager.furniVolume = _loc6_;
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.soundManager.genericVolume = _loc5_;
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.soundManager.traxVolume = _loc7_;
         }
         else
         {
            UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget.toolbar.soundManager.previewVolume(_loc5_,_loc6_,_loc7_);
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
      
      public function get uiVolumeContainer() : IWindowController_1
      {
         return _window.findChildByName("ui_volume_container") as IWindowController_1;
      }
      
      public function get furniVolumeContainer() : IWindowController_1
      {
         return _window.findChildByName("furni_volume_container") as IWindowController_1;
      }
      
      public function get traxVolumeContainer() : IWindowController_1
      {
         return _window.findChildByName("trax_volume_container") as IWindowController_1;
      }
      
      public function get widget() : MeMenuController
      {
         return UnknownVarFromMeMenuSoundSettingsView_MeMenuSettingsMenuView_1.widget;
      }
      
      public function get soundsOffIconColor() : BitmapData
      {
         return _soundsOffIconColor;
      }
      
      public function get soundsOffIconWhite() : BitmapData
      {
         return _soundsOffIconWhite;
      }
      
      public function get soundsOnIconColor() : BitmapData
      {
         return _soundsOnIconColor;
      }
      
      public function get soundsOnIconWhite() : BitmapData
      {
         return _soundsOnIconWhite;
      }
   }
}

