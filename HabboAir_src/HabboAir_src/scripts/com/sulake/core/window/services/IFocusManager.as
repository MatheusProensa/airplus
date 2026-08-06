package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.ITextFieldController;
   
   public interface IFocusManager extends IComponentInterfaceQueue
   {
      function registerFocusWindow(param1:ITextFieldController) : void;
      
      function removeFocusWindow(param1:ITextFieldController) : void;
   }
}

