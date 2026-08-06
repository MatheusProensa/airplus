package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RemoveVariable extends DefaultActionType
   {
      private var _picker:VariablePickerPreset;
      
      private var _section1:SectionPreset;
      
      private var _mergedType:int = 0;
      
      public function RemoveVariable()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canCreateAndDelete;
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.REMOVE_VARIABLE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_mergedType);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_picker.finalizeSelection];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:String = param1.variableIds[0];
         _mergedType = param1.intParams[0];
         _picker.init(param1.wiredContext.roomVariablesList,_loc2_,_mergedType);
      }
      
      override public function onEditInitialized() : void
      {
         _section1.getSourceTypeSelector().select(_mergedType);
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:SourceTypeSelectorParam = new SourceTypeSelectorParam(mergedSourceOptions(0),createSourceTypeListener(0));
         _picker = param1.createVariablePicker(variableSelectionFilter);
         var _loc4_:SectionParam = new SectionParam(_loc5_);
         _section1 = param1.createSection(loc("wiredfurni.params.variables.variable_selection"),_picker,_loc4_);
         param3.addElements(_section1);
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
         _mergedType = param2;
         _picker.variableTarget = _mergedType;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return _mergedType;
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

