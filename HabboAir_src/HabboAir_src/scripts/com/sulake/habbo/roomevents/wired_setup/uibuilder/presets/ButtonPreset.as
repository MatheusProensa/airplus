package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ButtonPreset extends WiredUIPreset
   {
      public static const MODE_SCALE:int = 0;
      
      public static const MODE_STRETCH:int = 1;
      
      private var _container:UnknownICoreWindowComponents4;
      
      private var _mode:int;
      
      private var UnknownVarFromButtonPreset_Function_1:Function;
      
      public function ButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Function, param6:int = 0)
      {
         super(param1,param2,param3);
         UnknownVarFromButtonPreset_Function_1 = param5;
         _container = param3.createButton();
         _container.caption = param4;
         _mode = param6;
         _container.addEventListener("WME_CLICK",buttonClicked);
      }
      
      private function buttonClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromButtonPreset_Function_1 != null)
         {
            UnknownVarFromButtonPreset_Function_1();
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         if(_mode == 0)
         {
            _container.limits.minWidth = param1;
            _container.limits.maxWidth = param1;
            _container.width = param1;
         }
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return _mode == 1;
      }
      
      override public function get staticWidth() : int
      {
         if(_mode == 1)
         {
            return _container.width;
         }
         return -1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         UnknownVarFromButtonPreset_Function_1 = null;
      }
   }
}

