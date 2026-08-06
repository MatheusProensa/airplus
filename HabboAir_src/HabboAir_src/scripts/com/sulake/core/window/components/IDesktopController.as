package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import flash.geom.Point;
   
   public interface IDesktopController extends IWindowController_1, IDisplayObjectWrapperController
   {
      function get mouseX() : int;
      
      function get mouseY() : int;
      
      function getActiveWindow() : IWindowModel;
      
      function setActiveWindow(param1:IWindowModel) : IWindowModel;
      
      function groupParameterFilteredChildrenUnderPoint(param1:Point, param2:Array, param3:uint = 0) : void;
   }
}

