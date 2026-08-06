package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   
   public class TimeBasedCondition extends DefaultConditionType
   {
      private var UnknownVarFromTimeBasedCondition_String_1:String = "";
      
      private var _timezoneDropdown:DropdownPreset;
      
      private var UnknownVarFromTimeBasedCondition_SectionPreset_1:SectionPreset;
      
      private var _timezoneValues:Vector.<String>;
      
      public function TimeBasedCondition()
      {
         super();
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:String = param1.stringParam == "" ? UnknownVarFromTimeBasedCondition_String_1 : param1.stringParam;
         updateTimezoneOptions(_loc2_);
      }
      
      protected function createTimezoneSection(param1:PresetManager) : SectionPreset
      {
         _timezoneDropdown = param1.createDropdown(new DropdownParam(loc("wiredfurni.tooltip.timezone"),buildTimezoneOptions(UnknownVarFromTimeBasedCondition_String_1)));
         UnknownVarFromTimeBasedCondition_SectionPreset_1 = param1.createSection(l("time.timezone_selection"),_timezoneDropdown);
         UnknownVarFromTimeBasedCondition_SectionPreset_1.visible = _timezoneValues != null && _timezoneValues.length > 1;
         return UnknownVarFromTimeBasedCondition_SectionPreset_1;
      }
      
      private function updateTimezoneOptions(param1:String) : void
      {
         if(_timezoneDropdown == null)
         {
            buildTimezoneOptions(param1);
            return;
         }
         var _loc3_:Vector.<ExpandableDropdownOption> = buildTimezoneOptions(param1);
         var _loc2_:int = _loc3_.length > 0 ? 0 : -1;
         _timezoneDropdown.reinit(_loc3_,_loc2_);
         if(UnknownVarFromTimeBasedCondition_SectionPreset_1 != null)
         {
            UnknownVarFromTimeBasedCondition_SectionPreset_1.visible = _loc3_.length > 1;
         }
      }
      
      private function buildTimezoneOptions(param1:String) : Vector.<ExpandableDropdownOption>
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<String> = getTimezones(param1);
         _timezoneValues = _loc2_;
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.push(new ExpandableDropdownOption(_loc4_,_loc2_[_loc4_]));
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function getTimezones(param1:String) : Vector.<String>
      {
         var _loc6_:int = 0;
         var _loc5_:String = null;
         var _loc3_:IComponent_1 = roomEvents.roomEngine as IComponent_1;
         var _loc4_:String = _loc3_ == null ? null : _loc3_.getProperty("wired.timezones");
         var _loc2_:Array = _loc4_ == null || _loc4_ == "" ? ["UTC"] : _loc4_.split(",");
         var _loc7_:Vector.<String> = new Vector.<String>();
         if(param1 != "")
         {
            _loc7_.push(param1);
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc6_];
            if(_loc5_ != param1)
            {
               _loc7_.push(_loc5_);
            }
            _loc6_++;
         }
         return _loc7_;
      }
      
      override public function readStringParamFromForm() : String
      {
         if(_timezoneDropdown == null || _timezoneValues == null)
         {
            return "";
         }
         var _loc1_:int = _timezoneDropdown.selectedId;
         if(_loc1_ < 0 || _loc1_ >= _timezoneValues.length)
         {
            return "";
         }
         var _loc2_:String = _timezoneValues[_loc1_];
         UnknownVarFromTimeBasedCondition_String_1 = _loc2_;
         return _loc2_;
      }
   }
}

