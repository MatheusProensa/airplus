package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IProductIconWidget extends IWindowController_2
   {
      function set productInfo(param1:IProductDisplayInfo) : *;
      
      function get productInfo() : IProductDisplayInfo;
      
      function set blend(param1:Number) : *;
      
      function get blend() : Number;
      
      function set unknownImageUri(param1:String) : void;
   }
}

