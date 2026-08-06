package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VerticalSplitterPreset extends WiredUIPreset
   {
      private static const SPLITTER_WIDTH:int = 1;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromVerticalSplitterPreset_Int_1:int;
      
      public function VerticalSplitterPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:int)
      {
         super(param1,param2,param3);
         UnknownVarFromVerticalSplitterPreset_Int_1 = param4;
         _window = param2.createLayout("container_view") as IWindowController_1;
         _window.width = 1;
         _window.height = UnknownVarFromVerticalSplitterPreset_Int_1;
         _window.background = true;
         _window.color = param3.verticalSplitterColor;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return 1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = 1;
         _window.height = UnknownVarFromVerticalSplitterPreset_Int_1;
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
      }
   }
}

