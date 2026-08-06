package com.sulake.core.window.tools
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IProfilerOutput extends IComponentInterfaceQueue
   {
      function get caption() : String;
      
      function set visible(param1:Boolean) : void;
      
      function get visible() : Boolean;
   }
}

