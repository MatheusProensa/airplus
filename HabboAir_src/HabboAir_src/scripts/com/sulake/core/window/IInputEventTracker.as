package com.sulake.core.window
{
   import com.sulake.core.window.events.WindowEvent;
   
   public interface IInputEventTracker
   {
      function eventReceived(param1:WindowEvent, param2:IWindowModel) : void;
   }
}

