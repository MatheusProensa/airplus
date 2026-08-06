package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedTextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ProgressRewardTrack extends DefaultActionType
   {
      private static const UnknownConstFromProgressRewardTrack_String_1:String = "a-zA-Z0-9_";
      
      private var UnknownVarFromProgressRewardTrack_NamedTextInputPreset_1:NamedTextInputPreset;
      
      private var UnknownVarFromProgressRewardTrack_NamedTextInputPreset_2:NamedTextInputPreset;
      
      private var _addToExistingScore:CheckboxOptionPreset;
      
      private var UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1:ValueOrVariableSection;
      
      public function ProgressRewardTrack()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.PROGRESS_REWARD_TRACK;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromProgressRewardTrack_NamedTextInputPreset_1 = param1.createNamedTextInput(new TextInputParam("",100,null,-1,"a-zA-Z0-9_"),"${wiredfurni.params.reward_track.track_id}");
         UnknownVarFromProgressRewardTrack_NamedTextInputPreset_2 = param1.createNamedTextInput(new TextInputParam("",100,null,-1,"a-zA-Z0-9_"),"${wiredfurni.params.reward_track.task_id}");
         var _loc6_:SimpleListViewPreset = param1.createSimpleListView(true,[UnknownVarFromProgressRewardTrack_NamedTextInputPreset_1,UnknownVarFromProgressRewardTrack_NamedTextInputPreset_2]);
         var _loc5_:SectionPreset = param1.createSection("${wiredfurni.params.reward_track.progress.ids}",_loc6_);
         _addToExistingScore = param1.createCheckboxOption(new CheckboxOptionParam("${wiredfurni.params.reward_track.add_to_existing_score}"));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.reward_track.progress.mode}",_addToExistingScore);
         UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),"${wiredfurni.params.reward_track.score}",1,2147483647);
         param3.addElements(_loc5_,_loc4_,UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_addToExistingScore.selected ? 1 : 0);
         _loc1_.push(UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.option);
         _loc1_.push(UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.numberValue);
         _loc1_.push(UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.target);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromProgressRewardTrack_NamedTextInputPreset_1.text + "\t" + UnknownVarFromProgressRewardTrack_NamedTextInputPreset_2.text;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.finalizeSelection];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromProgressRewardTrack_NamedTextInputPreset_1.text = param1.getString(0);
         UnknownVarFromProgressRewardTrack_NamedTextInputPreset_2.text = param1.getString(1);
         _addToExistingScore.selected = param1.getBoolean(0);
         var _loc3_:String = param1.variableIds[0];
         var _loc2_:int = param1.getInt(1);
         var _loc5_:int = param1.getInt(2);
         var _loc4_:int = param1.getInt(3);
         if(_loc2_ == 0)
         {
            _loc3_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
         }
         UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc3_,_loc4_,_loc2_,_loc5_);
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.onEditInitialized();
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,1]];
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.target;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE)
         {
            return UnknownVarFromProgressRewardTrack_ValueOrVariableSection_1.isSourcePickingDisabled();
         }
         return false;
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

