package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   
   public class DefaultAddonType extends DefaultElement implements UnknownIHabboRoomeventsWired_SetupAddons1
   {
      public function DefaultAddonType()
      {
         super();
      }
      
      public function get isFilter() : Boolean
      {
         return false;
      }
   }
}

