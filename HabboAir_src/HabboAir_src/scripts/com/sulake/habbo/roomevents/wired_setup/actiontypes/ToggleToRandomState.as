package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class ToggleToRandomState extends DefaultActionType
   {
      public function ToggleToRandomState()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.TOGGLE_TO_RANDOM_STATE;
      }
   }
}

