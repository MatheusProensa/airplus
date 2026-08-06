package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   
   public interface IStaticBitmapWrapperWindow extends IWindowModel, UnknownICoreWindowUtils4
   {
      function get assetUri() : String;
      
      function set assetUri(param1:String) : void;
   }
}

