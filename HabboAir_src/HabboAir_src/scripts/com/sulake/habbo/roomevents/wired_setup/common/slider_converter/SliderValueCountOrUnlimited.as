package com.sulake.habbo.roomevents.wired_setup.common.slider_converter
{
   public class SliderValueCountOrUnlimited implements IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1
   {
      private var UnknownVarFromSliderValueCountOrUnlimited_Int_1:int;
      
      public function SliderValueCountOrUnlimited(param1:int)
      {
         super();
         UnknownVarFromSliderValueCountOrUnlimited_Int_1 = param1;
      }
      
      public function toIntParam(param1:String) : int
      {
         return int(Number(param1));
      }
      
      public function toString(param1:int) : String
      {
         if(param1 == UnknownVarFromSliderValueCountOrUnlimited_Int_1)
         {
            return "∞";
         }
         return "" + param1;
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

