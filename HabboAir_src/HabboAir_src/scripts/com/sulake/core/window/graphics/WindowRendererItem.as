package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WindowRendererItem implements IComponentInterfaceQueue
   {
      protected static const RENDER_TYPE_NULL:uint = 0;
      
      protected static const RENDER_TYPE_SKIN:uint = 1;
      
      protected static const RENDER_TYPE_FILL:uint = 2;
      
      protected static const MATRIX:Matrix = new Matrix();
      
      protected static const COLOR_TRANSFORM:ColorTransform = new ColorTransform();
      
      protected var _buffer:TrackedBitmapData;
      
      protected var UnknownVarFromWindowRendererItem_ISkinContainer_1:ISkinContainer;
      
      protected var _disposed:Boolean;
      
      protected var _refresh:Boolean;
      
      protected var UnknownVarFromWindowRendererItem_Uint_1:uint;
      
      protected var UnknownVarFromWindowRendererItem_Uint_2:uint;
      
      public function WindowRendererItem(param1:ISkinContainer)
      {
         super();
         _disposed = false;
         UnknownVarFromWindowRendererItem_ISkinContainer_1 = param1;
         UnknownVarFromWindowRendererItem_Uint_1 = 4294967295;
         UnknownVarFromWindowRendererItem_Uint_2 = 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get buffer() : BitmapData
      {
         return _buffer;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            UnknownVarFromWindowRendererItem_ISkinContainer_1 = null;
            if(_buffer != null)
            {
               _buffer.dispose();
               _buffer = null;
            }
         }
      }
      
      public function purge() : void
      {
      }
      
      public function render(param1:IWindowModel, param2:Point, param3:Rectangle, param4:Rectangle, param5:BitmapData) : BitmapData
      {
         var _loc13_:Boolean = false;
         var _loc6_:BitmapData = null;
         var _loc11_:String = null;
         var _loc15_:uint = param1.background ? 2 : 0;
         var _loc7_:ISkinRenderer = UnknownVarFromWindowRendererItem_ISkinContainer_1.getSkinRendererByTypeAndStyle(param1.type,param1.style);
         if(_loc7_ != null)
         {
            if(_loc7_.isStateDrawable(UnknownVarFromWindowRendererItem_Uint_2))
            {
               _loc15_ = 1;
            }
         }
         var _loc12_:int = Math.max(param1.renderingWidth,1);
         var _loc8_:int = Math.max(param1.renderingHeight,1);
         var _loc9_:Boolean = true;
         if(_loc15_ != 0)
         {
            if(!_buffer || _buffer.width != _loc12_ || _buffer.height != _loc8_)
            {
               if(_buffer)
               {
                  _buffer.dispose();
               }
               _buffer = new TrackedBitmapData(this,_loc12_,_loc8_,true,param1.color);
               _refresh = true;
               _loc9_ = false;
            }
         }
         var _loc16_:IGraphicContext = IGraphicContextHost(param1).getGraphicContext(false);
         if(_loc16_)
         {
            if(!_loc16_.visible)
            {
               _loc16_.visible = true;
            }
            _loc13_ = param1.testParamFlag(1073741824);
            _loc6_ = _loc16_.setDrawRegion(param1.renderingRectangle,!param1.testParamFlag(16),_loc13_ ? param4 : null);
            if(_loc6_)
            {
               param5 = _loc6_;
               _refresh = true;
            }
         }
         var _loc10_:* = !param1.testParamFlag(16);
         if(_loc15_ != 0)
         {
            if(param5 != null)
            {
               param5.lock();
               if(_loc15_ == 1)
               {
                  if(_refresh)
                  {
                     if(_loc10_)
                     {
                        param5.fillRect(param3,0);
                     }
                     _refresh = false;
                     if(_loc9_)
                     {
                        _buffer.fillRect(_buffer.rect,param1.color);
                     }
                     _loc7_.draw(param1,_buffer,_buffer.rect,UnknownVarFromWindowRendererItem_Uint_2,false);
                  }
                  _loc11_ = "normal";
                  if(param1.tags != null)
                  {
                     for each(var _loc14_ in param1.tags)
                     {
                        if(_loc14_.indexOf("BLEND_") == 0)
                        {
                           _loc11_ = _loc14_.substring(6).toLowerCase();
                        }
                     }
                  }
                  if((param1.blend < 1 || _loc11_ != "normal") && !_loc10_)
                  {
                     MATRIX.tx = param2.x - param3.x;
                     MATRIX.ty = param2.y - param3.y;
                     COLOR_TRANSFORM.alphaMultiplier = param1.blend;
                     param3.offset(MATRIX.tx,MATRIX.ty);
                     param5.draw(_buffer,MATRIX,COLOR_TRANSFORM,_loc11_,param3,false);
                     param3.offset(-MATRIX.tx,-MATRIX.ty);
                  }
                  else
                  {
                     param5.copyPixels(_buffer,param3,param2,null,null,true);
                  }
               }
               else if(_loc15_ == 2)
               {
                  if(!_loc10_)
                  {
                     _buffer.fillRect(_buffer.rect,param1.color);
                     param5.copyPixels(_buffer,param3,param2,null,null,true);
                  }
                  else
                  {
                     param5.fillRect(new Rectangle(param2.x,param2.y,param3.width,param3.height),param1.color);
                     _loc16_.blend = param1.blend;
                  }
               }
               param5.unlock();
            }
         }
         else
         {
            if(_loc10_ && param5 != null)
            {
               param5.fillRect(param3,0);
            }
            _refresh = false;
         }
         UnknownVarFromWindowRendererItem_Uint_1 = UnknownVarFromWindowRendererItem_Uint_2;
         return param5;
      }
      
      public function testForStateChange(param1:IWindowModel) : Boolean
      {
         return UnknownVarFromWindowRendererItem_ISkinContainer_1.getTheActualState(param1.type,param1.style,param1.state) != UnknownVarFromWindowRendererItem_Uint_1;
      }
      
      public function needsRedraw(param1:IWindowModel) : Boolean
      {
         return _refresh || testForStateChange(param1);
      }
      
      public function invalidate(param1:IWindowModel, param2:uint) : Boolean
      {
         var _loc4_:IGraphicContext = null;
         var _loc3_:Boolean = false;
         switch(param2)
         {
            case 1:
               _refresh = true;
               _loc3_ = true;
               break;
            case 2:
               _refresh = true;
               _loc3_ = true;
               break;
            case 4:
               if(param1.testParamFlag(16))
               {
                  _loc3_ = true;
               }
               else
               {
                  _loc4_ = IGraphicContextHost(param1).getGraphicContext(true);
                  _loc4_.setDrawRegion(param1.renderingRectangle,false,null);
                  if(!_loc4_.visible)
                  {
                     _loc3_ = true;
                  }
               }
               break;
            case 8:
               UnknownVarFromWindowRendererItem_Uint_2 = UnknownVarFromWindowRendererItem_ISkinContainer_1.getTheActualState(param1.type,param1.style,param1.state);
               if(UnknownVarFromWindowRendererItem_Uint_2 != UnknownVarFromWindowRendererItem_Uint_1)
               {
                  _refresh = true;
                  _loc3_ = true;
               }
               break;
            case 16:
               if(param1.testParamFlag(16))
               {
                  _refresh = true;
                  _loc3_ = true;
               }
               else
               {
                  IGraphicContextHost(param1).getGraphicContext(true).blend = param1.blend;
               }
               break;
            case 32:
               _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function drawRect(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right)
         {
            param1.setPixel32(_loc4_,param2.top,param3);
            param1.setPixel32(_loc4_,param2.bottom - 1,param3);
            _loc4_++;
         }
         _loc4_ = param2.top;
         while(_loc4_ < param2.bottom)
         {
            param1.setPixel32(param2.left,_loc4_,param3);
            param1.setPixel32(param2.right - 1,_loc4_,param3);
            _loc4_++;
         }
      }
   }
}

