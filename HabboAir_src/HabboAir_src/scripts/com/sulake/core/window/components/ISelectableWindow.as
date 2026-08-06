package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   
   public interface ISelectableWindow extends IWindowModel
   {
      function get selector() : ISelectorWindow;
      
      function get isSelected() : Boolean;
      
      function set isSelected(param1:Boolean) : void;
      
      function select() : Boolean;
      
      function unselect() : Boolean;
   }
}

