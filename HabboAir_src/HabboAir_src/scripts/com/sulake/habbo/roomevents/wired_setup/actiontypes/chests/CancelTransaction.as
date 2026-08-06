package com.sulake.habbo.roomevents.wired_setup.actiontypes.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.*;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CancelTransaction extends DefaultActionType
   {
      private var UnknownVarFromCancelTransaction_RadioGroupPreset_1:RadioGroupPreset;
      
      public function CancelTransaction()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.CANCEL_TRANSACTION;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromCancelTransaction_RadioGroupPreset_1.selected];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromCancelTransaction_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.cancel_transaction.usage_info}");
         UnknownVarFromCancelTransaction_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.cancel_transaction.match_criteria.0}"),new RadioButtonParam(1,"${wiredfurni.params.cancel_transaction.match_criteria.1}")],onChangeCancelMode);
         var _loc5_:SectionPreset = param1.createSection("${wiredfurni.params.cancel_transaction.match_criteria}",UnknownVarFromCancelTransaction_RadioGroupPreset_1);
         param3.addElements(_loc4_,_loc5_);
      }
      
      private function onChangeCancelMode(param1:int) : void
      {
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,0);
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1 && param1 == 0)
         {
            return UnknownVarFromCancelTransaction_RadioGroupPreset_1.selected == 1;
         }
         return false;
      }
   }
}

