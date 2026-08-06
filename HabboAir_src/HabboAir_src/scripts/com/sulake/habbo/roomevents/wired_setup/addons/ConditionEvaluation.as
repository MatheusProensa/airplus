package com.sulake.habbo.roomevents.wired_setup.addons
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
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ConditionEvaluation extends DefaultAddonType
   {
      private static var UnknownVarFromConditionEvaluation_Int_1:int = 4;
      
      private static var _compareTypes:int = 3;
      
      private var UnknownVarFromConditionEvaluation_UsageInfoSection_1:UsageInfoSection;
      
      private var UnknownVarFromConditionEvaluation_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromConditionEvaluation_Vector_1:Vector.<NumberInputPreset>;
      
      public function ConditionEvaluation()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.CONDITION_EVALUATION;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _compareTypes)
         {
            UnknownVarFromConditionEvaluation_Vector_1[_loc3_].value = 0;
            _loc3_++;
         }
         var _loc4_:int = int(param1.intParams[0]);
         if(_loc4_ == -1)
         {
            _loc2_ = int(param1.intParams[1]);
            _loc5_ = int(param1.intParams[2]);
            _loc4_ = UnknownVarFromConditionEvaluation_Int_1 + _loc2_;
            if(_loc2_ >= 0 && _loc2_ < UnknownVarFromConditionEvaluation_Vector_1.length)
            {
               UnknownVarFromConditionEvaluation_Vector_1[_loc2_].value = _loc5_;
            }
         }
         UnknownVarFromConditionEvaluation_RadioGroupPreset_1.selected = _loc4_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:int = UnknownVarFromConditionEvaluation_RadioGroupPreset_1.selected;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_loc3_ >= UnknownVarFromConditionEvaluation_Int_1)
         {
            _loc2_ = _loc3_ - UnknownVarFromConditionEvaluation_Int_1;
            _loc4_ = UnknownVarFromConditionEvaluation_Vector_1[_loc2_].value;
            _loc3_ = -1;
         }
         _loc1_.push(_loc3_);
         _loc1_.push(_loc2_);
         _loc1_.push(_loc4_);
         return _loc1_;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:int = 0;
         UnknownVarFromConditionEvaluation_UsageInfoSection_1 = param1.createUsageInfoSection(l("cond_eval.note"));
         UnknownVarFromConditionEvaluation_Vector_1 = new Vector.<NumberInputPreset>();
         _loc4_ = 0;
         while(_loc4_ < _compareTypes)
         {
            UnknownVarFromConditionEvaluation_Vector_1.push(param1.createNumberInput(new NumberInputParam(0,0,1000,35,0,false,false)));
            _loc4_++;
         }
         UnknownVarFromConditionEvaluation_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("eval_mode.0")),new RadioButtonParam(1,l("eval_mode.1")),new RadioButtonParam(2,l("eval_mode.2")),new RadioButtonParam(3,l("eval_mode.3")),new RadioButtonParam(4,l("eval_mode.cmp.0"),UnknownVarFromConditionEvaluation_Vector_1[0]),new RadioButtonParam(5,l("eval_mode.cmp.1"),UnknownVarFromConditionEvaluation_Vector_1[1]),new RadioButtonParam(6,l("eval_mode.cmp.2"),UnknownVarFromConditionEvaluation_Vector_1[2])]);
         var _loc5_:SectionPreset = param1.createSection(l("eval_mode"),UnknownVarFromConditionEvaluation_RadioGroupPreset_1);
         param3.addElements(UnknownVarFromConditionEvaluation_UsageInfoSection_1,_loc5_);
      }
   }
}

