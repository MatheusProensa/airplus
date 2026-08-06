package com.sulake.habbo.toolbar.abstractsubmenu
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import flash.geom.Rectangle;
   
   public interface IAbstractSubMenuController extends IComponentInterfaceQueue
   {
      function getIconPosition(param1:String) : Rectangle;
      
      function getIcon(param1:String) : IWindowModel;
      
      function getUnseenItemCounter(param1:String) : IWindowController_1;
      
      function setUnseenItemCount(param1:String, param2:int) : void;
      
      function toggleVisibility() : void;
      
      function reposition() : void;
   }
}

