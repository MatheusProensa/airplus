package com.sulake.core.window
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.utils.IIterable;
   
   public interface IWindowController_2 extends IComponentInterfaceQueue, IIterable
   {
      function get properties() : Array;
      
      function set properties(param1:Array) : void;
   }
}

