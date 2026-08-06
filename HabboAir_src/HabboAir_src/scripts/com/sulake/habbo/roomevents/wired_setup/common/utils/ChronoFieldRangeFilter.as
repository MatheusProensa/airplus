package com.sulake.habbo.roomevents.wired_setup.common.utils
{
   public class ChronoFieldRangeFilter
   {
      private var _name:String;
      
      private var _useFilter:Boolean;
      
      private var _min:int;
      
      private var _max:int;
      
      private var _defaultValue:int;
      
      public function ChronoFieldRangeFilter(param1:String, param2:Boolean, param3:int, param4:int, param5:int = 0)
      {
         super();
         this._name = param1;
         this._useFilter = param2;
         this._min = param3;
         this._max = param4;
         this._defaultValue = param5;
      }
      
      public function get defaultValue() : int
      {
         return _defaultValue;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get useFilter() : Boolean
      {
         return _useFilter;
      }
      
      public function get min() : int
      {
         return _min;
      }
      
      public function get max() : int
      {
         return _max;
      }
   }
}

