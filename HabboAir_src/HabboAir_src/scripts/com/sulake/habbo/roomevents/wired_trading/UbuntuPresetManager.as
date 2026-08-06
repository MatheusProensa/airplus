package com.sulake.habbo.roomevents.wired_trading
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UbuntuPresetManager extends PresetManager
   {
      private var _wiredStyle:WiredStyle;
      
      public function UbuntuPresetManager(param1:HabboUserDefinedRoomEvents)
      {
         super(param1);
         _wiredStyle = param1.wiredCtrl.getStyleByName("ubuntu");
      }
      
      override public function get wiredStyle() : WiredStyle
      {
         return _wiredStyle;
      }
   }
}

