package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public class SliderValueSeconds5 implements IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1
   {
      public function SliderValueSeconds5()
      {
         super();
      }
      
      public function toIntParam(param1:String) : int
      {
         return Math.round(Number(param1) / 5);
      }
      
      public function toString(param1:int) : String
      {
         return String(param1 * 5);
      }
      
      public function get precision() : int
      {
         return 0;
      }
      
      public function get endsWithFive() : Boolean
      {
         return true;
      }
   }
}

