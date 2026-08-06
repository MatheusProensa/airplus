package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.AssetButtonRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CenteredContainerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FloorEditorPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var UnknownVarFromFloorEditorPreset_AssetButtonRowPreset_1:AssetButtonRowPreset;
      
      private var UnknownVarFromFloorEditorPreset_FloorDrawingPreset_1:FloorDrawingPreset;
      
      private var UnknownVarFromFloorEditorPreset_CenteredContainerPreset_1:CenteredContainerPreset;
      
      public function FloorEditorPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:AssetButtonRowPreset, param5:FloorDrawingPreset)
      {
         super(param1,param2,param3);
         UnknownVarFromFloorEditorPreset_AssetButtonRowPreset_1 = param4;
         UnknownVarFromFloorEditorPreset_FloorDrawingPreset_1 = param5;
         var _loc6_:UnknownICoreWindowComponents6 = param2.createLayout("border_view") as UnknownICoreWindowComponents6;
         _loc6_.color = param3.advancedBackgroundColor;
         UnknownVarFromFloorEditorPreset_CenteredContainerPreset_1 = param2.createCenteredContainerPreset(UnknownVarFromFloorEditorPreset_FloorDrawingPreset_1,5,_loc6_);
         UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1 = param2.createSimpleListView(true,[UnknownVarFromFloorEditorPreset_AssetButtonRowPreset_1,UnknownVarFromFloorEditorPreset_CenteredContainerPreset_1]);
         UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1.spacing = param3.genericVerticalSpacing;
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         _container.addChild(UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1.window);
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1.resizeToWidth(param1);
         _container.width = param1;
         _container.height = UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1.window.height;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1];
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
         UnknownVarFromFloorEditorPreset_SimpleListViewPreset_1 = null;
         UnknownVarFromFloorEditorPreset_AssetButtonRowPreset_1 = null;
         UnknownVarFromFloorEditorPreset_FloorDrawingPreset_1 = null;
         UnknownVarFromFloorEditorPreset_CenteredContainerPreset_1 = null;
      }
   }
}

