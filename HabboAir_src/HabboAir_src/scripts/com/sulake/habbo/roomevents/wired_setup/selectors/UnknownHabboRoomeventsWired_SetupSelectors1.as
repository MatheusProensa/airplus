package com.sulake.habbo.roomevents.wired_setup.selectors
{
   public class UnknownHabboRoomeventsWired_SetupSelectors1 extends DefaultSelectorType
   {
      public function UnknownHabboRoomeventsWired_SetupSelectors1()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.UnknownVarFromSelectorCodes_Int_1;
      }
      
      override public function get forceFurniSelection() : Boolean
      {
         return true;
      }
   }
}

