package com.sulake.habbo.roomevents.wired_setup
{
   public class ClipboardWiredEntry
   {
      private var _intParams:Array;
      
      private var _stringParam:String;
      
      private var _variableIds:Array;
      
      private var _stuffIds:Array;
      
      private var _stuffIds2:Array;
      
      private var _furniSourceTypes:Array;
      
      private var _userSourceTypes:Array;
      
      private var _delayInPulses:int = 0;
      
      private var _quantifierCode:int = 0;
      
      private var _isFilter:Boolean = false;
      
      private var _isInvert:Boolean = false;
      
      public function ClipboardWiredEntry(param1:Array, param2:String, param3:Array, param4:Array, param5:Array, param6:Array, param7:Array)
      {
         super();
         _intParams = param1;
         _stringParam = param2;
         _variableIds = param3;
         _stuffIds = param4;
         _stuffIds2 = param5;
         _furniSourceTypes = param6;
         _userSourceTypes = param7;
      }
      
      public function get intParams() : Array
      {
         return _intParams;
      }
      
      public function get stringParam() : String
      {
         return _stringParam;
      }
      
      public function get variableIds() : Array
      {
         return _variableIds;
      }
      
      public function get stuffIds() : Array
      {
         return _stuffIds;
      }
      
      public function get stuffIds2() : Array
      {
         return _stuffIds2;
      }
      
      public function get furniSourceTypes() : Array
      {
         return _furniSourceTypes;
      }
      
      public function get userSourceTypes() : Array
      {
         return _userSourceTypes;
      }
      
      public function get delayInPulses() : int
      {
         return _delayInPulses;
      }
      
      public function get quantifierCode() : int
      {
         return _quantifierCode;
      }
      
      public function get isFilter() : Boolean
      {
         return _isFilter;
      }
      
      public function get isInvert() : Boolean
      {
         return _isInvert;
      }
      
      public function set delayInPulses(param1:int) : void
      {
         _delayInPulses = param1;
      }
      
      public function set quantifierCode(param1:int) : void
      {
         _quantifierCode = param1;
      }
      
      public function set isFilter(param1:Boolean) : void
      {
         _isFilter = param1;
      }
      
      public function set isInvert(param1:Boolean) : void
      {
         _isInvert = param1;
      }
   }
}

