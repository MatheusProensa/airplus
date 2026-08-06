package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextualButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AdvancedSettingsWrapperPreset extends WiredUIPreset
   {
      private var _container:IItemListWindow;
      
      private var _button:TextualButtonPreset = null;
      
      private var UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1:WiredUIPreset = null;
      
      private var UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var _isExpanded:Boolean = false;
      
      private var _alwaysExpanded:Boolean = false;
      
      public function AdvancedSettingsWrapperPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Boolean)
      {
         super(param1,param2,param3);
         _alwaysExpanded = param5;
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         _container.spacing = param3.sectionSpacing;
         UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createSimpleListView(true,param4);
         UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1.spacing = param3.sectionSpacing;
         UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1.backgroundColor = param3.advancedBackgroundColor;
         blendingBackgroundColor = param3.backgroundColor;
         if(!param5)
         {
            _button = UnknownVarFromWiredUIPreset_PresetManager_1.createTextualButtonPreset("${wiredfurni.params.sources.expand}",expandOrCollapse);
            UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1 = _button.alignCenter();
            _container.addListItem(UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1.window);
         }
         else
         {
            expanded = true;
         }
      }
      
      public function set expanded(param1:Boolean) : void
      {
         if(_isExpanded != param1 && !(_alwaysExpanded && _isExpanded))
         {
            expandOrCollapse();
         }
      }
      
      private function expandOrCollapse() : void
      {
         if(_isExpanded)
         {
            _container.removeListItem(UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1.window);
            _isExpanded = false;
            blendingBackgroundColor = UnknownVarFromWiredUIPreset_WiredStyle_1.backgroundColor;
         }
         else
         {
            _container.addListItem(UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1.window);
            _isExpanded = true;
            blendingBackgroundColor = UnknownVarFromWiredUIPreset_WiredStyle_1.advancedBackgroundColor;
         }
         if(_button != null)
         {
            _button.text = _isExpanded ? "${wiredfurni.params.sources.collapse}" : "${wiredfurni.params.sources.expand}";
            UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1.resizeToWidth(_container.width);
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
         if(UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1 != null)
         {
            UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1.resizeToWidth(param1);
         }
         UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         if(UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1 == null)
         {
            return [UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1];
         }
         return [UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1,UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1];
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
         _button = null;
         UnknownVarFromAdvancedSettingsWrapperPreset_WiredUIPreset_1 = null;
         UnknownVarFromAdvancedSettingsWrapperPreset_SimpleListViewPreset_1 = null;
      }
   }
}

