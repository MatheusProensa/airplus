package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GiveEffect extends DefaultActionType
   {
      private var UnknownVarFromGiveEffect_NumberInputPreset_1:NumberInputPreset;
      
      private var _priority:NumberInputPreset;
      
      private var UnknownVarFromGiveEffect_RadioGroupPreset_1:RadioGroupPreset;
      
      public function GiveEffect()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.GIVE_EFFECT;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromGiveEffect_NumberInputPreset_1 = param1.createNumberInput(new NumberInputParam(13,0,10000));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.give_effect.id}",UnknownVarFromGiveEffect_NumberInputPreset_1);
         _priority = param1.createNumberInput(new NumberInputParam(2,0,2));
         var _loc5_:SectionPreset = param1.createSection("${wiredfurni.params.give_effect.priority}",_priority);
         UnknownVarFromGiveEffect_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.give_effect.type.0}"),new RadioButtonParam(1,"${wiredfurni.params.give_effect.type.1}")],null,2);
         var _loc6_:SectionPreset = param1.createSection("${wiredfurni.params.give_effect.type}",UnknownVarFromGiveEffect_RadioGroupPreset_1);
         param3.addElements(_loc4_,_loc5_,_loc6_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromGiveEffect_NumberInputPreset_1.value = param1.getInt(0);
         _priority.value = param1.getInt(1);
         UnknownVarFromGiveEffect_RadioGroupPreset_1.selected = param1.getBoolean(2) ? 1 : 0;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromGiveEffect_NumberInputPreset_1.value,_priority.value,UnknownVarFromGiveEffect_RadioGroupPreset_1.selected];
      }
   }
}

