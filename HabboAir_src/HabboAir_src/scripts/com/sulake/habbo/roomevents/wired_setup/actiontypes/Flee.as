package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class Flee extends DefaultActionType
   {
      public function Flee()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.FLEE;
      }
   }
}

