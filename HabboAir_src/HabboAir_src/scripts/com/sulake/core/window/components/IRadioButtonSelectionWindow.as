package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface IRadioButtonSelectionWindow extends IWindowController_1
   {
      function get selected() : IRadioButtonWindow;
      
      function radioButtonSelection(param1:IRadioButtonWindow) : void;
   }
}

