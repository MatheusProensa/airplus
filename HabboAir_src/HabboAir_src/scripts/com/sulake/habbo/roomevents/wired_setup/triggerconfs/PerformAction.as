package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.WiredUserAction;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PerformAction extends DefaultTriggerConf
   {
      private static const SIGN_ACTION_CODE:int = 10;
      
      private static const DANCE_ACTION_CODE:int = 11;
      
      private var _actionDropdown:DropdownPreset;
      
      private var UnknownVarFromPerformAction_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var UnknownVarFromPerformAction_CheckboxGroupPreset_2:CheckboxGroupPreset;
      
      private var _signDropdown:DropdownPreset;
      
      private var _danceDropdown:DropdownPreset;
      
      private var UnknownVarFromPerformAction_SectionPreset_1:SectionPreset;
      
      private var UnknownVarFromPerformAction_SectionPreset_2:SectionPreset;
      
      public function PerformAction()
      {
         super();
      }
      
      private static function getActionByCode(param1:int) : WiredUserAction
      {
         var _loc3_:int = 0;
         var _loc4_:WiredUserAction = null;
         var _loc2_:Vector.<WiredUserAction> = WiredUserAction.allWiredUserActions;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(param1 == _loc4_.code)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.UnknownVarFromTriggerConfCodes_Int_3;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _actionDropdown.selectedId = param1.intParams[0];
         updateExtraSections(param1.stringParam);
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:int = 0;
         var _loc2_:WiredUserAction = getSelectedAction();
         if(_loc2_ != null && _loc2_.hasExtra)
         {
            _loc1_ = getSelectedExtraCode(_loc2_.code);
            if(_loc1_ != -1)
            {
               return _loc2_.convertCodeToExtraString(_loc1_);
            }
         }
         return "";
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:WiredUserAction = getSelectedAction();
         _loc1_.push(_loc2_?.code);
         return _loc1_;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _actionDropdown = param1.createDropdown(new DropdownParam(loc("wiredfurni.tooltip.action"),buildActionOptions(),onActionSelected));
         var _loc4_:SectionPreset = param1.createSection(l("action_selection"),_actionDropdown);
         _signDropdown = param1.createDropdown(new DropdownParam(loc("wiredfurni.tooltip.sign"),buildSignOptions()));
         var _loc6_:CheckboxOptionParam = new CheckboxOptionParam(l("sign_filter"),0);
         _loc6_.extra2 = _signDropdown;
         UnknownVarFromPerformAction_CheckboxGroupPreset_1 = param1.createCheckboxGroup([_loc6_]);
         UnknownVarFromPerformAction_SectionPreset_1 = param1.createSection(l("sign_selection"),UnknownVarFromPerformAction_CheckboxGroupPreset_1);
         _danceDropdown = param1.createDropdown(new DropdownParam(loc("wiredfurni.tooltip.dance"),buildDanceOptions()));
         var _loc5_:CheckboxOptionParam = new CheckboxOptionParam(l("dance_filter"),0);
         _loc5_.extra2 = _danceDropdown;
         UnknownVarFromPerformAction_CheckboxGroupPreset_2 = param1.createCheckboxGroup([_loc5_]);
         UnknownVarFromPerformAction_SectionPreset_2 = param1.createSection(l("dance_selection"),UnknownVarFromPerformAction_CheckboxGroupPreset_2);
         UnknownVarFromPerformAction_SectionPreset_1.visible = false;
         UnknownVarFromPerformAction_SectionPreset_2.visible = false;
         param3.addElements(_loc4_,UnknownVarFromPerformAction_SectionPreset_1,UnknownVarFromPerformAction_SectionPreset_2);
      }
      
      private function onActionSelected(param1:ExpandableDropdownOption) : void
      {
         updateExtraSections();
      }
      
      private function updateExtraSections(param1:String = "") : void
      {
         var _loc2_:WiredUserAction = getSelectedAction();
         if(_loc2_ == null || !_loc2_.hasExtra)
         {
            UnknownVarFromPerformAction_SectionPreset_1.visible = false;
            UnknownVarFromPerformAction_SectionPreset_2.visible = false;
            return;
         }
         var _loc4_:* = _loc2_.code == 10;
         var _loc3_:* = _loc2_.code == 11;
         UnknownVarFromPerformAction_SectionPreset_1.visible = _loc4_;
         UnknownVarFromPerformAction_SectionPreset_2.visible = _loc3_;
         if(_loc4_)
         {
            if(param1 == "")
            {
               UnknownVarFromPerformAction_CheckboxGroupPreset_1.get(0).selected = false;
               _signDropdown.selectedId = -1;
            }
            else
            {
               UnknownVarFromPerformAction_CheckboxGroupPreset_1.get(0).selected = true;
               _signDropdown.selectedId = _loc2_.convertExtraStringToCode(param1);
            }
         }
         if(_loc3_)
         {
            if(param1 == "")
            {
               UnknownVarFromPerformAction_CheckboxGroupPreset_2.get(0).selected = false;
               _danceDropdown.selectedId = -1;
            }
            else
            {
               UnknownVarFromPerformAction_CheckboxGroupPreset_2.get(0).selected = true;
               _danceDropdown.selectedId = _loc2_.convertExtraStringToCode(param1);
            }
         }
      }
      
      private function getSelectedAction() : WiredUserAction
      {
         return getActionByCode(_actionDropdown.selectedId);
      }
      
      private function getSelectedExtraCode(param1:int) : int
      {
         if(param1 == 10)
         {
            return UnknownVarFromPerformAction_CheckboxGroupPreset_1.get(0).selected ? _signDropdown.selectedId : -1;
         }
         if(param1 == 11)
         {
            return UnknownVarFromPerformAction_CheckboxGroupPreset_2.get(0).selected ? _danceDropdown.selectedId : -1;
         }
         return -1;
      }
      
      private function buildActionOptions() : Vector.<ExpandableDropdownOption>
      {
         var _loc2_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         var _loc1_:Vector.<WiredUserAction> = WiredUserAction.allWiredUserActions;
         for each(var _loc3_ in _loc1_)
         {
            _loc2_.push(new ExpandableDropdownOption(_loc3_.code,l("action." + _loc3_.code)));
         }
         return _loc2_;
      }
      
      private function buildSignOptions() : Vector.<ExpandableDropdownOption>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc2_ = 0;
         while(_loc2_ <= 17)
         {
            _loc1_.push(new ExpandableDropdownOption(_loc2_,l("action.sign." + _loc2_)));
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function buildDanceOptions() : Vector.<ExpandableDropdownOption>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            _loc1_.push(new ExpandableDropdownOption(_loc2_,l("action.dance." + _loc2_)));
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

