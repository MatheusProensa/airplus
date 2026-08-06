package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.ISourceTypePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.SourceTypePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.newpicker.NewSourceTypePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SourceTypeSelectorPreset extends WiredUIPreset
   {
      private var _window:IItemListWindow;
      
      private var _picker:ISourceTypePicker;
      
      public function SourceTypeSelectorPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:SourceTypeSelectorParam)
      {
         super(param1,param2,param3);
         _window = param3.createSourceTypeSelector();
         if(_window.tags.indexOf("NEW") != -1)
         {
            _picker = new NewSourceTypePicker(param1,_window,param4.listener);
         }
         else
         {
            _picker = new SourceTypePicker(param1,_window,param4.listener);
         }
         _picker.initialize(param4.ids,param4.currentSelection);
      }
      
      public function select(param1:int) : void
      {
         _picker.select(param1);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _window.width;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
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
         _picker.dispose();
         _picker = null;
      }
   }
}

