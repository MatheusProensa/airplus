package com.sulake.habbo.roomevents.wired_setup.addons
{
   public class ExecuteInOrder extends DefaultAddonType
   {
      public function ExecuteInOrder()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.EXECUTE_IN_ORDER;
      }
   }
}

