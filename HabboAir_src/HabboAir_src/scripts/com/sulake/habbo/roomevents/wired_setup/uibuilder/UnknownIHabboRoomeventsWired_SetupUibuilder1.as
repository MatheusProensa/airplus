package com.sulake.habbo.roomevents.wired_setup.uibuilder
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SpacerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public interface UnknownIHabboRoomeventsWired_SetupUibuilder1 extends IComponentInterfaceQueue
   {
      function get window() : IWindowModel;
      
      function resizeToWidth(param1:int) : void;
      
      function hasStaticWidth() : Boolean;
      
      function get staticWidth() : int;
      
      function alignRight() : WiredUIPreset;
      
      function alignCenter() : WiredUIPreset;
      
      function staticHeight(param1:int) : WiredUIPreset;
      
      function floatVertically() : WiredUIPreset;
      
      function wrapWindow(param1:IWindowModel, param2:Boolean = false) : WiredUIPreset;
      
      function noDisable() : WiredUIPreset;
      
      function halfBlend() : WiredUIPreset;
      
      function set disabled(param1:Boolean) : void;
      
      function updateDisabledState() : void;
      
      function get disabled() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function get visible() : Boolean;
      
      function set blendSpacer(param1:SpacerPreset) : void;
   }
}

