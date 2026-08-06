package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class WriteToLogs extends DefaultActionType
   {
      private var _section1:SectionPreset;
      
      private var UnknownVarFromWriteToLogs_DropdownPreset_1:DropdownPreset;
      
      private var _section2:SectionPreset;
      
      private var UnknownVarFromWriteToLogs_TextInputPreset_1:TextInputPreset;
      
      public function WriteToLogs()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.UnknownVarFromActionTypeCodes_Int_3;
      }
      
      override public function get negativeCode() : int
      {
         return ActionTypeCodes.UnknownVarFromActionTypeCodes_Int_4;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromWriteToLogs_DropdownPreset_1.selectedId);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromWriteToLogs_TextInputPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromWriteToLogs_DropdownPreset_1.selectedId = param1.getInt(0);
         UnknownVarFromWriteToLogs_TextInputPreset_1.text = param1.stringParam;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc4_.push(new ExpandableDropdownOption(0,"${wiredfurni.params.write_to_logs.log_level.0}"));
         _loc4_.push(new ExpandableDropdownOption(1,"${wiredfurni.params.write_to_logs.log_level.1}"));
         _loc4_.push(new ExpandableDropdownOption(2,"${wiredfurni.params.write_to_logs.log_level.2}"));
         _loc4_.push(new ExpandableDropdownOption(3,"${wiredfurni.params.write_to_logs.log_level.3}"));
         UnknownVarFromWriteToLogs_DropdownPreset_1 = param1.createDropdown(new DropdownParam("${wiredfurni.params.write_to_logs.log_level.title}",_loc4_));
         _section1 = param1.createSection("${wiredfurni.params.write_to_logs.log_level.title}",UnknownVarFromWriteToLogs_DropdownPreset_1);
         UnknownVarFromWriteToLogs_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",400));
         _section2 = param1.createSection("${wiredfurni.params.write_to_logs.log_message.title}",UnknownVarFromWriteToLogs_TextInputPreset_1);
         param3.addElements(_section1,_section2);
      }
   }
}

