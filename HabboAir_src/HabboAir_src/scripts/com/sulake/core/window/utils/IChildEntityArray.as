package com.sulake.core.window.utils
{
   public interface IChildEntityArray extends IUnknownCoreWindowUtils5
   {
      function addChild(param1:UnknownICoreWindowUtils3) : UnknownICoreWindowUtils3;
      
      function addChildAt(param1:UnknownICoreWindowUtils3, param2:int) : UnknownICoreWindowUtils3;
      
      function removeChild(param1:UnknownICoreWindowUtils3) : UnknownICoreWindowUtils3;
      
      function removeChildAt(param1:int) : UnknownICoreWindowUtils3;
      
      function setChildIndex(param1:UnknownICoreWindowUtils3, param2:int) : void;
      
      function swapChildren(param1:UnknownICoreWindowUtils3, param2:UnknownICoreWindowUtils3) : void;
      
      function swapChildrenAt(param1:int, param2:int) : void;
   }
}

