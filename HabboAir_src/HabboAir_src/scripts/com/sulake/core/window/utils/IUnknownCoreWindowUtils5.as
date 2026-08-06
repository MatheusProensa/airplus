package com.sulake.core.window.utils
{
   public interface IUnknownCoreWindowUtils5
   {
      function get numChildren() : int;
      
      function getChildAt(param1:int) : UnknownICoreWindowUtils3;
      
      function getChildByID(param1:int) : UnknownICoreWindowUtils3;
      
      function getChildByName(param1:String) : UnknownICoreWindowUtils3;
      
      function getChildIndex(param1:UnknownICoreWindowUtils3) : int;
      
      function groupChildrenWithID(param1:uint, param2:Array) : uint;
   }
}

