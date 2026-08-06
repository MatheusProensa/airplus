package com.sulake.core.window
{
   import com.sulake.core.window.utils.IIterable;
   import flash.geom.Point;
   
   public interface IWindowController_1 extends IWindowModel, IIterable
   {
      function get numChildren() : int;
      
      function addChild(param1:IWindowModel) : IWindowModel;
      
      function addChildAt(param1:IWindowModel, param2:int) : IWindowModel;
      
      function removeChild(param1:IWindowModel) : IWindowModel;
      
      function removeChildAt(param1:int) : IWindowModel;
      
      function setChildIndex(param1:IWindowModel, param2:int) : void;
      
      function swapChildren(param1:IWindowModel, param2:IWindowModel) : void;
      
      function swapChildrenAt(param1:int, param2:int) : void;
      
      function groupChildrenWithID(param1:uint, param2:Array, param3:int = 0) : uint;
      
      function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint;
      
      function getChildUnderPoint(param1:Point) : IWindowModel;
      
      function groupChildrenUnderPoint(param1:Point, param2:Array) : void;
   }
}

