package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ChronoMaskFilterPreset extends WiredUIPreset
   {
      private var _checkboxGroup:CheckboxGroupPreset;
      
      public function ChronoMaskFilterPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:int = 1)
      {
         var _loc7_:int = 0;
         super(param1,param2,param3);
         var _loc6_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < param4.length)
         {
            _loc6_.push(new CheckboxOptionParam(param4[_loc7_],_loc7_));
            _loc7_++;
         }
         _checkboxGroup = param2.createCheckboxGroup(_loc6_,null,param5);
      }
      
      public function get mask() : int
      {
         return _checkboxGroup.mask;
      }
      
      public function set mask(param1:int) : void
      {
         _checkboxGroup.mask = param1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _checkboxGroup.resizeToWidth(param1);
      }
      
      override public function get window() : IWindowModel
      {
         return _checkboxGroup.window;
      }
      
      override protected function get childPresets() : Array
      {
         return [_checkboxGroup];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _checkboxGroup = null;
      }
   }
}

