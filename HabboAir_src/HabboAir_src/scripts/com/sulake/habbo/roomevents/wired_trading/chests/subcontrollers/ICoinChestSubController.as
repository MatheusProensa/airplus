package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   
   public interface ICoinChestSubController extends IComponentInterfaceQueue
   {
      function get type() : int;
      
      function get title() : String;
      
      function get view() : IWindowController_1;
      
      function get isEmpty() : Boolean;
      
      function get itemCount() : int;
      
      function clear() : void;
      
      function updateUI() : void;
      
      function get allowResizing() : Boolean;
   }
}

