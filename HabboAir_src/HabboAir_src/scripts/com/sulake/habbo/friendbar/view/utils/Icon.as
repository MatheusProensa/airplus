package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class Icon implements IComponentInterfaceQueue
   {
      protected static const ALIGN_LEFT:int = 0;
      
      protected static const ALIGN_CENTER:int = 1;
      
      protected static const ALIGN_RIGHT:int = 2;
      
      protected static const MASK_HORIZONTAL:int = 3;
      
      protected static const ALIGN_TOP:int = 4;
      
      protected static const ALIGN_MIDDLE:int = 8;
      
      protected static const ALIGN_BOTTOM:int = 18;
      
      protected static const MASK_VERTICAL:int = 18;
      
      private var _disposed:Boolean = false;
      
      private var _disabled:Boolean = false;
      
      protected var _image:BitmapDataAsset;
      
      protected var _canvas:IBitmapWrapperController;
      
      private var _alignment:uint = 9;
      
      protected var UnknownVarFromIcon_Timer_1:Timer;
      
      protected var _frame:int = 0;
      
      private var _point:Point = new Point();
      
      protected var UnknownVarFromIcon_Boolean_1:Boolean = false;
      
      protected var _hover:Boolean = false;
      
      public function Icon()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      protected function set image(param1:BitmapDataAsset) : void
      {
         _image = param1;
         redraw();
      }
      
      protected function get image() : BitmapDataAsset
      {
         return _image;
      }
      
      protected function set canvas(param1:IBitmapWrapperController) : void
      {
         _canvas = param1;
         redraw();
      }
      
      protected function get canvas() : IBitmapWrapperController
      {
         return _canvas;
      }
      
      protected function set alignment(param1:uint) : void
      {
         _alignment = param1;
         redraw();
      }
      
      protected function get alignment() : uint
      {
         return _alignment;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            toggleTimer(false,0);
            image = null;
            canvas = null;
            _disposed = true;
         }
      }
      
      public function notify(param1:Boolean) : void
      {
         UnknownVarFromIcon_Boolean_1 = param1;
         if(UnknownVarFromIcon_Boolean_1 && _disabled)
         {
            enable(true);
         }
      }
      
      public function hover(param1:Boolean) : void
      {
         _hover = param1;
      }
      
      public function enable(param1:Boolean) : void
      {
         _disabled = !param1;
      }
      
      protected function redraw() : void
      {
         var _loc1_:BitmapData = null;
         if(_canvas && !_canvas.disposed)
         {
            if(!_canvas.bitmap)
            {
               _canvas.bitmap = new BitmapData(_canvas.width,_canvas.height,true,0);
            }
            else
            {
               _canvas.bitmap.fillRect(_canvas.bitmap.rect,0);
            }
            if(_image && !_image.disposed)
            {
               _point.x = _point.y = 0;
               _loc1_ = _image.content as BitmapData;
               switch((_alignment & 3) - 1)
               {
                  case 0:
                     _point.x = _canvas.bitmap.width / 2 - _loc1_.width / 2;
                     break;
                  case 1:
                     _point.x = _canvas.bitmap.width - _loc1_.width;
               }
               switch((_alignment & 0x12) - 8)
               {
                  case 0:
                     _point.y = _canvas.bitmap.height / 2 - _loc1_.height / 2;
                     break;
                  case 10:
                     _point.y = _canvas.bitmap.height - _loc1_.height;
               }
               _canvas.bitmap.copyPixels(_loc1_,_loc1_.rect,_point);
               _canvas.invalidate();
            }
         }
      }
      
      protected function toggleTimer(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            if(!UnknownVarFromIcon_Timer_1)
            {
               UnknownVarFromIcon_Timer_1 = new Timer(param2,0);
               UnknownVarFromIcon_Timer_1.addEventListener("timer",onTimerEvent);
               UnknownVarFromIcon_Timer_1.start();
               onTimerEvent(null);
            }
            UnknownVarFromIcon_Timer_1.delay = param2;
         }
         else
         {
            _frame = 0;
            if(UnknownVarFromIcon_Timer_1)
            {
               UnknownVarFromIcon_Timer_1.reset();
               UnknownVarFromIcon_Timer_1.removeEventListener("timer",onTimerEvent);
               UnknownVarFromIcon_Timer_1 = null;
            }
         }
      }
      
      protected function onTimerEvent(param1:TimerEvent) : void
      {
      }
   }
}

