package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PressedButtonMiniAssetIconButtonPreset extends MiniAssetIconButtonPreset
   {
      public function PressedButtonMiniAssetIconButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:Function)
      {
         super(param1,param2,param3,param4,param5,param6);
         clickArea.addEventListener("WME_OUT",maybeCancelEvent);
         clickArea.addEventListener("WME_UP",maybeCancelEvent);
         updateUI();
      }
      
      private function maybeCancelEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OUT" && _selected)
         {
            param1.preventWindowOperation();
         }
         if(param1.type == "WME_UP")
         {
            iconClicked(null);
            param1.preventWindowOperation();
         }
      }
      
      override protected function updateUI() : void
      {
         var _loc1_:InteractiveController = InteractiveController(clickArea);
         _loc1_.setStateFlag(16,_selected);
         _loc1_.setStateFlag(4,UnknownVarFromMiniAssetIconButtonPreset_Boolean_1);
         if(!UnknownVarFromMiniAssetIconButtonPreset_Boolean_1 && !_selected)
         {
            clickArea.color = 16777215;
            return;
         }
         var _loc2_:uint = selectedColor;
         var _loc3_:Number = 1.38;
         if(UnknownVarFromMiniAssetIconButtonPreset_Boolean_1 && !_selected)
         {
            _loc3_ = 1.6;
         }
         _loc2_ = Util.lightenColor(_loc2_,_loc3_);
         clickArea.color = _loc2_;
      }
   }
}

