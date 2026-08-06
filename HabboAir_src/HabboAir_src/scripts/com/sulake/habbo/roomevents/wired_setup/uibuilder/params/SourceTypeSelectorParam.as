package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   
   public class SourceTypeSelectorParam
   {
      private var _ids:Array;
      
      private var _currentSelection:int;
      
      private var _listener:IWiredInputSourcePicker;
      
      public function SourceTypeSelectorParam(param1:Array, param2:IWiredInputSourcePicker, param3:int = 0)
      {
         super();
         _ids = param1;
         _currentSelection = param3;
         _listener = param2;
      }
      
      public function get ids() : Array
      {
         return _ids;
      }
      
      public function get currentSelection() : int
      {
         return _currentSelection;
      }
      
      public function get listener() : IWiredInputSourcePicker
      {
         return _listener;
      }
   }
}

