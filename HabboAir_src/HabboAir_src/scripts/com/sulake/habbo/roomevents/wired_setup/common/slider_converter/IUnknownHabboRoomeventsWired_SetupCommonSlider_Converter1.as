package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public interface IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1
   {
      function toIntParam(param1:String) : int;
      
      function toString(param1:int) : String;
      
      function get precision() : int;
      
      function get endsWithFive() : Boolean;
   }
}

