package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CenteredContainerPreset extends WiredUIPreset
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromCenteredContainerPreset_WiredUIPreset_1:WiredUIPreset;
      
      private var _topBottomMargin:int;
      
      private var _ignoreListeners:Boolean = false;
      
      public function CenteredContainerPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset, param5:int, param6:IWindowController_1 = null)
      {
         super(param1,param2,param3);
         _window = param6;
         if(_window == null)
         {
            _window = param2.createLayout("container_view") as IWindowController_1;
         }
         _window.addChild(param4.window);
         UnknownVarFromCenteredContainerPreset_WiredUIPreset_1 = param4;
         UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.window.y = param5;
         _topBottomMargin = param5;
         UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.window.addEventListener("WE_RESIZED",onResizeListener);
         if(!UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.hasStaticWidth())
         {
            throw new Error("CenteredContainerPreset only works with static with children");
         }
      }
      
      private function onResizeListener(param1:WindowEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         resizeToWidth(_window.width);
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromCenteredContainerPreset_WiredUIPreset_1];
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         _ignoreListeners = true;
         super.resizeToWidth(param1);
         _window.width = param1;
         UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.resizeToWidth(UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.staticWidth);
         _window.height = UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.window.height + _topBottomMargin * 2;
         UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.window.x = param1 / 2 - UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.staticWidth / 2;
         _ignoreListeners = false;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromCenteredContainerPreset_WiredUIPreset_1.window.removeEventListener("WE_RESIZED",onResizeListener);
         super.dispose();
         _window.dispose();
         _window = null;
         UnknownVarFromCenteredContainerPreset_WiredUIPreset_1 = null;
      }
   }
}

