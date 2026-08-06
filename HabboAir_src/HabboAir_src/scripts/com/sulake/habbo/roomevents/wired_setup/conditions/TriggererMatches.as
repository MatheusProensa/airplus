package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TriggererMatches extends DefaultConditionType
   {
      private var UnknownVarFromTriggererMatches_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromTriggererMatches_RadioGroupPreset_2:RadioGroupPreset;
      
      private var UnknownVarFromTriggererMatches_TextInputPreset_1:TextInputPreset;
      
      public function TriggererMatches()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.TRIGGERER_MATCHES;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_TRIGGERER_MATCHES;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromTriggererMatches_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("usertype.1")),new RadioButtonParam(2,l("usertype.2")),new RadioButtonParam(4,l("usertype.4"))]);
         var _loc4_:SectionPreset = param1.createSection(l("usertype"),UnknownVarFromTriggererMatches_RadioGroupPreset_1);
         UnknownVarFromTriggererMatches_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",32,null,-1,null,true,loc("wiredfurni.tooltip.avatarname")));
         UnknownVarFromTriggererMatches_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,l("anyavatar")),new RadioButtonParam(1,l("certainavatar"),null,UnknownVarFromTriggererMatches_TextInputPreset_1)]);
         var _loc5_:SectionPreset = param1.createSection(l("picktriggerer"),UnknownVarFromTriggererMatches_RadioGroupPreset_2);
         param3.addElements(_loc4_,_loc5_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromTriggererMatches_RadioGroupPreset_1.selected = param1.intParams[0];
         if(param1.stringParam != "")
         {
            UnknownVarFromTriggererMatches_RadioGroupPreset_2.selected = 1;
            UnknownVarFromTriggererMatches_TextInputPreset_1.text = param1.stringParam;
         }
         else
         {
            UnknownVarFromTriggererMatches_RadioGroupPreset_2.selected = 0;
            UnknownVarFromTriggererMatches_TextInputPreset_1.text = "";
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromTriggererMatches_RadioGroupPreset_1.selected];
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromTriggererMatches_RadioGroupPreset_2.selected == 1 ? UnknownVarFromTriggererMatches_TextInputPreset_1.text : "";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.match." + param1;
      }
   }
}

