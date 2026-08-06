package com.sulake.habbo.window.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   
   public interface IModalDialog extends IComponentInterfaceQueue
   {
      function get rootWindow() : IWindowModel;
      
      function get background() : IBitmapWrapperController;
   }
}

