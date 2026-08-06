package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class WindowMouseOperator implements IComponentInterfaceQueue
   {
      protected var UnknownVarFromWindowMouseOperator_DisplayObject_1:DisplayObject;
      
      protected var _window:WindowController;
      
      protected var _working:Boolean;
      
      protected var _offset:Point;
      
      protected var _mouse:Point;
      
      protected var UnknownVarFromWindowMouseOperator_Point_1:Point;
      
      protected var UnknownVarFromWindowMouseOperator_Uint_1:uint;
      
      private var _disposed:Boolean = false;
      
      public function WindowMouseOperator(param1:DisplayObject)
      {
         super();
         UnknownVarFromWindowMouseOperator_DisplayObject_1 = param1;
         UnknownVarFromWindowMouseOperator_Point_1 = new Point();
         _mouse = new Point();
         _offset = new Point();
         _working = false;
         UnknownVarFromWindowMouseOperator_Uint_1 = 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         end(_window);
         _offset = null;
         _mouse = null;
         UnknownVarFromWindowMouseOperator_Point_1 = null;
         UnknownVarFromWindowMouseOperator_DisplayObject_1 = null;
         _disposed = true;
      }
      
      public function begin(param1:IWindowModel, param2:uint = 0) : IWindowModel
      {
         UnknownVarFromWindowMouseOperator_Uint_1 = param2;
         var _loc3_:IWindowModel = _window;
         if(_window != null)
         {
            end(_window);
         }
         if(param1 && !param1.disposed)
         {
            UnknownVarFromWindowMouseOperator_DisplayObject_1.addEventListener("mouseDown",handler,false);
            UnknownVarFromWindowMouseOperator_DisplayObject_1.addEventListener("mouseUp",handler,false);
            UnknownVarFromWindowMouseOperator_DisplayObject_1.addEventListener("enterFrame",handler);
            _mouse.x = UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseX;
            _mouse.y = UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseY;
            _window = WindowController(param1);
            getMousePositionRelativeTo(param1,_mouse,_offset);
            _window.addEventListener("WE_DESTROYED",clientWindowDestroyed);
            _working = true;
         }
         return _loc3_;
      }
      
      public function end(param1:IWindowModel) : IWindowModel
      {
         var _loc2_:IWindowModel = _window;
         if(_working)
         {
            if(_window == param1)
            {
               UnknownVarFromWindowMouseOperator_DisplayObject_1.removeEventListener("mouseDown",handler,false);
               UnknownVarFromWindowMouseOperator_DisplayObject_1.removeEventListener("mouseUp",handler,false);
               UnknownVarFromWindowMouseOperator_DisplayObject_1.removeEventListener("enterFrame",handler);
               if(!_window.disposed)
               {
                  _window.removeEventListener("WE_DESTROYED",clientWindowDestroyed);
               }
               _window = null;
               _working = false;
            }
         }
         return _loc2_;
      }
      
      protected function handler(param1:Event) : void
      {
         var _loc2_:MouseEvent = null;
         if(_working)
         {
            if(param1.type == "enterFrame")
            {
               if(_window.disposed)
               {
                  end(_window);
               }
               else if(_mouse.x != UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseX || _mouse.y != UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseY)
               {
                  operate(UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseX,UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseY);
                  _mouse.x = UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseX;
                  _mouse.y = UnknownVarFromWindowMouseOperator_DisplayObject_1.mouseY;
               }
               return;
            }
            _loc2_ = param1 as MouseEvent;
            if(_loc2_ != null)
            {
               var _loc3_:* = _loc2_.type;
               if("mouseUp" === _loc3_)
               {
                  end(_window);
               }
            }
         }
      }
      
      public function operate(param1:int, param2:int) : void
      {
         _mouse.x = param1;
         _mouse.y = param2;
         getMousePositionRelativeTo(_window,_mouse,UnknownVarFromWindowMouseOperator_Point_1);
         _window.offset(UnknownVarFromWindowMouseOperator_Point_1.x - _offset.x,UnknownVarFromWindowMouseOperator_Point_1.y - _offset.y);
      }
      
      private function clientWindowDestroyed(param1:WindowEvent) : void
      {
         end(_window);
      }
      
      protected function getMousePositionRelativeTo(param1:IWindowModel, param2:Point, param3:Point) : void
      {
         param1.getGlobalPosition(param3);
         param3.x = param2.x - param3.x;
         param3.y = param2.y - param3.y;
      }
   }
}

