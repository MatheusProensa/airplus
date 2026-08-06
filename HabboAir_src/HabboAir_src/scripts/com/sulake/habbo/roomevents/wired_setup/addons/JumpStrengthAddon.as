package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class JumpStrengthAddon extends DefaultAddonType
   {
      private var _section1:ValueOrVariableSection;
      
      public function JumpStrengthAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.JUMP_STRENGTH;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_section1.option);
         _loc1_.push(_section1.numberValue);
         _loc1_.push(_section1.target);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_section1.finalizeSelection];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:Array = param1.intParams;
         var _loc3_:String = param1.variableIds[0];
         var _loc6_:int = int(_loc2_[0]);
         var _loc4_:int = int(_loc2_[1]);
         var _loc5_:int = int(_loc2_[2]);
         if(_loc6_ == 0)
         {
            _loc3_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
         }
         else
         {
            _loc4_ = 80;
         }
         _section1.init(param1.wiredContext.roomVariablesList,_loc3_,_loc5_,_loc6_,_loc4_);
      }
      
      override public function onEditInitialized() : void
      {
         _section1.onEditInitialized();
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _section1 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),"${wiredfurni.params.jump_strength}",-1000,1000);
         param3.addElements(_section1);
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE)
         {
            return _section1.isSourcePickingDisabled();
         }
         return false;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         _section1.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return _section1.target;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
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

