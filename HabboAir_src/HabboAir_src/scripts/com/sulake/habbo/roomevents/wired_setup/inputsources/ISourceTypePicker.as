package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   public interface ISourceTypePicker
   {
      function select(param1:int) : void;
      
      function initialize(param1:Array, param2:int) : void;
      
      function dispose() : void;
   }
}

