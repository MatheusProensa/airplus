package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.components.UnknownICoreWindowComponents7;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VolterMiniAssetIconButtonPreset extends MiniAssetIconButtonPreset
   {
      private static const COLOR_INACTIVE:uint = 2236962;
      
      private static const COLOR_YELLOW_HOVERED:uint = 5527335;
      
      private static const COLOR_BLUE_HOVERED:uint = 3356769;
      
      public function VolterMiniAssetIconButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:Function)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      protected function get hoverColor() : uint
      {
         if(YELLOW_ASSETS.indexOf(_assetName) != -1)
         {
            return 5527335;
         }
         if(BLUE_ASSETS.indexOf(_assetName) != -1)
         {
            return 3356769;
         }
         throw new Exception("Color for asset not configured");
      }
      
      override protected function updateUI() : void
      {
         var _loc1_:* = 2236962;
         if(UnknownVarFromMiniAssetIconButtonPreset_Boolean_1)
         {
            _loc1_ = hoverColor;
         }
         else if(_selected)
         {
            _loc1_ = selectedColor;
         }
         _loc1_ |= 4278190080;
         clickArea.color = _loc1_;
         marginLeftBg.color = _loc1_;
         marginRightBg.color = _loc1_;
      }
      
      private function get marginLeftBg() : UnknownICoreWindowComponents7
      {
         return _container.findChildByName("margin_item_color_left") as UnknownICoreWindowComponents7;
      }
      
      private function get marginRightBg() : UnknownICoreWindowComponents7
      {
         return _container.findChildByName("margin_item_color_right") as UnknownICoreWindowComponents7;
      }
   }
}

