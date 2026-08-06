package com.sulake.core.window.graphics
{
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.events.WindowDisposeEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils5;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class WindowRenderer implements IWindowRenderer
   {
      protected static const MAX_DIRTY_REGIONS_PER_WINDOW:int = 3;
      
      protected static const MAX_DISTANCE_BEFORE_COMBINE:int = 10;
      
      protected static const RECT:Rectangle = new Rectangle();
      
      private static const POINT_ZERO:Point = new Point();
      
      protected var _debug:Boolean = false;
      
      protected var _disposed:Boolean;
      
      protected var UnknownVarFromWindowRenderer_ISkinContainer_1:ISkinContainer;
      
      protected var UnknownVarFromWindowRenderer_Dictionary_1:Dictionary;
      
      protected var UnknownVarFromWindowRenderer_Vector_1:Vector.<IWindowModel>;
      
      protected var UnknownVarFromWindowRenderer_Vector_2:Vector.<Array>;
      
      protected var UnknownVarFromWindowRenderer_Point_1:Point;
      
      protected var UnknownVarFromWindowRenderer_Rectangle_1:Rectangle;
      
      protected var UnknownVarFromWindowRenderer_Rectangle_2:Rectangle;
      
      protected var UnknownVarFromWindowRenderer_Rectangle_3:Rectangle;
      
      public function WindowRenderer(param1:ISkinContainer)
      {
         super();
         _disposed = false;
         UnknownVarFromWindowRenderer_ISkinContainer_1 = param1;
         UnknownVarFromWindowRenderer_Dictionary_1 = new Dictionary(false);
         UnknownVarFromWindowRenderer_Vector_1 = new Vector.<IWindowModel>();
         UnknownVarFromWindowRenderer_Vector_2 = new Vector.<Array>();
         UnknownVarFromWindowRenderer_Point_1 = new Point();
         UnknownVarFromWindowRenderer_Rectangle_1 = new Rectangle();
         UnknownVarFromWindowRenderer_Rectangle_2 = new Rectangle();
         UnknownVarFromWindowRenderer_Rectangle_3 = new Rectangle();
      }
      
      private static function areRectanglesCloseEnough(param1:Rectangle, param2:Rectangle, param3:uint) : Boolean
      {
         if(param1.intersects(param2))
         {
            return true;
         }
         return (param1.left > param2.left ? param1.left - param2.right : param2.left - param1.right) <= param3 && (param1.top > param2.top ? param1.top - param2.bottom : param2.top - param1.bottom) <= param3;
      }
      
      private static function getDrawLocationAndClipRegion(param1:IWindowModel, param2:Rectangle, param3:Point, param4:Rectangle) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:Boolean = true;
         param4.x = 0;
         param4.y = 0;
         param4.width = param1.renderingWidth;
         param4.height = param1.renderingHeight;
         if(!param1.testParamFlag(16))
         {
            if(param1.parent && param1.testParamFlag(1073741824))
            {
               _loc5_ = childRectToClippedDrawRegion(param1.parent,param3,param4);
               param3.x = param4.x;
               param3.y = param4.y;
            }
            else
            {
               param3.x = 0;
               param3.y = 0;
            }
         }
         else if(param1.parent)
         {
            _loc5_ = childRectToClippedDrawRegion(param1.parent,param3,param4);
         }
         else
         {
            param3.x = 0;
            param3.y = 0;
         }
         if(param2.x > param4.x)
         {
            _loc6_ = param2.x - param4.x;
            param3.x += _loc6_;
            param4.x += _loc6_;
            param4.width -= _loc6_;
         }
         if(param2.y > param4.y)
         {
            _loc6_ = param2.y - param4.y;
            param3.y += _loc6_;
            param4.y += _loc6_;
            param4.height -= _loc6_;
         }
         if(param2.right < param4.right)
         {
            _loc6_ = param4.right - param2.right;
            param4.width -= _loc6_;
         }
         if(param2.bottom < param4.bottom)
         {
            _loc6_ = param4.bottom - param2.bottom;
            param4.height -= _loc6_;
         }
         return _loc5_ && param4.width > 0 && param4.height > 0;
      }
      
      private static function childRectToClippedDrawRegion(param1:IWindowModel, param2:Point, param3:Rectangle) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1.testParamFlag(16))
         {
            _loc5_ = param1.renderingX;
            _loc6_ = param1.renderingY;
            param2.offset(_loc5_,_loc6_);
            if(param1.clipping)
            {
               if(param2.x < _loc5_)
               {
                  _loc4_ = _loc5_ - param2.x;
                  param3.x += _loc4_;
                  param3.width -= _loc4_;
                  param2.x = _loc5_;
               }
               if(param2.x < 0)
               {
                  param3.x -= param2.x;
                  param3.width += param2.x;
                  param2.x = 0;
               }
               if(param2.y < _loc6_)
               {
                  _loc4_ = _loc6_ - param2.y;
                  param3.y += _loc4_;
                  param3.height -= _loc4_;
                  param2.y = _loc6_;
               }
               if(param2.y < 0)
               {
                  param3.y -= param2.y;
                  param3.height += param2.y;
                  param2.y = 0;
               }
               if(param2.x + param3.width > _loc5_ + param1.renderingWidth)
               {
                  param3.width -= param2.x + param3.width - (_loc5_ + param1.renderingWidth);
               }
               if(param2.y + param3.height > _loc6_ + param1.renderingHeight)
               {
                  param3.height -= param2.y + param3.height - (_loc6_ + param1.renderingHeight);
               }
            }
            if(param1.parent)
            {
               childRectToClippedDrawRegion(param1.parent,param2,param3);
            }
         }
         else if(param1.clipping)
         {
            if(param2.x < 0)
            {
               _loc4_ = param2.x;
               param3.x -= _loc4_;
               param3.width += _loc4_;
               param2.x = 0;
            }
            if(param2.y < 0)
            {
               _loc4_ = param2.y;
               param3.y -= _loc4_;
               param3.height += _loc4_;
               param2.y = 0;
            }
         }
         return param3.width > 0 && param3.height > 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set debug(param1:Boolean) : void
      {
         _debug = param1;
      }
      
      public function get debug() : Boolean
      {
         return _debug;
      }
      
      public function dispose() : void
      {
         var _loc1_:WindowRendererItem = null;
         if(!_disposed)
         {
            _disposed = true;
            for(var _loc2_ in UnknownVarFromWindowRenderer_Dictionary_1)
            {
               _loc1_ = UnknownVarFromWindowRenderer_Dictionary_1[_loc2_] as WindowRendererItem;
               _loc1_.dispose();
               delete UnknownVarFromWindowRenderer_Dictionary_1[_loc2_];
            }
            UnknownVarFromWindowRenderer_Dictionary_1 = null;
            UnknownVarFromWindowRenderer_Vector_1 = null;
            UnknownVarFromWindowRenderer_Vector_2 = null;
         }
      }
      
      public function purge(param1:IWindowModel = null, param2:Boolean = true) : void
      {
         var _loc3_:WindowRendererItem = null;
         var _loc5_:UnknownICoreWindowUtils5 = null;
         var _loc4_:* = undefined;
         if(param1)
         {
            if(!param1.visible || !param2)
            {
               _loc3_ = UnknownVarFromWindowRenderer_Dictionary_1[param1];
               if(_loc3_)
               {
                  _loc3_.dispose();
                  delete UnknownVarFromWindowRenderer_Dictionary_1[param1];
               }
               param2 = false;
            }
            _loc5_ = param1 as UnknownICoreWindowUtils5;
            if(_loc5_)
            {
               for each(param1 in _loc5_.children)
               {
                  purge(param1,param2);
               }
            }
         }
         else
         {
            _loc4_ = new Vector.<IWindowModel>();
            for(var _loc6_ in UnknownVarFromWindowRenderer_Dictionary_1)
            {
               param1 = _loc6_ as IWindowModel;
               if(!param1.visible || !param2 || param1.parent == null && !(param1 is IDesktopController))
               {
                  _loc4_.push(param1);
               }
            }
            while(_loc4_.length)
            {
               purge(_loc4_.pop(),param2);
            }
         }
      }
      
      public function addToRenderQueue(param1:IWindowModel, param2:Rectangle, param3:uint) : void
      {
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:IWindowModel = null;
         var _loc5_:Array = null;
         var _loc10_:int = 0;
         var _loc6_:Rectangle = null;
         var _loc11_:Rectangle = null;
         if(!param2)
         {
            param2 = UnknownVarFromWindowRenderer_Rectangle_2;
            UnknownVarFromWindowRenderer_Rectangle_2.x = 0;
            UnknownVarFromWindowRenderer_Rectangle_2.y = 0;
            UnknownVarFromWindowRenderer_Rectangle_2.width = param1.renderingWidth;
            UnknownVarFromWindowRenderer_Rectangle_2.height = param1.renderingHeight;
         }
         else
         {
            UnknownVarFromWindowRenderer_Rectangle_2.x = param2.x;
            UnknownVarFromWindowRenderer_Rectangle_2.y = param2.y;
            UnknownVarFromWindowRenderer_Rectangle_2.width = param2.width;
            UnknownVarFromWindowRenderer_Rectangle_2.height = param2.height;
         }
         if(param2.isEmpty())
         {
            return;
         }
         if(getWindowRendererItem(param1).invalidate(param1,param3))
         {
            if(param1.testParamFlag(16) || param1.testParamFlag(1073741824))
            {
               var _loc7_:IDesktopController = param1.context.getDesktopWindow();
               do
               {
                  _loc4_ = param1.parent;
                  if(_loc4_ == null)
                  {
                     return;
                  }
                  if(_loc4_ == _loc7_)
                  {
                     break;
                  }
                  if(!_loc4_.visible)
                  {
                     return;
                  }
                  _loc8_ = _loc4_.renderingWidth;
                  _loc12_ = _loc4_.renderingHeight;
                  UnknownVarFromWindowRenderer_Rectangle_2.offset(param1.renderingX,param1.renderingY);
                  if(_loc4_.clipping)
                  {
                     if(UnknownVarFromWindowRenderer_Rectangle_2.x > _loc8_ || UnknownVarFromWindowRenderer_Rectangle_2.y > _loc12_ || UnknownVarFromWindowRenderer_Rectangle_2.right < 0 || UnknownVarFromWindowRenderer_Rectangle_2.bottom < 0)
                     {
                        return;
                     }
                     if(UnknownVarFromWindowRenderer_Rectangle_2.x < 0)
                     {
                        UnknownVarFromWindowRenderer_Rectangle_2.width += UnknownVarFromWindowRenderer_Rectangle_2.x;
                        UnknownVarFromWindowRenderer_Rectangle_2.x = 0;
                     }
                     if(UnknownVarFromWindowRenderer_Rectangle_2.y < 0)
                     {
                        UnknownVarFromWindowRenderer_Rectangle_2.height += UnknownVarFromWindowRenderer_Rectangle_2.y;
                        UnknownVarFromWindowRenderer_Rectangle_2.y = 0;
                     }
                     if(UnknownVarFromWindowRenderer_Rectangle_2.right > _loc8_)
                     {
                        UnknownVarFromWindowRenderer_Rectangle_2.right = _loc8_;
                     }
                     if(UnknownVarFromWindowRenderer_Rectangle_2.bottom > _loc12_)
                     {
                        UnknownVarFromWindowRenderer_Rectangle_2.bottom = _loc12_;
                     }
                  }
                  if(UnknownVarFromWindowRenderer_Rectangle_2.isEmpty())
                  {
                     return;
                  }
                  param1 = _loc4_;
               }
               while(!(!param1.testParamFlag(16) && !param1.testParamFlag(1073741824)));
               
            }
            getWindowRendererItem(param1).invalidate(param1,32);
            _loc10_ = int(UnknownVarFromWindowRenderer_Vector_1.indexOf(param1));
            if(_loc10_ > -1)
            {
               _loc5_ = UnknownVarFromWindowRenderer_Vector_2[_loc10_];
               _loc11_ = UnknownVarFromWindowRenderer_Rectangle_2;
               var _loc9_:int = int(_loc5_.length);
               if(_loc9_ > 3)
               {
                  _loc11_ = _loc11_.union(_loc5_.pop());
                  _loc9_--;
               }
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  _loc6_ = _loc5_[_loc10_++];
                  if((_loc6_.left > _loc11_.left ? _loc6_.left - _loc11_.right : _loc11_.left - _loc6_.right) <= 10 && (_loc6_.top > _loc11_.top ? _loc6_.top - _loc11_.bottom : _loc11_.top - _loc6_.bottom) <= 10)
                  {
                     _loc5_.splice(_loc10_ - 1,1);
                     _loc11_ = _loc11_.union(_loc6_);
                     _loc9_--;
                     _loc10_ = 0;
                  }
               }
               _loc5_.push(_loc11_ == UnknownVarFromWindowRenderer_Rectangle_2 ? _loc11_.clone() : _loc11_);
            }
            else
            {
               UnknownVarFromWindowRenderer_Vector_1.push(param1);
               UnknownVarFromWindowRenderer_Vector_2.push([UnknownVarFromWindowRenderer_Rectangle_2.clone()]);
            }
         }
      }
      
      public function flushRenderQueue() : void
      {
         if(UnknownVarFromWindowRenderer_Vector_1.length || UnknownVarFromWindowRenderer_Vector_2.length)
         {
            UnknownVarFromWindowRenderer_Vector_1.splice(0,UnknownVarFromWindowRenderer_Vector_1.length);
            UnknownVarFromWindowRenderer_Vector_2.splice(0,UnknownVarFromWindowRenderer_Vector_2.length);
         }
      }
      
      public function invalidate(param1:IWindowContext_3, param2:Rectangle) : void
      {
         var _loc5_:IWindowModel = null;
         var _loc4_:IDesktopController = null;
         _loc4_ = param1.getDesktopWindow();
         var _loc3_:uint = uint(_loc4_.numChildren);
         while(_loc3_-- > 0)
         {
            _loc5_ = _loc4_.getChildAt(_loc3_);
            addToRenderQueue(_loc5_,null,1);
         }
      }
      
      protected function getWindowRendererItem(param1:IWindowModel) : WindowRendererItem
      {
         var _loc2_:WindowRendererItem = UnknownVarFromWindowRenderer_Dictionary_1[param1] as WindowRendererItem;
         if(_loc2_ == null)
         {
            _loc2_ = registerRenderable(param1);
         }
         return _loc2_;
      }
      
      public function registerRenderable(param1:IWindowModel) : WindowRendererItem
      {
         var _loc2_:WindowRendererItem = UnknownVarFromWindowRenderer_Dictionary_1[param1] as WindowRendererItem;
         if(_loc2_ == null)
         {
            _loc2_ = new WindowRendererItem(UnknownVarFromWindowRenderer_ISkinContainer_1);
            UnknownVarFromWindowRenderer_Dictionary_1[param1] = _loc2_;
            _loc2_.invalidate(param1,8);
         }
         if(!param1.hasEventListener("WINDOW_DISPOSE_EVENT"))
         {
            param1.addEventListener("WINDOW_DISPOSE_EVENT",windowDisposedCallback);
         }
         return _loc2_;
      }
      
      public function removeRenderable(param1:IWindowModel) : void
      {
         param1.removeEventListener("WINDOW_DISPOSE_EVENT",windowDisposedCallback);
         var _loc2_:WindowRendererItem = UnknownVarFromWindowRenderer_Dictionary_1[param1] as WindowRendererItem;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            delete UnknownVarFromWindowRenderer_Dictionary_1[param1];
         }
      }
      
      protected function windowDisposedCallback(param1:WindowDisposeEvent) : void
      {
         removeRenderable(param1.window);
      }
      
      public function getDrawBufferForRenderable(param1:IWindowModel) : BitmapData
      {
         var _loc2_:Rectangle = null;
         var _loc4_:TrackedBitmapData = null;
         var _loc3_:WindowRendererItem = UnknownVarFromWindowRenderer_Dictionary_1[param1] as WindowRendererItem;
         if(!_loc3_)
         {
            _loc2_ = new Rectangle(0,0,param1.renderingWidth,param1.renderingHeight);
            _loc4_ = new TrackedBitmapData(this,param1.renderingWidth,param1.renderingHeight);
            _loc3_ = registerRenderable(param1);
            _loc3_.invalidate(param1,1);
            _loc3_.render(param1,POINT_ZERO,_loc2_,param1.renderingRectangle,_loc4_);
            _loc4_.dispose();
         }
         return _loc3_ != null ? _loc3_.buffer : null;
      }
      
      public function render() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = null;
         var _loc4_:BitmapData = null;
         var _loc5_:IWindowModel = null;
         var _loc3_:uint = UnknownVarFromWindowRenderer_Vector_1.length;
         while(_loc3_-- > 0)
         {
            _loc5_ = UnknownVarFromWindowRenderer_Vector_1.pop();
            _loc2_ = UnknownVarFromWindowRenderer_Vector_2.pop();
            if(!_loc5_.disposed)
            {
               _loc4_ = _loc5_.fetchDrawBuffer() as BitmapData;
               for each(_loc1_ in _loc2_)
               {
                  UnknownVarFromWindowRenderer_Rectangle_3.x = _loc5_.renderingX;
                  UnknownVarFromWindowRenderer_Rectangle_3.y = _loc5_.renderingY;
                  UnknownVarFromWindowRenderer_Rectangle_3.width = _loc5_.renderingWidth;
                  UnknownVarFromWindowRenderer_Rectangle_3.height = _loc5_.renderingHeight;
                  renderWindowBranch(_loc5_,_loc1_,UnknownVarFromWindowRenderer_Rectangle_3,_loc4_);
               }
            }
         }
      }
      
      private function renderWindowBranch(param1:IWindowModel, param2:Rectangle, param3:Rectangle, param4:BitmapData) : void
      {
         var _loc9_:* = null;
         var _loc7_:IGraphicContextHost = null;
         var _loc6_:* = undefined;
         var _loc5_:WindowRendererItem = null;
         var _loc8_:IGraphicContext = IGraphicContextHost(param1).getGraphicContext(false);
         if(_loc8_)
         {
            _loc8_.visible = param1.visible;
         }
         if(param1.visible)
         {
            UnknownVarFromWindowRenderer_Point_1.x = param1.renderingX;
            UnknownVarFromWindowRenderer_Point_1.y = param1.renderingY;
            if(getDrawLocationAndClipRegion(param1,param2,UnknownVarFromWindowRenderer_Point_1,UnknownVarFromWindowRenderer_Rectangle_1))
            {
               if(param1.clipping)
               {
                  param3 = param3.intersection(param1.renderingRectangle);
               }
               param3.offset(-param1.x,-param1.y);
               param4 = getWindowRendererItem(param1).render(param1,UnknownVarFromWindowRenderer_Point_1,UnknownVarFromWindowRenderer_Rectangle_1,param3,param4);
               if(!(param1 is UnknownICoreWindowUtils5))
               {
                  return;
               }
               _loc6_ = UnknownICoreWindowUtils5(param1).children;
               if(!_loc6_)
               {
                  return;
               }
               if(param1.clipping)
               {
                  param2 = param2.clone();
                  if(param2.x < 0)
                  {
                     param2.width += param2.x;
                     param2.x = 0;
                  }
                  if(param2.y < 0)
                  {
                     param2.height += param2.y;
                     param2.y = 0;
                  }
                  if(param2.width > param1.width)
                  {
                     param2.width = param1.renderingWidth;
                  }
                  if(param2.height > param1.height)
                  {
                     param2.height = param1.renderingHeight;
                  }
               }
               for each(_loc9_ in _loc6_)
               {
                  RECT.x = _loc9_.x;
                  RECT.y = _loc9_.y;
                  RECT.width = _loc9_.width;
                  RECT.height = _loc9_.height;
                  if(RECT.intersects(param2))
                  {
                     if(_loc9_.testParamFlag(16))
                     {
                        param2.offset(-_loc9_.x,-_loc9_.y);
                        renderWindowBranch(_loc9_,param2,param3,param4);
                        param2.offset(_loc9_.x,_loc9_.y);
                     }
                     else if(_loc9_.testParamFlag(1073741824))
                     {
                        param2.offset(-_loc9_.x,-_loc9_.y);
                        renderWindowBranch(_loc9_,param2,param3,_loc9_.fetchDrawBuffer() as BitmapData);
                        param2.offset(_loc9_.x,_loc9_.y);
                     }
                     else if(_loc9_.visible)
                     {
                        _loc7_ = IGraphicContextHost(_loc9_);
                        if(_loc7_.hasGraphicsContext())
                        {
                           _loc5_ = UnknownVarFromWindowRenderer_Dictionary_1[_loc9_] as WindowRendererItem;
                           if(_loc5_ == null || _loc5_.needsRedraw(_loc9_))
                           {
                              renderWindowBranch(_loc9_,new Rectangle(0,0,_loc9_.renderingWidth,_loc9_.renderingHeight),param3,_loc9_.fetchDrawBuffer() as BitmapData);
                           }
                           else
                           {
                              _loc7_.getGraphicContext(true).visible = true;
                           }
                        }
                     }
                  }
                  else if(!RECT.intersects(param3))
                  {
                     _loc7_ = IGraphicContextHost(_loc9_);
                     if(_loc7_.hasGraphicsContext())
                     {
                        _loc7_.getGraphicContext(true).visible = false;
                     }
                  }
               }
               param3.offset(param1.renderingX,param1.renderingY);
            }
            else if(!param1.testParamFlag(16))
            {
               if(param1.testParamFlag(1073741824))
               {
                  if(!_loc8_)
                  {
                     _loc8_ = IGraphicContextHost(param1).getGraphicContext(true);
                  }
                  _loc8_.setDrawRegion(param1.renderingRectangle,false,UnknownVarFromWindowRenderer_Rectangle_1);
                  _loc8_.visible = false;
               }
            }
         }
      }
   }
}

