package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class NumberInputParam
   {
      public static var DEFAULT:TextInputParam = new TextInputParam();
      
      private var _initialValue:int;
      
      private var _min:int;
      
      private var _max:int;
      
      private var _width:int;
      
      private var _precision:int;
      
      private var _endsWithFive:Boolean;
      
      private var _nonDecimalNotations:Boolean;
      
      private var _tooltip:String;
      
      public function NumberInputParam(param1:int, param2:int, param3:int, param4:int = 45, param5:int = 0, param6:Boolean = false, param7:Boolean = false, param8:String = null)
      {
         super();
         _initialValue = param1;
         _min = param2;
         _max = param3;
         _precision = param5;
         _endsWithFive = param6;
         _width = param4;
         _nonDecimalNotations = param7;
         _tooltip = param8;
      }
      
      public function get initialValue() : int
      {
         return _initialValue;
      }
      
      public function get min() : int
      {
         return _min;
      }
      
      public function get max() : int
      {
         return _max;
      }
      
      public function get precision() : int
      {
         return _precision;
      }
      
      public function get endsWithFive() : Boolean
      {
         return _endsWithFive;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get nonDecimalNotations() : Boolean
      {
         return _nonDecimalNotations;
      }
      
      public function get tooltip() : String
      {
         return _tooltip;
      }
   }
}

