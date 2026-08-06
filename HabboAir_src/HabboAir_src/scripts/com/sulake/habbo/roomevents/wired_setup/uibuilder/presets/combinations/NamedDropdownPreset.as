package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NamedDropdownPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromNamedDropdownPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var UnknownVarFromNamedDropdownPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromNamedDropdownPreset_DropdownPreset_1:DropdownPreset;
      
      public function NamedDropdownPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:DropdownParam, param5:String, param6:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         UnknownVarFromNamedDropdownPreset_TextPreset_1 = param2.createText(param5,new TextParam(0,param6));
         UnknownVarFromNamedDropdownPreset_DropdownPreset_1 = param2.createDropdown(param4);
         UnknownVarFromNamedDropdownPreset_TextPreset_1.window.y = param3.namedDropdownOffset;
         UnknownVarFromNamedDropdownPreset_SimpleListViewPreset_1 = param2.createSimpleListView(false,[UnknownVarFromNamedDropdownPreset_TextPreset_1,UnknownVarFromNamedDropdownPreset_DropdownPreset_1],true);
         _container.addChild(UnknownVarFromNamedDropdownPreset_SimpleListViewPreset_1.window);
      }
      
      public function get selectedId() : int
      {
         return UnknownVarFromNamedDropdownPreset_DropdownPreset_1.selectedId;
      }
      
      public function set selectedId(param1:int) : void
      {
         UnknownVarFromNamedDropdownPreset_DropdownPreset_1.selectedId = param1;
      }
      
      public function get selected() : ExpandableDropdownOption
      {
         return UnknownVarFromNamedDropdownPreset_DropdownPreset_1.selected;
      }
      
      public function reinit(param1:Vector.<ExpandableDropdownOption>, param2:int) : void
      {
         UnknownVarFromNamedDropdownPreset_DropdownPreset_1.reinit(param1,param2);
      }
      
      public function reset() : void
      {
         UnknownVarFromNamedDropdownPreset_DropdownPreset_1.reset();
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return UnknownVarFromNamedDropdownPreset_DropdownPreset_1.hasStaticWidth();
      }
      
      override public function get staticWidth() : int
      {
         if(hasStaticWidth())
         {
            return _container.width;
         }
         throw new Exception("Named dropdown has no static width");
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromNamedDropdownPreset_SimpleListViewPreset_1.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromNamedDropdownPreset_SimpleListViewPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromNamedDropdownPreset_SimpleListViewPreset_1.dispose();
         UnknownVarFromNamedDropdownPreset_SimpleListViewPreset_1 = null;
         UnknownVarFromNamedDropdownPreset_TextPreset_1 = null;
         UnknownVarFromNamedDropdownPreset_DropdownPreset_1 = null;
      }
   }
}

