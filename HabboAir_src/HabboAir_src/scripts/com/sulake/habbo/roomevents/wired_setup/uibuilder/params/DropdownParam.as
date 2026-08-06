package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   
   public class DropdownParam
   {
      private var _caption:String;
      
      private var _options:Vector.<ExpandableDropdownOption>;
      
      private var _showMoreLocalization:String;
      
      private var _onChangeCallback:Function;
      
      public function DropdownParam(param1:String, param2:Vector.<ExpandableDropdownOption> = null, param3:Function = null, param4:String = "")
      {
         super();
         _caption = param1;
         _options = param2;
         _onChangeCallback = param3;
         _showMoreLocalization = param4;
      }
      
      public function get onChangeCallback() : Function
      {
         return _onChangeCallback;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
      
      public function get options() : Vector.<ExpandableDropdownOption>
      {
         return _options;
      }
      
      public function get showMoreLocalization() : String
      {
         return _showMoreLocalization;
      }
   }
}

