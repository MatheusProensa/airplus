package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class StatesMatch extends DefaultConditionType
   {
      private var UnknownVarFromStatesMatch_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      public function StatesMatch()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.STATES_MATCH;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_STATES_MATCH;
      }
      
      override public function get hasStateSnapshot() : Boolean
      {
         return true;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromStatesMatch_CheckboxGroupPreset_1 = param1.createCheckboxGroup([new CheckboxOptionParam(l("condition.state")),new CheckboxOptionParam(l("condition.direction")),new CheckboxOptionParam(l("condition.position")),new CheckboxOptionParam(l("condition.altitude"))]);
         var _loc4_:SectionPreset = param1.createSection(l("conditions"),UnknownVarFromStatesMatch_CheckboxGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            UnknownVarFromStatesMatch_CheckboxGroupPreset_1.get(_loc2_).selected = param1.getBoolean(_loc2_);
            _loc2_++;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_.push(UnknownVarFromStatesMatch_CheckboxGroupPreset_1.get(_loc2_).selected ? 1 : 0);
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

