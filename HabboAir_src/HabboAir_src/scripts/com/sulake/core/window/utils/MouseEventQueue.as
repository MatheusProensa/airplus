package com.sulake.core.window.utils
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseEventQueue extends GenericEventQueue
   {
      protected var _mousePosition:Point;
      
      public function MouseEventQueue(param1:IEventDispatcher)
      {
         super(param1);
         _mousePosition = new Point();
         UnknownVarFromGenericEventQueue_IEventDispatcher_1.addEventListener("click",mouseEventListener,false);
         UnknownVarFromGenericEventQueue_IEventDispatcher_1.addEventListener("doubleClick",mouseEventListener,false);
         UnknownVarFromGenericEventQueue_IEventDispatcher_1.addEventListener("mouseDown",mouseEventListener,false);
         UnknownVarFromGenericEventQueue_IEventDispatcher_1.addEventListener("mouseMove",mouseEventListener,false);
         UnknownVarFromGenericEventQueue_IEventDispatcher_1.addEventListener("mouseUp",mouseEventListener,false);
         UnknownVarFromGenericEventQueue_IEventDispatcher_1.addEventListener("mouseWheel",mouseEventListener,false);
         UnknownVarFromGenericEventQueue_IEventDispatcher_1.addEventListener("mouseWheelHorizontal",mouseEventListener,false);
      }
      
      public function get mousePosition() : Point
      {
         return _mousePosition;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromGenericEventQueue_IEventDispatcher_1.removeEventListener("click",mouseEventListener,false);
            UnknownVarFromGenericEventQueue_IEventDispatcher_1.removeEventListener("doubleClick",mouseEventListener,false);
            UnknownVarFromGenericEventQueue_IEventDispatcher_1.removeEventListener("mouseDown",mouseEventListener,false);
            UnknownVarFromGenericEventQueue_IEventDispatcher_1.removeEventListener("mouseMove",mouseEventListener,false);
            UnknownVarFromGenericEventQueue_IEventDispatcher_1.removeEventListener("mouseUp",mouseEventListener,false);
            UnknownVarFromGenericEventQueue_IEventDispatcher_1.removeEventListener("mouseWheel",mouseEventListener,false);
            UnknownVarFromGenericEventQueue_IEventDispatcher_1.removeEventListener("mouseWheelHorizontal",mouseEventListener,false);
            super.dispose();
         }
      }
      
      private function mouseEventListener(param1:MouseEvent) : void
      {
         var _loc2_:MouseEvent = null;
         _mousePosition.x = param1.stageX;
         _mousePosition.y = param1.stageY;
         if(param1.type == "mouseMove" && _eventArray.length > 0)
         {
            _loc2_ = _eventArray[_eventArray.length - 1] as MouseEvent;
            if(_loc2_ != null && _loc2_.type == "mouseMove")
            {
               _eventArray[_eventArray.length - 1] = param1;
               return;
            }
         }
         _eventArray.push(param1);
      }
   }
}

