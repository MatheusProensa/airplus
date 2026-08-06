package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldRangeFilter;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.ChronoMaskFilterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.ChronoRangeFilterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class DateMatches extends TimeBasedCondition
   {
      private var UnknownVarFromDateMatches_ChronoMaskFilterPreset_1:ChronoMaskFilterPreset;
      
      private var UnknownVarFromDateMatches_ChronoRangeFilterPreset_1:ChronoRangeFilterPreset;
      
      private var UnknownVarFromDateMatches_ChronoMaskFilterPreset_2:ChronoMaskFilterPreset;
      
      private var UnknownVarFromDateMatches_ChronoRangeFilterPreset_2:ChronoRangeFilterPreset;
      
      public function DateMatches()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.DATE_MATCHES;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:String = l("time.skip");
         var _loc5_:String = l("time.exact");
         var _loc10_:String = l("time.range");
         UnknownVarFromDateMatches_ChronoMaskFilterPreset_1 = param1.createChronoMaskFilter(buildWeekdayLabels(),2);
         UnknownVarFromDateMatches_ChronoRangeFilterPreset_1 = param1.createChronoRangeFilter(_loc4_,_loc5_,_loc10_,1,1,31,25);
         UnknownVarFromDateMatches_ChronoMaskFilterPreset_2 = param1.createChronoMaskFilter(buildMonthLabels(),3);
         UnknownVarFromDateMatches_ChronoRangeFilterPreset_2 = param1.createChronoRangeFilter(_loc4_,_loc5_,_loc10_,0,0,9999,35);
         var _loc8_:SectionPreset = param1.createSection(l("time.weekday_selection"),UnknownVarFromDateMatches_ChronoMaskFilterPreset_1);
         var _loc11_:SectionPreset = param1.createSection(l("time.day_selection"),UnknownVarFromDateMatches_ChronoRangeFilterPreset_1);
         var _loc7_:SectionPreset = param1.createSection(l("time.month_selection"),UnknownVarFromDateMatches_ChronoMaskFilterPreset_2);
         var _loc9_:SectionPreset = param1.createSection(l("time.year_selection"),UnknownVarFromDateMatches_ChronoRangeFilterPreset_2);
         var _loc6_:SectionPreset = createTimezoneSection(param1);
         param3.addElements(_loc8_,_loc11_,_loc7_,_loc9_,_loc6_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc8_:int = int(param1.intParams[0]);
         var _loc5_:int = int(param1.intParams[1]);
         var _loc6_:int = int(param1.intParams[2]);
         var _loc2_:int = int(param1.intParams[3]);
         var _loc7_:int = int(param1.intParams[4]);
         var _loc9_:int = int(param1.intParams[5]);
         var _loc3_:int = int(param1.intParams[6]);
         var _loc4_:int = int(param1.intParams[7]);
         UnknownVarFromDateMatches_ChronoMaskFilterPreset_1.mask = _loc6_;
         UnknownVarFromDateMatches_ChronoRangeFilterPreset_1.applyFilter(new ChronoFieldRangeFilter("day",_loc8_ == 1,_loc2_,_loc7_,1));
         UnknownVarFromDateMatches_ChronoMaskFilterPreset_2.mask = _loc9_;
         UnknownVarFromDateMatches_ChronoRangeFilterPreset_2.applyFilter(new ChronoFieldRangeFilter("year",_loc5_ == 1,_loc3_,_loc4_,0));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:ChronoFieldRangeFilter = UnknownVarFromDateMatches_ChronoRangeFilterPreset_1.getFilter("day");
         var _loc3_:ChronoFieldRangeFilter = UnknownVarFromDateMatches_ChronoRangeFilterPreset_2.getFilter("year");
         _loc1_.push(_loc2_.useFilter ? 1 : 0);
         _loc1_.push(_loc3_.useFilter ? 1 : 0);
         _loc1_.push(UnknownVarFromDateMatches_ChronoMaskFilterPreset_1.mask);
         _loc1_.push(_loc2_.min);
         _loc1_.push(_loc2_.max);
         _loc1_.push(UnknownVarFromDateMatches_ChronoMaskFilterPreset_2.mask);
         _loc1_.push(_loc3_.min);
         _loc1_.push(_loc3_.max);
         return _loc1_;
      }
      
      private function buildWeekdayLabels() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            _loc2_.push(l("time.weekday." + _loc1_));
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function buildMonthLabels() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc1_ = 1;
         while(_loc1_ <= 12)
         {
            _loc2_.push(l("time.month." + _loc1_));
            _loc1_++;
         }
         return _loc2_;
      }
   }
}

