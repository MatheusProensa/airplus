package com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown
{
   public class ExpandableDropdownOption
   {
      private var _id:int;
      
      private var _displayString:String;
      
      private var _isAdvanced:Boolean;
      
      public function ExpandableDropdownOption(param1:int, param2:String, param3:Boolean = false)
      {
         super();
         _id = param1;
         _displayString = param2;
         _isAdvanced = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get displayString() : String
      {
         return _displayString;
      }
      
      public function get isAdvanced() : Boolean
      {
         return _isAdvanced;
      }
   }
}

