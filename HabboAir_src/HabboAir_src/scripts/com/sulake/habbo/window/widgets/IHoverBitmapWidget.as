package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   
   public interface IHoverBitmapWidget extends IWindowController_2
   {
      function get bitmapWrapper() : IStaticBitmapWrapperWindow;
      
      function get normalAsset() : String;
      
      function set normalAsset(param1:String) : void;
      
      function get hoverAsset() : String;
      
      function set hoverAsset(param1:String) : void;
   }
}

