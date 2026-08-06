package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   
   public interface IInputProcessorRoot extends IWindowModel
   {
      function process(param1:WindowEvent) : Boolean;
   }
}

