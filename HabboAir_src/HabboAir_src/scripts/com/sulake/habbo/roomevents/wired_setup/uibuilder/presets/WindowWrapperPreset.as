package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class WindowWrapperPreset extends WiredUIPreset
   {
      private var _window:IWindowModel;
      
      private var _staticWidth:Boolean;
      
      public function WindowWrapperPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:IWindowModel, param5:Boolean)
      {
         super(param1,param2,param3);
         _window = param4;
         _staticWidth = param5;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return _staticWidth;
      }
      
      override public function get staticWidth() : int
      {
         if(!_staticWidth)
         {
            return -1;
         }
         return _window.width;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = param1;
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

