package com.sulake.core.window.utils.tablet
{
   import com.sulake.core.window.utils.GenericEventQueue;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class TabletEventQueue extends GenericEventQueue
   {
      protected var _touchPosition:Point;
      
      public function TabletEventQueue(param1:IEventDispatcher)
      {
         super(param1);
         _touchPosition = new Point();
      }
      
      public function get touchPosition() : Point
      {
         return _touchPosition;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
         }
      }
   }
}

