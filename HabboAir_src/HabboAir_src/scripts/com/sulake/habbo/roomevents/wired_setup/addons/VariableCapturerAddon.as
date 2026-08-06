package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ChooseVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariablePlaceholderModeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VariableCapturerAddon extends DefaultAddonType
   {
      private var UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1:PlaceholderNameSection;
      
      private var UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1:ChooseVariableSection;
      
      private var UnknownVarFromVariableCapturerAddon_VariablePlaceholderModeSection_1:VariablePlaceholderModeSection;
      
      private var UnknownVarFromVariableCapturerAddon_WiredVariable_1:WiredVariable;
      
      public function VariableCapturerAddon()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue && param1.canCreateAndDelete && param1.canWriteValue;
      }
      
      public static function prettifiedName(param1:WiredVariable) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return Util.flatVariableName(param1);
      }
      
      override public function get code() : int
      {
         return AddonCodes.VARIABLE_CAPTURER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1 = param1.createPlaceholderNameSection(l("texts.capturer_name"),"#");
         UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1 = param1.createChooseVariableSection(0,null,variableSelectionFilter,onChangeVariable);
         UnknownVarFromVariableCapturerAddon_VariablePlaceholderModeSection_1 = param1.createVariablePlaceholderModeSection(l("texts.variable_input_type"));
         param3.addElements(UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1,UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1,UnknownVarFromVariableCapturerAddon_VariablePlaceholderModeSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         var _loc3_:String = _loc2_[0];
         var _loc5_:String = param1.variableIds[0];
         var _loc4_:Boolean = param1.getBoolean(0);
         UnknownVarFromVariableCapturerAddon_VariablePlaceholderModeSection_1.isTextMode = _loc4_;
         UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1.placeholderName = _loc3_;
         UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc5_,VariableExtraSourceTypes.CONTEXT_SOURCE);
         UnknownVarFromVariableCapturerAddon_WiredVariable_1 = UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1.selected;
         onChangeVariable(UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1.selected);
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1.onEditInitialized();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromVariableCapturerAddon_VariablePlaceholderModeSection_1.isTextMode ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1.placeholderName;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromVariableCapturerAddon_ChooseVariableSection_1.finalizeSelection];
      }
      
      private function onChangeVariable(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 == null || !param1.hasTextConnector;
         UnknownVarFromVariableCapturerAddon_VariablePlaceholderModeSection_1.get(1).disabled = _loc2_;
         if(_loc2_)
         {
            UnknownVarFromVariableCapturerAddon_VariablePlaceholderModeSection_1.isTextMode = false;
         }
         if(UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1.placeholderName == "" || UnknownVarFromVariableCapturerAddon_WiredVariable_1 != null && prettifiedName(UnknownVarFromVariableCapturerAddon_WiredVariable_1) == UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1.placeholderName)
         {
            UnknownVarFromVariableCapturerAddon_PlaceholderNameSection_1.placeholderName = prettifiedName(param1);
         }
         UnknownVarFromVariableCapturerAddon_WiredVariable_1 = param1;
      }
   }
}

