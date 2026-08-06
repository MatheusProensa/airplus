package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.interfaces
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.UnknownIHabboRoomeventsWired_SetupUibuilder1;
   
   public interface IListPreset extends UnknownIHabboRoomeventsWired_SetupUibuilder1
   {
      function get spacing() : int;
      
      function set spacing(param1:int) : void;
      
      function set backgroundColor(param1:uint) : void;
   }
}

