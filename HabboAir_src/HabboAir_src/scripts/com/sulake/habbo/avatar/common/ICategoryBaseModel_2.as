package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface ICategoryBaseModel_2
   {
      function dispose() : void;
      
      function init() : void;
      
      function reset() : void;
      
      function getWindowContainer() : IWindowController_1;
      
      function switchCategory(param1:String) : void;
      
      function showPalettes(param1:String, param2:int) : void;
   }
}

