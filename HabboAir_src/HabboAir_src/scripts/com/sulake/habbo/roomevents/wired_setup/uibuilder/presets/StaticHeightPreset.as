package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class StaticHeightPreset extends WiredUIPreset
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromStaticHeightPreset_WiredUIPreset_1:WiredUIPreset;
      
      public function StaticHeightPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset, param5:int)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("container_view") as IWindowController_1;
         UnknownVarFromStaticHeightPreset_WiredUIPreset_1 = param4;
         _window.addChild(UnknownVarFromStaticHeightPreset_WiredUIPreset_1.window);
         _window.height = param5;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = param1;
         UnknownVarFromStaticHeightPreset_WiredUIPreset_1.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromStaticHeightPreset_WiredUIPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _window.dispose();
         _window = null;
         UnknownVarFromStaticHeightPreset_WiredUIPreset_1 = null;
      }
   }
}

