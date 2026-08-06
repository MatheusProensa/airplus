package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   
   public class UnknownHabboRoomeventsWired_SetupSelectors2 extends WithVariable
   {
      public function UnknownHabboRoomeventsWired_SetupSelectors2()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.UnknownVarFromSelectorCodes_Int_4;
      }
      
      override protected function get variableSource() : int
      {
         return WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
      }
   }
}

