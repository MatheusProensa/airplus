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
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderTypeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariablePlaceholderModeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VariablePlaceholderAddon extends DefaultAddonType
   {
      private var UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1:PlaceholderNameSection;
      
      private var UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1:ChooseVariableSection;
      
      private var UnknownVarFromVariablePlaceholderAddon_VariablePlaceholderModeSection_1:VariablePlaceholderModeSection;
      
      private var UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1:PlaceholderTypeSection;
      
      private var UnknownVarFromVariablePlaceholderAddon_WiredVariable_1:WiredVariable;
      
      public function VariablePlaceholderAddon()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
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
         return AddonCodes.VARIABLE_PLACEHOLDER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1 = param1.createPlaceholderNameSection(l("texts.placeholder_name"),"$");
         UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1 = param1.createChooseVariableSection(0,mergedSourceOptions(0),variableSelectionFilter,onChangeVariable);
         UnknownVarFromVariablePlaceholderAddon_VariablePlaceholderModeSection_1 = param1.createVariablePlaceholderModeSection(l("texts.variable_display_type"));
         UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1 = param1.createPlaceholderTypeSection();
         param3.addElements(UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1,UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1,UnknownVarFromVariablePlaceholderAddon_VariablePlaceholderModeSection_1,UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc3_:Array = param1.stringParam.split("\t");
         var _loc5_:String = _loc3_[0];
         var _loc4_:String = _loc3_.length > 1 ? _loc3_[1] : "";
         var _loc7_:String = param1.variableIds[0];
         var _loc8_:Boolean = param1.getBoolean(0);
         var _loc2_:int = param1.getInt(1);
         var _loc6_:Boolean = param1.getBoolean(2);
         UnknownVarFromVariablePlaceholderAddon_VariablePlaceholderModeSection_1.isTextMode = _loc6_;
         UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1.placeholderName = _loc5_;
         UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple = _loc8_;
         UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1.delimiter = _loc4_;
         UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc7_,_loc2_);
         UnknownVarFromVariablePlaceholderAddon_WiredVariable_1 = UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.selected;
         onChangeVariable(UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.selected);
         updateMultipleOptionVisibility();
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.onEditInitialized();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple ? 1 : 0,UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.target,UnknownVarFromVariablePlaceholderAddon_VariablePlaceholderModeSection_1.isTextMode ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         if(!UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple)
         {
            return UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1.placeholderName;
         }
         return UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1.placeholderName + "\t" + UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1.delimiter;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.finalizeSelection];
      }
      
      private function onChangeVariable(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 == null || !param1.hasTextConnector;
         UnknownVarFromVariablePlaceholderAddon_VariablePlaceholderModeSection_1.get(1).disabled = _loc2_;
         if(_loc2_)
         {
            UnknownVarFromVariablePlaceholderAddon_VariablePlaceholderModeSection_1.isTextMode = false;
         }
         if(UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1.placeholderName == "" || UnknownVarFromVariablePlaceholderAddon_WiredVariable_1 != null && prettifiedName(UnknownVarFromVariablePlaceholderAddon_WiredVariable_1) == UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1.placeholderName)
         {
            UnknownVarFromVariablePlaceholderAddon_PlaceholderNameSection_1.placeholderName = prettifiedName(param1);
         }
         UnknownVarFromVariablePlaceholderAddon_WiredVariable_1 = param1;
      }
      
      private function updateMultipleOptionVisibility() : void
      {
         var _loc1_:Boolean = UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.target == VariableExtraSourceTypes.CONTEXT_SOURCE || UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.target == VariableExtraSourceTypes.GLOBAL_SOURCE;
         UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1.get(1).disabled = _loc1_;
         if(_loc1_)
         {
            UnknownVarFromVariablePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple = false;
         }
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.target = param2;
         updateMultipleOptionVisibility();
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromVariablePlaceholderAddon_ChooseVariableSection_1.target;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
   }
}

