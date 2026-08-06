package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface IIssueBrowserView
   {
      function set visible(param1:Boolean) : void;
      
      function update() : void;
      
      function get view() : IWindowController_1;
   }
}

