package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public class TextMargins implements IMargins, IComponentInterfaceQueue
   {
      private var _left:int;
      
      private var _right:int;
      
      private var _top:int;
      
      private var _bottom:int;
      
      private var _callback:Function;
      
      private var _disposed:Boolean = false;
      
      public function TextMargins(param1:int, param2:int, param3:int, param4:int, param5:Function)
      {
         super();
         _left = param1;
         _top = param2;
         _right = param3;
         _bottom = param4;
         _callback = param5 ?? nullCallback;
      }
      
      public function get left() : int
      {
         return _left;
      }
      
      public function get right() : int
      {
         return _right;
      }
      
      public function get top() : int
      {
         return _top;
      }
      
      public function get bottom() : int
      {
         return _bottom;
      }
      
      public function set left(param1:int) : void
      {
         _left = param1;
         _callback(this);
      }
      
      public function set right(param1:int) : void
      {
         _right = param1;
         _callback(this);
      }
      
      public function set top(param1:int) : void
      {
         _top = param1;
         _callback(this);
      }
      
      public function set bottom(param1:int) : void
      {
         _bottom = param1;
         _callback(this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isZeroes() : Boolean
      {
         return _left == 0 && _right == 0 && _top == 0 && _bottom == 0;
      }
      
      public function assign(param1:int, param2:int, param3:int, param4:int, param5:Function) : void
      {
         _left = param1;
         _top = param2;
         _right = param3;
         _bottom = param4;
         _callback = param5 ?? nullCallback;
      }
      
      public function clone(param1:Function) : TextMargins
      {
         return new TextMargins(_left,_top,_right,_bottom,param1);
      }
      
      public function dispose() : void
      {
         _callback = null;
         _disposed = true;
      }
      
      private function nullCallback(param1:IMargins) : void
      {
      }
   }
}

