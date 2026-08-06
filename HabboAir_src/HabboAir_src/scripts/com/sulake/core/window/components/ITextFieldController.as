package com.sulake.core.window.components
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface ITextFieldController extends IComponentInterfaceQueue
   {
      function get focused() : Boolean;
      
      function focus() : Boolean;
      
      function unfocus() : Boolean;
   }
}

