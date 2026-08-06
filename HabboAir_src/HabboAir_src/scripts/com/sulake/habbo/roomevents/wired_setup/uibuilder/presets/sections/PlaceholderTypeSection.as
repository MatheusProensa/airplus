package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedTextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PlaceholderTypeSection extends AbstractSectionPreset
   {
      private var UnknownVarFromPlaceholderTypeSection_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromPlaceholderTypeSection_NamedTextInputPreset_1:NamedTextInputPreset;
      
      public function PlaceholderTypeSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String = null)
      {
         super(param1,param2,param3);
         UnknownVarFromPlaceholderTypeSection_NamedTextInputPreset_1 = param2.createNamedTextInput(new TextInputParam("",5,null,55),l("texts.select_delimiter"));
         param4 = param4 == null ? "" : param4 + ".";
         UnknownVarFromPlaceholderTypeSection_RadioGroupPreset_1 = param2.createRadioGroup([new RadioButtonParam(0,l("texts.placeholder_type." + param4 + "1")),new RadioButtonParam(1,l("texts.placeholder_type." + param4 + "2"),null,UnknownVarFromPlaceholderTypeSection_NamedTextInputPreset_1)]);
         initializeSection(l("texts.placeholder_type"),UnknownVarFromPlaceholderTypeSection_RadioGroupPreset_1);
      }
      
      public function get isShowMultiple() : Boolean
      {
         return UnknownVarFromPlaceholderTypeSection_RadioGroupPreset_1.selected == 1;
      }
      
      public function set isShowMultiple(param1:Boolean) : void
      {
         UnknownVarFromPlaceholderTypeSection_RadioGroupPreset_1.selected = param1 ? 1 : 0;
      }
      
      public function get delimiter() : String
      {
         return isShowMultiple ? UnknownVarFromPlaceholderTypeSection_NamedTextInputPreset_1.text : "";
      }
      
      public function set delimiter(param1:String) : void
      {
         UnknownVarFromPlaceholderTypeSection_NamedTextInputPreset_1.text = param1;
      }
      
      public function get(param1:int) : RadioButtonPreset
      {
         return UnknownVarFromPlaceholderTypeSection_RadioGroupPreset_1.get(param1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromPlaceholderTypeSection_RadioGroupPreset_1 = null;
         UnknownVarFromPlaceholderTypeSection_NamedTextInputPreset_1 = null;
      }
   }
}

