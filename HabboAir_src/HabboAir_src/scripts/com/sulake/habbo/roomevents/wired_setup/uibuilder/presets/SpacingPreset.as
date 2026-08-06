package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SpacingPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      public function SpacingPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Boolean, param5:int)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("container_view") as IWindowController_1;
         if(param4)
         {
            _container.height = param5;
         }
         else
         {
            _container.width = param5;
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
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
      }
   }
}

