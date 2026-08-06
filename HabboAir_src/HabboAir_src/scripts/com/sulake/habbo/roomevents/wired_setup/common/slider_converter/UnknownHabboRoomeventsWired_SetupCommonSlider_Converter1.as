package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public class UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1 implements IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1
   {
      public function UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1()
      {
         super();
      }
      
      public function toIntParam(param1:String) : int
      {
         return int(param1);
      }
      
      public function toString(param1:int) : String
      {
         return param1.toString();
      }
      
      public function get precision() : int
      {
         return 0;
      }
      
      public function get endsWithFive() : Boolean
      {
         return false;
      }
   }
}

