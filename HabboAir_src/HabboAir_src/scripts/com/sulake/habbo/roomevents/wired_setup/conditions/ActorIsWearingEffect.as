package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ActorIsWearingEffect extends DefaultConditionType
   {
      private var UnknownVarFromActorIsWearingEffect_NumberInputPreset_1:NumberInputPreset;
      
      public function ActorIsWearingEffect()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.ACTOR_IS_WEARING_EFFECT;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_ACTOR_IS_WEARING_EFFECT;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromActorIsWearingEffect_NumberInputPreset_1 = param1.createNumberInput(new NumberInputParam(0,-2147483648,2147483647,200,0,false,false,loc("wiredfurni.tooltip.effectid")));
         var _loc4_:SectionPreset = param1.createSection(l("effectid"),UnknownVarFromActorIsWearingEffect_NumberInputPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromActorIsWearingEffect_NumberInputPreset_1.value];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromActorIsWearingEffect_NumberInputPreset_1.value = param1.intParams[0];
      }
   }
}

