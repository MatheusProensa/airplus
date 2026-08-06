package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   
   public interface ITab extends IComponentInterfaceQueue
   {
      function get window() : IWindowController_1;
      
      function get selected() : Boolean;
      
      function get recycled() : Boolean;
      
      function select(param1:Boolean) : void;
      
      function deselect(param1:Boolean) : void;
      
      function recycle() : void;
   }
}

