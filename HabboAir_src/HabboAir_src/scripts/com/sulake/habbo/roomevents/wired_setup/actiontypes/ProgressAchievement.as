package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ProgressAchievement extends DefaultActionType
   {
      private var _achievementDropdown:DropdownPreset;
      
      private var _progressionMode:RadioGroupPreset;
      
      private var UnknownVarFromProgressAchievement_ValueOrVariableSection_1:ValueOrVariableSection;
      
      public function ProgressAchievement()
      {
         super();
      }
      
      override public function get negativeCode() : int
      {
         return ActionTypeCodes.PROGRESS_ACHIEVEMENT;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_progressionMode.selected);
         _loc1_.push(UnknownVarFromProgressAchievement_ValueOrVariableSection_1.option);
         _loc1_.push(UnknownVarFromProgressAchievement_ValueOrVariableSection_1.numberValue);
         _loc1_.push(UnknownVarFromProgressAchievement_ValueOrVariableSection_1.target);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         return achievementName;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromProgressAchievement_ValueOrVariableSection_1.finalizeSelection];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         initializeDropdownOptions();
         achievementName = param1.stringParam;
         _progressionMode.selected = param1.getInt(0);
         var _loc3_:String = param1.variableIds[0];
         var _loc2_:int = param1.getInt(1);
         var _loc5_:int = param1.getInt(2);
         var _loc4_:int = param1.getInt(3);
         UnknownVarFromProgressAchievement_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc3_,_loc4_,_loc2_,_loc5_);
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromProgressAchievement_ValueOrVariableSection_1.onEditInitialized();
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _achievementDropdown = param1.createDropdown(new DropdownParam("${wiredfurni.params.progress_achievement.name}"));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.progress_achievement.name}",_achievementDropdown);
         _progressionMode = param1.createRadioGroup([new RadioButtonParam(1,"${wiredfurni.params.progress_achievement.mode.1}"),new RadioButtonParam(0,"${wiredfurni.params.progress_achievement.mode.0}")]);
         var _loc5_:SectionPreset = param1.createSection("${wiredfurni.params.progress_achievement.mode}",_progressionMode);
         UnknownVarFromProgressAchievement_ValueOrVariableSection_1 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),"${wiredfurni.params.progress_achievement.score}",0,2147483647);
         param3.addElements(_loc4_,_loc5_,UnknownVarFromProgressAchievement_ValueOrVariableSection_1);
      }
      
      private function initializeDropdownOptions() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         var _loc1_:Vector.<String> = roomEvents.achievementsInRoom;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_.push(new ExpandableDropdownOption(_loc3_,_loc1_[_loc3_]));
            _loc3_ += 1;
         }
         _achievementDropdown.reinit(_loc2_,-1);
      }
      
      private function set achievementName(param1:String) : void
      {
         for each(var _loc2_ in _achievementDropdown.dropdownOptions)
         {
            if(_loc2_.displayString == param1)
            {
               _achievementDropdown.selectedId = _loc2_.id;
               return;
            }
         }
         _achievementDropdown.selectedId = -1;
      }
      
      private function get achievementName() : String
      {
         return _achievementDropdown.selected?.displayString;
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,1]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromProgressAchievement_ValueOrVariableSection_1.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromProgressAchievement_ValueOrVariableSection_1.target;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE)
         {
            return UnknownVarFromProgressAchievement_ValueOrVariableSection_1.isSourcePickingDisabled();
         }
         return false;
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

