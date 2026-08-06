package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowTouchEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.SmoothScroller;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class ScrollBarController extends InteractiveController implements IScrollbarWindow, ITouchAwareWindow
   {
      private static const SCROLL_STEP_SIZE:Number = 15;
      
      private static const SCROLL_BUTTON_INCREMENT:String = "increment";
      
      private static const SCROLL_BUTTON_DECREMENT:String = "decrement";
      
      private static const SCROLL_SLIDER_TRACK:String = "slider_track";
      
      private static const SCROLL_SLIDER_BAR:String = "slider_bar";
      
      protected var _offset:Number = 0;
      
      protected var UnknownVarFromScrollBarController_Number_1:Number = 0.1;
      
      protected var _scrollable:IScrollableWindow;
      
      private var _horizontal:Boolean;
      
      private var _targetName:String;
      
      private var UnknownVarFromScrollBarController_Boolean_1:Boolean = false;
      
      private var UnknownVarFromScrollBarController_SmoothScroller_1:SmoothScroller;
      
      public function ScrollBarController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0, param12:IScrollableWindow = null)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         UnknownVarFromWindowController_Boolean_1 = false;
         _scrollable = param12;
         _horizontal = param2 == 130;
         UnknownVarFromScrollBarController_SmoothScroller_1 = new SmoothScroller(getScrollOffset,setSmoothScrollOffset,getSmoothScrollAxisSize,200,60,true,null,15);
         var _loc13_:Array = [];
         groupChildrenWithTag("_INTERNAL",_loc13_,-1);
         for each(var _loc14_ in _loc13_)
         {
            _loc14_.procedure = scrollButtonEventProc;
         }
         updateLiftSizeAndPosition();
      }
      
      public function get scrollH() : Number
      {
         return _horizontal ? _offset : 0;
      }
      
      public function get scrollV() : Number
      {
         return _horizontal ? 0 : _offset;
      }
      
      public function get scrollable() : IScrollableWindow
      {
         return _scrollable;
      }
      
      public function set scrollH(param1:Number) : void
      {
         if(_horizontal)
         {
            if(setScrollPosition(param1,true))
            {
               updateLiftSizeAndPosition();
            }
         }
      }
      
      public function set scrollV(param1:Number) : void
      {
         if(!_horizontal)
         {
            if(setScrollPosition(param1,true))
            {
               updateLiftSizeAndPosition();
            }
         }
      }
      
      public function set scrollable(param1:IScrollableWindow) : void
      {
         if(_scrollable != null && !_scrollable.disposed)
         {
            _scrollable.removeEventListener("WE_RESIZED",onScrollableResized);
            _scrollable.removeEventListener("WE_SCROLL",onScrollableScrolled);
         }
         _scrollable = param1;
         if(_scrollable != null && !_scrollable.disposed)
         {
            _scrollable.addEventListener("WE_RESIZED",onScrollableResized);
            _scrollable.addEventListener("WE_SCROLL",onScrollableScrolled);
            setScrollPosition(_horizontal ? _scrollable.scrollH : _scrollable.scrollV,false);
            updateLiftSizeAndPosition();
         }
      }
      
      public function get horizontal() : Boolean
      {
         return _horizontal;
      }
      
      public function get vertical() : Boolean
      {
         return !_horizontal;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         var _loc2_:String = null;
         if(_scrollable is IWindowModel)
         {
            _loc2_ = IWindowModel(_scrollable).name;
         }
         else if(_targetName != null)
         {
            _loc2_ = _targetName;
         }
         if(_loc2_ == null)
         {
            _loc1_.push(getDefaultProperty("scrollable"));
         }
         else
         {
            _loc1_.push(createProperty("scrollable",_loc2_));
         }
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("scrollable" === _loc3_)
            {
               _targetName = _loc2_.value as String;
               _scrollable = null;
            }
         }
         super.properties = param1;
      }
      
      protected function get track() : WindowController
      {
         return findChildByName("slider_track") as WindowController;
      }
      
      protected function get lift() : WindowController
      {
         return track.findChildByName("slider_bar") as WindowController;
      }
      
      override public function dispose() : void
      {
         scrollable = null;
         if(UnknownVarFromScrollBarController_SmoothScroller_1 != null)
         {
            UnknownVarFromScrollBarController_SmoothScroller_1.dispose();
            UnknownVarFromScrollBarController_SmoothScroller_1 = null;
         }
         super.dispose();
      }
      
      override public function enable() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         if(super.enable())
         {
            _loc1_ = [];
            groupChildrenWithTag("_INTERNAL",_loc1_,-1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               IWindowModel(_loc1_[_loc2_]).enable();
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      override public function disable() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         if(super.disable())
         {
            _loc1_ = [];
            groupChildrenWithTag("_INTERNAL",_loc1_,-1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               IWindowModel(_loc1_[_loc2_]).disable();
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      protected function setScrollPosition(param1:Number, param2:Boolean, param3:Boolean = false) : Boolean
      {
         var _loc4_:* = false;
         if(_scrollable == null || Boolean(_scrollable.disposed))
         {
            if(!resolveScrollTarget())
            {
               return false;
            }
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc5_:Number = param1 - _offset;
         _offset = param1;
         if(param2)
         {
            if(_horizontal)
            {
               _loc4_ = _scrollable.scrollH != _offset;
               if(_loc4_)
               {
                  _scrollable.scrollH = _offset;
               }
            }
            else
            {
               _loc4_ = _scrollable.scrollV != _offset;
               if(_loc4_)
               {
                  _scrollable.scrollV = _offset;
               }
            }
         }
         if(!param3 && UnknownVarFromScrollBarController_SmoothScroller_1 != null && UnknownVarFromScrollBarController_SmoothScroller_1.isScrolling)
         {
            UnknownVarFromScrollBarController_SmoothScroller_1.adjustStartPosition(_loc5_);
         }
         return _loc4_;
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:ScrollBarLiftController = null;
         var _loc5_:* = param1.name;
         if("slider_bar" === _loc5_)
         {
            if(param2.type == "WE_CHILD_RELOCATED")
            {
               if(!UnknownVarFromScrollBarController_Boolean_1)
               {
                  _loc3_ = ScrollBarLiftController(param1);
                  if(_horizontal)
                  {
                     setScrollPosition(_loc3_.scrollbarOffsetX,true);
                  }
                  else
                  {
                     setScrollPosition(_loc3_.scrollbarOffsetY,true);
                  }
               }
            }
         }
         var _loc4_:Boolean = super.update(param1,param2);
         if(param2.type == "WE_PARENT_ADDED")
         {
            if(_scrollable == null)
            {
               resolveScrollTarget();
            }
         }
         if(param1 == this)
         {
            if(param2.type == "WE_RESIZED")
            {
               updateLiftSizeAndPosition();
            }
            else if(param2.type == "WME_WHEEL")
            {
               scrollWithWheel(WindowMouseEvent(param2).delta);
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      private function updateLiftSizeAndPosition() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         if(_scrollable == null || Boolean(_scrollable.disposed))
         {
            if(_disposed || !resolveScrollTarget())
            {
               return;
            }
         }
         var _loc2_:WindowController = track;
         var _loc1_:WindowController = lift;
         if(_loc1_ != null)
         {
            if(_horizontal)
            {
               _loc4_ = _scrollable.visibleRegion.width / _scrollable.scrollableRegion.width;
               if(_loc4_ > 1)
               {
                  _loc4_ = 1;
               }
               _loc3_ = _loc4_ * _loc2_.width;
               _loc1_.width = _loc3_;
               _loc1_.x = Math.round(_scrollable.scrollH * (_loc2_.width - _loc3_));
            }
            else
            {
               _loc4_ = _scrollable.visibleRegion.height / _scrollable.scrollableRegion.height;
               if(_loc4_ > 1)
               {
                  _loc4_ = 1;
               }
               _loc3_ = _loc4_ * _loc2_.height;
               _loc1_.height = _loc3_;
               _loc1_.y = Math.round(_scrollable.scrollV * (_loc2_.height - _loc1_.height));
            }
         }
         if(_loc4_ == 1)
         {
            disable();
         }
         else
         {
            enable();
         }
      }
      
      private function nullEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
      }
      
      private function scrollButtonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:IWindowModel = null;
         var _loc6_:Boolean = false;
         if(param1.type == "WME_DOWN" || param1.type == "WTE_TAP")
         {
            if(param2.name == "increment")
            {
               if(_scrollable)
               {
                  UnknownVarFromScrollBarController_Boolean_1 = true;
                  if(_horizontal)
                  {
                     scrollH += 15 / _scrollable.maxScrollH;
                  }
                  else
                  {
                     scrollV += 15 / _scrollable.maxScrollV;
                  }
                  UnknownVarFromScrollBarController_Boolean_1 = false;
               }
            }
            else if(param2.name == "decrement")
            {
               if(_scrollable)
               {
                  UnknownVarFromScrollBarController_Boolean_1 = true;
                  if(_horizontal)
                  {
                     scrollH -= 15 / _scrollable.maxScrollH;
                  }
                  else
                  {
                     scrollV -= 15 / _scrollable.maxScrollV;
                  }
                  UnknownVarFromScrollBarController_Boolean_1 = false;
               }
            }
            else if(param2.name == "slider_track")
            {
               if(param1 is WindowMouseEvent)
               {
                  _loc5_ = int(WindowMouseEvent(param1).localX);
                  _loc4_ = int(WindowMouseEvent(param1).localY);
               }
               else if(param1 is WindowTouchEvent)
               {
                  _loc5_ = int(WindowTouchEvent(param1).localX);
                  _loc4_ = int(WindowTouchEvent(param1).localY);
               }
               _loc3_ = WindowController(param2).getChildByName("slider_bar");
               if(_horizontal)
               {
                  if(_loc5_ < _loc3_.x)
                  {
                     scrollH -= (_scrollable.visibleRegion.width - 15) / _scrollable.maxScrollH;
                  }
                  else if(_loc5_ > _loc3_.right)
                  {
                     scrollH += (_scrollable.visibleRegion.width - 15) / _scrollable.maxScrollH;
                  }
               }
               else if(_loc4_ < _loc3_.y)
               {
                  scrollV -= (_scrollable.visibleRegion.height - 15) / _scrollable.maxScrollV;
               }
               else if(_loc4_ > _loc3_.bottom)
               {
                  scrollV += (_scrollable.visibleRegion.height - 15) / _scrollable.maxScrollV;
               }
               _loc6_ = true;
            }
         }
         if(param1.type == "WME_WHEEL")
         {
            scrollWithWheel(WindowMouseEvent(param1).delta);
            _loc6_ = true;
         }
         if(_loc6_)
         {
            updateLiftSizeAndPosition();
         }
      }
      
      private function resolveScrollTarget() : Boolean
      {
         var _loc1_:IScrollableWindow = null;
         var _loc4_:IScrollableWindow = null;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(_scrollable != null)
         {
            if(!_scrollable.disposed)
            {
               return true;
            }
         }
         if(_targetName != null)
         {
            _loc1_ = findParentByName(_targetName) as IScrollableWindow;
            if(_loc1_ == null && _parent is IWindowController_1 && !(_parent is IDesktopController))
            {
               _loc1_ = IWindowController_1(_parent).findChildByName(_targetName) as IScrollableWindow;
               if(_loc1_)
               {
                  scrollable = _loc1_;
                  return true;
               }
            }
         }
         if(_parent is IScrollableWindow)
         {
            scrollable = IScrollableWindow(_parent);
            return true;
         }
         if(_parent is IWindowController_1 && !(_parent is IDesktopController))
         {
            _loc2_ = uint(IWindowController_1(_parent).numChildren);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = IWindowController_1(_parent).getChildAt(_loc3_) as IScrollableWindow;
               if(_loc4_)
               {
                  scrollable = _loc4_;
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function onScrollableResized(param1:WindowEvent) : void
      {
         updateLiftSizeAndPosition();
         setScrollPosition(_offset,false);
      }
      
      private function onScrollableScrolled(param1:WindowEvent) : void
      {
         setScrollPosition(_horizontal ? _scrollable.scrollH : _scrollable.scrollV,false);
         updateLiftSizeAndPosition();
      }
      
      private function scrollWithWheel(param1:int) : Boolean
      {
         return UnknownVarFromScrollBarController_SmoothScroller_1 != null && UnknownVarFromScrollBarController_SmoothScroller_1.scrollWithWheel(param1);
      }
      
      private function getScrollOffset() : Number
      {
         return _offset;
      }
      
      private function setSmoothScrollOffset(param1:Number) : void
      {
         if(setScrollPosition(param1,true,true))
         {
            updateLiftSizeAndPosition();
         }
      }
      
      private function getSmoothScrollAxisSize() : Number
      {
         return 25 / UnknownVarFromScrollBarController_Number_1;
      }
   }
}

