package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AvatarSaysSomething extends DefaultTriggerConf
   {
      private var UnknownVarFromAvatarSaysSomething_TextInputPreset_1:TextInputPreset;
      
      private var UnknownVarFromAvatarSaysSomething_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromAvatarSaysSomething_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      public function AvatarSaysSomething()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.AVATAR_SAYS_SOMETHING;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromAvatarSaysSomething_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",1000,null,-1,null,true,loc("wiredfurni.tooltip.chatinput")));
         UnknownVarFromAvatarSaysSomething_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("chatcontains")),new RadioButtonParam(1,l("exactmatch")),new RadioButtonParam(2,l("allmatch"))],onTriggerTypeChange);
         UnknownVarFromAvatarSaysSomething_CheckboxGroupPreset_1 = param1.createCheckboxGroup([new CheckboxOptionParam(l("chat.hide"),1),new CheckboxOptionParam(l("chat.onlyowner"),0)]);
         param3.addElements(param1.createSection(l("whatissaid"),UnknownVarFromAvatarSaysSomething_TextInputPreset_1),param1.createSection(l("chattriggertype"),UnknownVarFromAvatarSaysSomething_RadioGroupPreset_1),param1.createSection(l("select_options"),UnknownVarFromAvatarSaysSomething_CheckboxGroupPreset_1));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromAvatarSaysSomething_CheckboxGroupPreset_1.get(0).selected ? 1 : 0,UnknownVarFromAvatarSaysSomething_RadioGroupPreset_1.selected,UnknownVarFromAvatarSaysSomething_CheckboxGroupPreset_1.get(1).selected ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromAvatarSaysSomething_TextInputPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromAvatarSaysSomething_TextInputPreset_1.text = param1.stringParam;
         var _loc2_:Array = param1.intParams;
         UnknownVarFromAvatarSaysSomething_CheckboxGroupPreset_1.get(0).selected = _loc2_[0] != 0;
         UnknownVarFromAvatarSaysSomething_CheckboxGroupPreset_1.get(1).selected = _loc2_[2] != 0;
         UnknownVarFromAvatarSaysSomething_RadioGroupPreset_1.selected = _loc2_[1];
         onTriggerTypeChange(UnknownVarFromAvatarSaysSomething_RadioGroupPreset_1.selected);
      }
      
      private function onTriggerTypeChange(param1:int) : void
      {
         Util.disableSection(UnknownVarFromAvatarSaysSomething_TextInputPreset_1.window,param1 == 2);
      }
   }
}

