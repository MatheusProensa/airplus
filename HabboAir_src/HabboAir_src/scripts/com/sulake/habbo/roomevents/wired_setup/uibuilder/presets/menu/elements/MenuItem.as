package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements
{
   public class MenuItem implements UnknownIHabboRoomeventsWired_SetupUibuilderPresetsMenuElements1
   {
      private var _name:String;
      
      private var _onClick:Function;
      
      private var _tooltip:String;
      
      private var _hasCheckbox:Boolean;
      
      private var _selectedChange:Function;
      
      public function MenuItem(param1:String, param2:Function, param3:String = "", param4:Boolean = false, param5:Function = null)
      {
         super();
         _name = param1;
         _onClick = param2;
         _tooltip = param3;
         _hasCheckbox = param4;
         _selectedChange = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get onClick() : Function
      {
         return _onClick;
      }
      
      public function get tooltip() : String
      {
         return _tooltip;
      }
      
      public function get hasCheckbox() : Boolean
      {
         return _hasCheckbox;
      }
      
      public function get selectedChange() : Function
      {
         return _selectedChange;
      }
   }
}

