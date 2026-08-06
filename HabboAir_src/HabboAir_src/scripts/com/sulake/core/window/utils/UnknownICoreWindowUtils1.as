package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface UnknownICoreWindowUtils1 extends IComponentInterfaceQueue
   {
      function set title(param1:String) : void;
      
      function get title() : String;
      
      function set summary(param1:String) : void;
      
      function get summary() : String;
      
      function set callback(param1:Function) : void;
      
      function get callback() : Function;
      
      function set titleBarColor(param1:uint) : void;
      
      function get titleBarColor() : uint;
      
      function getButtonCaption(param1:int) : IMouseCursorControl;
      
      function setButtonCaption(param1:int, param2:IMouseCursorControl) : void;
   }
}

