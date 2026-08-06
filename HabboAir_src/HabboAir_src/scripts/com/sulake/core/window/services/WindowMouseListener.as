package com.sulake.core.window.services
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class WindowMouseListener extends WindowMouseOperator implements IMouseListenerService
   {
      private var _eventTypes:Array = [];
      
      private var _areaLimit:uint = 0;
      
      public function WindowMouseListener(param1:DisplayObject)
      {
         super(param1);
      }
      
      public function get eventTypes() : Array
      {
         return _eventTypes;
      }
      
      public function get areaLimit() : uint
      {
         return _areaLimit;
      }
      
      public function set areaLimit(param1:uint) : void
      {
         _areaLimit = param1;
      }
      
      override public function end(param1:IWindowModel) : IWindowModel
      {
         var _loc2_:int = 0;
         _loc2_ = int(_eventTypes.length);
         while(_loc2_ > 0)
         {
            _eventTypes.pop();
            _loc2_--;
         }
         return super.end(param1);
      }
      
      override protected function handler(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if(_working && !_window.disposed)
         {
            if(_eventTypes.indexOf(param1.type) >= 0)
            {
               if(param1 is WindowMouseEvent)
               {
                  _loc2_ = _window.hitTestGlobalPoint(new Point(WindowMouseEvent(param1).stageX,WindowMouseEvent(param1).stageY));
                  if(_areaLimit == 1 && !_loc2_)
                  {
                     return;
                  }
                  if(_areaLimit == 3 && _loc2_)
                  {
                     return;
                  }
               }
               _window.update(null,WindowMouseEvent(param1));
            }
         }
      }
      
      override public function operate(param1:int, param2:int) : void
      {
      }
   }
}

