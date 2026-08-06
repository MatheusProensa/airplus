package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public class SliderValueMilliseconds50 implements IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1
   {
      public function SliderValueMilliseconds50()
      {
         super();
      }
      
      public function toIntParam(param1:String) : int
      {
         return int(Number(param1) / 50);
      }
      
      public function toString(param1:int) : String
      {
         return "" + param1 * 50;
      }
      
      public function get precision() : int
      {
         return -1;
      }
      
      public function get endsWithFive() : Boolean
      {
         return true;
      }
   }
}

