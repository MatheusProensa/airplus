package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class IconButtonPreset extends WiredUIPreset
   {
      private var _container:IWindowModel;
      
      private var UnknownVarFromIconButtonPreset_Function_1:Function;
      
      public function IconButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Function)
      {
         super(param1,param2,param3);
         _container = param3.createIconButton(param4);
         UnknownVarFromIconButtonPreset_Function_1 = param5;
         _container.addEventListener("WME_CLICK",iconClicked);
      }
      
      private function iconClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromIconButtonPreset_Function_1 != null)
         {
            UnknownVarFromIconButtonPreset_Function_1();
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
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
         UnknownVarFromIconButtonPreset_Function_1 = null;
      }
   }
}

