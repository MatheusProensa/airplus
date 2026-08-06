package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class Reset extends DefaultActionType
   {
      public function Reset()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.RESET;
      }
      
      override public function get widthModifier() : Number
      {
         return 1.06;
      }
   }
}

