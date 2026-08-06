package com.sulake.core.window.components
{
   public interface IHTMLTextController extends ITextFieldWindow
   {
      function set linkTarget(param1:String) : void;
      
      function get linkTarget() : String;
      
      function initializeLinkStyle() : void;
   }
}

