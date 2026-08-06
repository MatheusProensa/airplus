package com.sulake.core.window.services
{
   import flash.display.DisplayObject;
   
   public class WindowMouseDragger extends WindowMouseOperator implements IMouseDraggingService
   {
      public function WindowMouseDragger(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         _mouse.x = param1;
         _mouse.y = param2;
         getMousePositionRelativeTo(_window,_mouse,UnknownVarFromWindowMouseOperator_Point_1);
         _window.offset(UnknownVarFromWindowMouseOperator_Point_1.x - _offset.x,UnknownVarFromWindowMouseOperator_Point_1.y - _offset.y);
      }
   }
}

