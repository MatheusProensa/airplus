package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AbstractSectionPreset extends WiredUIPreset
   {
      protected var UnknownVarFromAbstractSectionPreset_SectionPreset_1:SectionPreset;
      
      public function AbstractSectionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
      }
      
      protected function initializeSection(param1:String, param2:WiredUIPreset, param3:SectionParam = null) : void
      {
         UnknownVarFromAbstractSectionPreset_SectionPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createSection(param1,param2,param3);
      }
      
      override public function get window() : IWindowModel
      {
         return UnknownVarFromAbstractSectionPreset_SectionPreset_1.window;
      }
      
      public function set sectionTitle(param1:String) : void
      {
         UnknownVarFromAbstractSectionPreset_SectionPreset_1.titleText = param1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromAbstractSectionPreset_SectionPreset_1.resizeToWidth(param1);
      }
      
      public function set splitterVisible(param1:Boolean) : void
      {
         UnknownVarFromAbstractSectionPreset_SectionPreset_1.splitterVisible = param1;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromAbstractSectionPreset_SectionPreset_1];
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromAbstractSectionPreset_SectionPreset_1 = null;
      }
   }
}

