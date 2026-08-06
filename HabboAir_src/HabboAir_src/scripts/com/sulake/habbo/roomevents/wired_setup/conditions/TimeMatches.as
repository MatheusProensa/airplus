package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldRangeFilter;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.ChronoRangeFilterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TimeMatches extends TimeBasedCondition
   {
      private static var SECONDS_CONTAINER_NAME:String = "second";
      
      private static var MINUTES_CONTAINER_NAME:String = "minute";
      
      private static var HOURS_CONTAINER_NAME:String = "hour";
      
      private var UnknownVarFromTimeMatches_ChronoRangeFilterPreset_1:ChronoRangeFilterPreset;
      
      private var UnknownVarFromTimeMatches_ChronoRangeFilterPreset_2:ChronoRangeFilterPreset;
      
      private var UnknownVarFromTimeMatches_ChronoRangeFilterPreset_3:ChronoRangeFilterPreset;
      
      public function TimeMatches()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.TIME_MATCHES;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:String = l("time.skip");
         var _loc6_:String = l("time.exact");
         var _loc9_:String = l("time.range");
         UnknownVarFromTimeMatches_ChronoRangeFilterPreset_3 = param1.createChronoRangeFilter(_loc4_,_loc6_,_loc9_,0,0,23,25);
         UnknownVarFromTimeMatches_ChronoRangeFilterPreset_2 = param1.createChronoRangeFilter(_loc4_,_loc6_,_loc9_,0,0,59,25);
         UnknownVarFromTimeMatches_ChronoRangeFilterPreset_1 = param1.createChronoRangeFilter(_loc4_,_loc6_,_loc9_,0,0,59,25);
         var _loc8_:SectionPreset = param1.createSection(l("time.hour_selection"),UnknownVarFromTimeMatches_ChronoRangeFilterPreset_3);
         var _loc10_:SectionPreset = param1.createSection(l("time.minute_selection"),UnknownVarFromTimeMatches_ChronoRangeFilterPreset_2);
         var _loc5_:SectionPreset = param1.createSection(l("time.second_selection"),UnknownVarFromTimeMatches_ChronoRangeFilterPreset_1);
         var _loc7_:SectionPreset = createTimezoneSection(param1);
         param3.addElements(_loc8_,_loc10_,_loc5_,_loc7_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc9_:int = int(param1.intParams[0]);
         var _loc7_:int = int(param1.intParams[1]);
         var _loc2_:int = int(param1.intParams[2]);
         var _loc3_:int = int(param1.intParams[3]);
         var _loc10_:int = int(param1.intParams[4]);
         var _loc5_:int = int(param1.intParams[5]);
         var _loc8_:int = int(param1.intParams[6]);
         var _loc4_:int = int(param1.intParams[7]);
         var _loc6_:int = int(param1.intParams[8]);
         UnknownVarFromTimeMatches_ChronoRangeFilterPreset_1.applyFilter(new ChronoFieldRangeFilter(SECONDS_CONTAINER_NAME,_loc9_ == 1,_loc3_,_loc10_,0));
         UnknownVarFromTimeMatches_ChronoRangeFilterPreset_2.applyFilter(new ChronoFieldRangeFilter(MINUTES_CONTAINER_NAME,_loc7_ == 1,_loc5_,_loc8_,0));
         UnknownVarFromTimeMatches_ChronoRangeFilterPreset_3.applyFilter(new ChronoFieldRangeFilter(HOURS_CONTAINER_NAME,_loc2_ == 1,_loc4_,_loc6_,0));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:ChronoFieldRangeFilter = UnknownVarFromTimeMatches_ChronoRangeFilterPreset_1.getFilter(SECONDS_CONTAINER_NAME);
         var _loc4_:ChronoFieldRangeFilter = UnknownVarFromTimeMatches_ChronoRangeFilterPreset_2.getFilter(MINUTES_CONTAINER_NAME);
         var _loc2_:ChronoFieldRangeFilter = UnknownVarFromTimeMatches_ChronoRangeFilterPreset_3.getFilter(HOURS_CONTAINER_NAME);
         _loc1_.push(_loc3_.useFilter ? 1 : 0);
         _loc1_.push(_loc4_.useFilter ? 1 : 0);
         _loc1_.push(_loc2_.useFilter ? 1 : 0);
         _loc1_.push(_loc3_.min);
         _loc1_.push(_loc3_.max);
         _loc1_.push(_loc4_.min);
         _loc1_.push(_loc4_.max);
         _loc1_.push(_loc2_.min);
         _loc1_.push(_loc2_.max);
         return _loc1_;
      }
   }
}

