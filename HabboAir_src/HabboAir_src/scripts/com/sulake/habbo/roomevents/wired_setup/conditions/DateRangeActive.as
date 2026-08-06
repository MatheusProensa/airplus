package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.globalization.DateTimeFormatter;
   
   public class DateRangeActive extends DefaultConditionType
   {
      private static const UnknownConstFromDateRangeActive_String_1:String = "yyyy/MM/dd HH:mm";
      
      private var UnknownVarFromDateRangeActive_TextInputPreset_1:TextInputPreset;
      
      private var UnknownVarFromDateRangeActive_TextInputPreset_2:TextInputPreset;
      
      public function DateRangeActive()
      {
         super();
      }
      
      private static function parseDate(param1:String) : Number
      {
         return Date.parse(param1);
      }
      
      override public function get code() : int
      {
         return ConditionCodes.DATE_RANGE_ACTIVE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:String = "YYYY/MM/DD HH:MM";
         UnknownVarFromDateRangeActive_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",1000,null,-1,null,true,_loc5_));
         UnknownVarFromDateRangeActive_TextInputPreset_2 = param1.createTextInput(new TextInputParam("",1000,null,-1,null,true,_loc5_));
         var _loc6_:SectionPreset = param1.createSection(l("startdate"),UnknownVarFromDateRangeActive_TextInputPreset_1);
         var _loc4_:SectionPreset = param1.createSection(l("enddate"),UnknownVarFromDateRangeActive_TextInputPreset_2);
         param3.addElements(_loc6_,_loc4_);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc2_:Number = NaN;
         var _loc1_:Array = [];
         var _loc3_:Number = parseDate(UnknownVarFromDateRangeActive_TextInputPreset_1.text);
         if(!isNaN(_loc3_))
         {
            _loc1_.push(int(_loc3_ / 1000));
            _loc2_ = parseDate(UnknownVarFromDateRangeActive_TextInputPreset_2.text);
            if(!isNaN(_loc2_))
            {
               _loc1_.push(int(_loc2_ / 1000));
            }
         }
         return _loc1_;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc4_:Date = null;
         var _loc2_:Date = null;
         var _loc3_:DateTimeFormatter = new DateTimeFormatter("en-US");
         _loc3_.setDateTimePattern("yyyy/MM/dd HH:mm");
         if(param1.intParams.length > 0)
         {
            _loc4_ = new Date(param1.intParams[0] * 1000);
            UnknownVarFromDateRangeActive_TextInputPreset_1.text = _loc3_.format(_loc4_);
         }
         else
         {
            UnknownVarFromDateRangeActive_TextInputPreset_1.text = "";
         }
         if(param1.intParams.length > 1)
         {
            _loc2_ = new Date(param1.intParams[1] * 1000);
            UnknownVarFromDateRangeActive_TextInputPreset_2.text = _loc3_.format(_loc2_);
         }
         else
         {
            UnknownVarFromDateRangeActive_TextInputPreset_2.text = "";
         }
      }
   }
}

