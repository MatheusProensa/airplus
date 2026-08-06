package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FloatVerticallyPreset extends WiredUIPreset
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1:WiredUIPreset;
      
      public function FloatVerticallyPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("container_view") as IWindowController_1;
         UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1 = param4;
         _window.addChild(UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.window);
         _window.height = 1;
         _window.width = UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.window.width;
         UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.window.setParamFlag(16,false);
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.hasStaticWidth();
      }
      
      override public function get staticWidth() : int
      {
         return UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.staticWidth;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         if(!UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.hasStaticWidth())
         {
            _window.width = param1;
            UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.resizeToWidth(param1);
         }
         else
         {
            UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.resizeToWidth(UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1.staticWidth);
         }
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1];
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
         UnknownVarFromFloatVerticallyPreset_WiredUIPreset_1 = null;
      }
   }
}

