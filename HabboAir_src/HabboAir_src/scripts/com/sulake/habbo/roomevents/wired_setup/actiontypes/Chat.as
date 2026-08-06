package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class Chat extends DefaultActionType
   {
      private static const NOTIFICATION_STYLES:Array = [34,200,201,202,210,211,212,220,221,222,223,224,225,226,227,228,229,250,251,252];
      
      private var UnknownVarFromChat_TextAreaPreset_1:TextAreaPreset;
      
      private var UnknownVarFromChat_RadioGroupPreset_1:RadioGroupPreset;
      
      private var _styleDropdown:DropdownPreset;
      
      public function Chat()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.CHAT;
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromChat_TextAreaPreset_1.text;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromChat_RadioGroupPreset_1.selected,_styleDropdown.selectedId];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromChat_TextAreaPreset_1.text = param1.stringParam;
         UnknownVarFromChat_RadioGroupPreset_1.selected = param1.intParams[0];
         _styleDropdown.selectedId = param1.intParams[1];
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc6_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.show_message.usage_info}",true);
         UnknownVarFromChat_TextAreaPreset_1 = param1.createTextArea(new TextAreaParam(40,-1,8,-1,200));
         var _loc7_:SectionPreset = param1.createSection("${wiredfurni.params.message}",UnknownVarFromChat_TextAreaPreset_1);
         UnknownVarFromChat_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.show_message.visibility_selection.0}"),new RadioButtonParam(1,"${wiredfurni.params.show_message.visibility_selection.1}")]);
         var _loc8_:SectionPreset = param1.createSection("${wiredfurni.params.show_message.visibility_selection.title}",UnknownVarFromChat_RadioGroupPreset_1,SectionParam.COLLAPSED);
         var _loc4_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         for each(var _loc5_ in NOTIFICATION_STYLES)
         {
            _loc4_.push(new ExpandableDropdownOption(_loc5_,"${wiredfurni.params.show_message.style_selection." + _loc5_ + "}"));
         }
         _styleDropdown = param1.createDropdown(new DropdownParam("${wiredfurni.params.show_message.style_selection.title}",_loc4_));
         var _loc9_:SectionPreset = param1.createSection("${wiredfurni.params.show_message.style_selection.title}",_styleDropdown,SectionParam.COLLAPSED);
         param3.addElements(_loc6_,_loc7_,_loc8_,_loc9_);
      }
   }
}

