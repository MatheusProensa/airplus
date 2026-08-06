package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public class SliderValueHundredth implements IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1
   {
      public function SliderValueHundredth()
      {
         super();
      }
      
      public function toIntParam(param1:String) : int
      {
         return Math.round(Number(param1) * 100);
      }
      
      public function toString(param1:int) : String
      {
         return (param1 / 100).toFixed(2);
      }
      
      public function get precision() : int
      {
         return 2;
      }
      
      public function get endsWithFive() : Boolean
      {
         return false;
      }
   }
}

