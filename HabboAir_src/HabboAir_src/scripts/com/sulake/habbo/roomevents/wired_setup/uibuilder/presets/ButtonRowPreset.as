package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ButtonRowPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromButtonRowPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      public function ButtonRowPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         UnknownVarFromButtonRowPreset_SimpleListViewPreset_1 = param2.createSimpleListView(false,param4);
         UnknownVarFromButtonRowPreset_SimpleListViewPreset_1.spacing = param3.buttonRowSpacing;
         _container.addChild(UnknownVarFromButtonRowPreset_SimpleListViewPreset_1.window);
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromButtonRowPreset_SimpleListViewPreset_1.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromButtonRowPreset_SimpleListViewPreset_1];
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
         UnknownVarFromButtonRowPreset_SimpleListViewPreset_1 = null;
      }
   }
}

