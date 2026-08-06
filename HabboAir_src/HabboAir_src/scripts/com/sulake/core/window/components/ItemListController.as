package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.ItemListIterator;
   import com.sulake.core.window.theme.IThemeManager;
   import com.sulake.core.window.utils.IInputProcessorRoot;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.SmoothScroller;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ItemListController extends WindowController implements IItemListWindow, IInputProcessorRoot
   {
      private var _isPartOfGridWindow:Boolean = false;
      
      protected var _scrollH:Number = 0;
      
      protected var _scrollV:Number = 0;
      
      protected var _scrollAreaWidth:Number = 0;
      
      protected var UnknownVarFromItemListController_Number_1:Number = 0;
      
      protected var _container:IWindowController_1;
      
      protected var UnknownVarFromItemListController_Boolean_1:Boolean = false;
      
      protected var UnknownVarFromItemListController_Boolean_2:Boolean = false;
      
      protected var _spacing:int;
      
      protected var _isScrollHorizontal:Boolean = false;
      
      protected var _arrangeListItems:Boolean;
      
      protected var _scaleToFitItems:Boolean;
      
      protected var _resizeOnItemUpdate:Boolean;
      
      protected var _inverseResizeOnItemUpdate:Boolean;
      
      protected var UnknownVarFromItemListController_SmoothScroller_1:SmoothScroller;
      
      protected var UnknownVarFromItemListController_SmoothScroller_2:SmoothScroller;
      
      public function ItemListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         _isScrollHorizontal = param2 == 51;
         var _loc12_:IThemeManager = param5.getWindowFactory().getThemeManager();
         _spacing = int(_loc12_.getPropertyDefaults(param3).get("spacing").value);
         _arrangeListItems = _loc12_.getPropertyDefaults(param3).get("auto_arrange_items").value;
         _scaleToFitItems = _loc12_.getPropertyDefaults(param3).get("scale_to_fit_items").value;
         _resizeOnItemUpdate = _loc12_.getPropertyDefaults(param3).get("resize_on_item_update").value;
         _inverseResizeOnItemUpdate = _loc12_.getPropertyDefaults(param3).get("inverse_resize_on_item_update").value;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         UnknownVarFromWindowController_Boolean_1 = _background || !testParamFlag(16);
         _container = _context.create("_CONTAINER","",4,0,0x10 | 0 | 0,new Rectangle(0,0,width,height),null,this,0,null,"",["_INTERNAL","_EXCLUDE"]) as IWindowController_1;
         _container.addEventListener("WE_RESIZED",containerEventHandler);
         _container.addEventListener("WE_CHILD_REMOVED",containerEventHandler);
         _container.addEventListener("WE_CHILD_RESIZED",containerEventHandler);
         _container.addEventListener("WE_CHILD_VISIBILITY",containerEventHandler);
         _container.addEventListener("WE_CHILD_RELOCATED",containerEventHandler);
         _container.clipping = clipping;
         resizeOnItemUpdate = _resizeOnItemUpdate;
      }
      
      public function get spacing() : int
      {
         return _spacing;
      }
      
      public function set spacing(param1:int) : void
      {
         if(param1 != _spacing)
         {
            _spacing = param1;
            updateScrollAreaRegion();
         }
      }
      
      public function get scrollH() : Number
      {
         return _scrollH;
      }
      
      public function get scrollV() : Number
      {
         return _scrollV;
      }
      
      public function get maxScrollH() : int
      {
         return Math.max(0,_scrollAreaWidth - width);
      }
      
      public function get maxScrollV() : int
      {
         return Math.max(0,UnknownVarFromItemListController_Number_1 - height);
      }
      
      public function get isPartOfGridWindow() : Boolean
      {
         return _isPartOfGridWindow;
      }
      
      public function set isPartOfGridWindow(param1:Boolean) : void
      {
         _isPartOfGridWindow = param1;
      }
      
      public function get scrollableWindow() : IWindowModel
      {
         return this;
      }
      
      public function get visibleRegion() : Rectangle
      {
         return new Rectangle(_scrollH * maxScrollH,_scrollV * maxScrollV,width,height);
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return _container.rectangle;
      }
      
      public function set scrollH(param1:Number) : void
      {
         setScrollH(param1,false);
      }
      
      private function setScrollH(param1:Number, param2:Boolean) : void
      {
         var _loc5_:WindowEvent = null;
         var _loc4_:Number = this.maxScrollH;
         if(!isFinite(_loc4_) || _loc4_ <= 0)
         {
            param1 = 0;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc3_:Number = param1 - _scrollH;
         if(param1 != _scrollH)
         {
            _scrollH = param1;
            _container.x = -_scrollH * _loc4_;
            _context.invalidate(_container,visibleRegion,1);
            if(UnknownVarFromWindowController_WindowEventDispatcher_1)
            {
               _loc5_ = WindowEvent.allocate("WE_SCROLL",this,null);
               UnknownVarFromWindowController_WindowEventDispatcher_1.dispatchEvent(_loc5_);
               _loc5_.recycle();
            }
         }
         if(!param2 && UnknownVarFromItemListController_SmoothScroller_1 != null && UnknownVarFromItemListController_SmoothScroller_1.isScrolling)
         {
            UnknownVarFromItemListController_SmoothScroller_1.adjustStartPosition(_loc3_);
         }
      }
      
      public function set scrollV(param1:Number) : void
      {
         setScrollV(param1,false);
      }
      
      private function setScrollV(param1:Number, param2:Boolean) : void
      {
         var _loc4_:WindowEvent = null;
         var _loc5_:Number = this.maxScrollV;
         if(!isFinite(_loc5_) || _loc5_ <= 0)
         {
            param1 = 0;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc3_:Number = param1 - _scrollV;
         if(param1 != _scrollV)
         {
            _scrollV = param1;
            _container.y = -_scrollV * _loc5_;
            _context.invalidate(_container,visibleRegion,1);
            if(UnknownVarFromWindowController_WindowEventDispatcher_1)
            {
               _loc4_ = WindowEvent.allocate("WE_SCROLL",this,null);
               UnknownVarFromWindowController_WindowEventDispatcher_1.dispatchEvent(_loc4_);
               _loc4_.recycle();
            }
         }
         if(!param2 && UnknownVarFromItemListController_SmoothScroller_2 != null && UnknownVarFromItemListController_SmoothScroller_2.isScrolling)
         {
            UnknownVarFromItemListController_SmoothScroller_2.adjustStartPosition(_loc3_);
         }
      }
      
      public function set scaleToFitItems(param1:Boolean) : void
      {
         if(_scaleToFitItems != param1)
         {
            _scaleToFitItems = param1;
            updateScrollAreaRegion();
         }
      }
      
      public function get scaleToFitItems() : Boolean
      {
         return _scaleToFitItems;
      }
      
      public function set autoArrangeItems(param1:Boolean) : void
      {
         _arrangeListItems = param1;
         updateScrollAreaRegion();
      }
      
      public function get autoArrangeItems() : Boolean
      {
         return _arrangeListItems;
      }
      
      public function set resizeOnItemUpdate(param1:Boolean) : void
      {
         _resizeOnItemUpdate = param1;
         if(_container)
         {
            if(_isScrollHorizontal)
            {
               _container.setParamFlag(4194304,param1);
            }
            else
            {
               _container.setParamFlag(8388608,param1);
            }
         }
      }
      
      public function set inverseResizeOnItemUpdate(param1:Boolean) : void
      {
         if(param1 != _inverseResizeOnItemUpdate)
         {
            _inverseResizeOnItemUpdate = param1;
            if(_container)
            {
               if(_isScrollHorizontal)
               {
                  _container.setParamFlag(8388608,param1);
               }
               else
               {
                  _container.setParamFlag(4194304,param1);
               }
            }
            updateScrollAreaRegion();
         }
      }
      
      public function get resizeOnItemUpdate() : Boolean
      {
         return _resizeOnItemUpdate;
      }
      
      public function get inverseResizeOnItemUpdate() : Boolean
      {
         return _inverseResizeOnItemUpdate;
      }
      
      public function get iterator() : IIterator
      {
         return new ItemListIterator(this);
      }
      
      public function get firstListItem() : IWindowModel
      {
         return numListItems > 0 ? getListItemAt(0) : null;
      }
      
      public function get lastListItem() : IWindowModel
      {
         return numListItems > 0 ? getListItemAt(numListItems - 1) : null;
      }
      
      override public function set clipping(param1:Boolean) : void
      {
         super.clipping = param1;
         if(_container)
         {
            _container.clipping = param1;
         }
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            _container.removeEventListener("WE_RESIZED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_REMOVED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_RESIZED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_VISIBILITY",containerEventHandler);
            _container.removeEventListener("WE_CHILD_RELOCATED",containerEventHandler);
            if(UnknownVarFromItemListController_SmoothScroller_1 != null)
            {
               UnknownVarFromItemListController_SmoothScroller_1.dispose();
               UnknownVarFromItemListController_SmoothScroller_1 = null;
            }
            if(UnknownVarFromItemListController_SmoothScroller_2 != null)
            {
               UnknownVarFromItemListController_SmoothScroller_2.dispose();
               UnknownVarFromItemListController_SmoothScroller_2 = null;
            }
            super.dispose();
         }
      }
      
      override protected function cloneChildWindows(param1:WindowController) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < numListItems)
         {
            IItemListWindow(param1).addListItem(getListItemAt(_loc2_).clone());
            _loc2_++;
         }
      }
      
      public function get numListItems() : int
      {
         return _container != null ? _container.numChildren : 0;
      }
      
      public function addListItem(param1:IWindowModel) : IWindowModel
      {
         UnknownVarFromItemListController_Boolean_2 = true;
         if(_isScrollHorizontal)
         {
            param1.x = _scrollAreaWidth + (numListItems > 0 ? _spacing : 0);
            _scrollAreaWidth = param1.right;
            _container.width = _scrollAreaWidth;
         }
         else
         {
            if(autoArrangeItems)
            {
               param1.y = UnknownVarFromItemListController_Number_1 + (numListItems > 0 ? _spacing : 0);
               UnknownVarFromItemListController_Number_1 = param1.bottom;
            }
            else
            {
               UnknownVarFromItemListController_Number_1 = Math.max(UnknownVarFromItemListController_Number_1,param1.bottom);
            }
            _container.height = UnknownVarFromItemListController_Number_1;
         }
         param1 = _container.addChild(param1);
         UnknownVarFromItemListController_Boolean_2 = false;
         return param1;
      }
      
      public function addListItemAt(param1:IWindowModel, param2:uint) : IWindowModel
      {
         param1 = _container.addChildAt(param1,param2);
         updateScrollAreaRegion();
         return param1;
      }
      
      public function getListItemAt(param1:uint) : IWindowModel
      {
         return _container.getChildAt(param1);
      }
      
      public function getListItemByID(param1:uint) : IWindowModel
      {
         return _container.getChildByID(param1);
      }
      
      public function getListItemByName(param1:String) : IWindowModel
      {
         return _container.getChildByName(param1);
      }
      
      public function getListItemByTag(param1:String) : IWindowModel
      {
         return _container.getChildByTag(param1);
      }
      
      public function getListItemIndex(param1:IWindowModel) : int
      {
         return _container.getChildIndex(param1);
      }
      
      public function removeListItem(param1:IWindowModel) : IWindowModel
      {
         param1 = _container.removeChild(param1);
         if(param1)
         {
            updateScrollAreaRegion();
         }
         return param1;
      }
      
      public function removeListItemAt(param1:int) : IWindowModel
      {
         return _container.removeChildAt(param1);
      }
      
      public function setListItemIndex(param1:IWindowModel, param2:int) : void
      {
         _container.setChildIndex(param1,param2);
      }
      
      public function swapListItems(param1:IWindowModel, param2:IWindowModel) : void
      {
         _container.swapChildren(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function swapListItemsAt(param1:int, param2:int) : void
      {
         _container.swapChildrenAt(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function groupListItemsWithID(param1:uint, param2:Array, param3:int = 0) : uint
      {
         return _container.groupChildrenWithID(param1,param2,param3);
      }
      
      public function groupListItemsWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         return _container.groupChildrenWithTag(param1,param2,param3);
      }
      
      public function removeListItems() : void
      {
         UnknownVarFromItemListController_Boolean_2 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0);
         }
         UnknownVarFromItemListController_Boolean_2 = false;
         updateScrollAreaRegion();
      }
      
      public function destroyListItems() : void
      {
         UnknownVarFromItemListController_Boolean_2 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0).destroy();
         }
         UnknownVarFromItemListController_Boolean_2 = false;
         updateScrollAreaRegion();
      }
      
      public function arrangeListItems() : void
      {
         updateScrollAreaRegion();
      }
      
      override public function populate(param1:Array) : void
      {
         WindowController(_container).populate(param1);
         updateScrollAreaRegion();
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         switch(param2.type)
         {
            case "WE_RESIZE":
               UnknownVarFromItemListController_Boolean_1 = true;
               break;
            case "WE_RESIZED":
               if(!_scaleToFitItems && !_inverseResizeOnItemUpdate)
               {
                  if(_isScrollHorizontal)
                  {
                     _container.height = _height;
                  }
                  else
                  {
                     _container.width = _width;
                  }
               }
               updateScrollAreaRegion();
               UnknownVarFromItemListController_Boolean_1 = false;
               break;
            default:
               if(param2 is WindowEvent)
               {
                  _loc3_ = process(param2 as WindowEvent);
               }
         }
         return _loc3_;
      }
      
      override public function validateLocalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         return isInWindowBounds(param1);
      }
      
      public function process(param1:WindowEvent) : Boolean
      {
         if(!(param1 is WindowMouseEvent))
         {
            return false;
         }
         switch(param1.type)
         {
            case "WME_WHEEL":
            case "WME_WHEEL_HORIZONTAL":
               break;
            default:
               return false;
         }
         if(_isPartOfGridWindow)
         {
            return false;
         }
         return handleScrollWheelEvent(param1);
      }
      
      protected function get isScrollHorizontal() : Boolean
      {
         return _isScrollHorizontal;
      }
      
      public function scrollWithWheel(param1:Number, param2:Boolean) : Boolean
      {
         return getSmoothScroller(param2).scrollWithWheel(param1);
      }
      
      protected function handleScrollWheelEvent(param1:WindowEvent) : Boolean
      {
         return scrollWithWheel(getScrollWheelDelta(WindowMouseEvent(param1)),param1.type == "WME_WHEEL_HORIZONTAL" || Boolean(WindowMouseEvent(param1).shiftKey));
      }
      
      protected function getScrollWheelDelta(param1:WindowMouseEvent) : Number
      {
         if(param1 == null)
         {
            return 0;
         }
         return param1.type == "WME_WHEEL_HORIZONTAL" ? -param1.delta : param1.delta;
      }
      
      private function getSmoothScroller(param1:Boolean) : SmoothScroller
      {
         return param1 ? horizontalSmoothScroller : verticalSmoothScroller;
      }
      
      private function get horizontalSmoothScroller() : SmoothScroller
      {
         if(UnknownVarFromItemListController_SmoothScroller_1 == null)
         {
            UnknownVarFromItemListController_SmoothScroller_1 = new SmoothScroller(getHorizontalScrollPosition,setHorizontalSmoothScrollPosition,getHorizontalMaxScroll);
         }
         return UnknownVarFromItemListController_SmoothScroller_1;
      }
      
      private function get verticalSmoothScroller() : SmoothScroller
      {
         if(UnknownVarFromItemListController_SmoothScroller_2 == null)
         {
            UnknownVarFromItemListController_SmoothScroller_2 = new SmoothScroller(getVerticalScrollPosition,setVerticalSmoothScrollPosition,getVerticalMaxScroll);
         }
         return UnknownVarFromItemListController_SmoothScroller_2;
      }
      
      private function getHorizontalScrollPosition() : Number
      {
         return scrollH;
      }
      
      private function setHorizontalSmoothScrollPosition(param1:Number) : void
      {
         setScrollH(param1,true);
      }
      
      private function getHorizontalMaxScroll() : Number
      {
         return maxScrollH;
      }
      
      private function getVerticalScrollPosition() : Number
      {
         return scrollV;
      }
      
      private function setVerticalSmoothScrollPosition(param1:Number) : void
      {
         setScrollV(param1,true);
      }
      
      private function getVerticalMaxScroll() : Number
      {
         return maxScrollV;
      }
      
      private function setAbsoluteScrollH(param1:Number) : void
      {
         var _loc2_:Number = maxScrollH;
         if(!isFinite(_loc2_) || _loc2_ <= 0)
         {
            _scrollH = 0;
            _container.x = 0;
            return;
         }
         param1 = Math.max(0,Math.min(param1,_loc2_));
         _scrollH = param1 / _loc2_;
         _container.x = -param1;
      }
      
      private function setAbsoluteScrollV(param1:Number) : void
      {
         var _loc2_:Number = maxScrollV;
         if(!isFinite(_loc2_) || _loc2_ <= 0)
         {
            _scrollV = 0;
            _container.y = 0;
            return;
         }
         param1 = Math.max(0,Math.min(param1,_loc2_));
         _scrollV = param1 / _loc2_;
         _container.y = -param1;
      }
      
      private function containerEventHandler(param1:WindowEvent) : void
      {
         var _loc2_:WindowEvent = null;
         switch(param1.type)
         {
            case "WE_CHILD_REMOVED":
               updateScrollAreaRegion();
               break;
            case "WE_CHILD_RESIZED":
               if(!UnknownVarFromItemListController_Boolean_1)
               {
                  updateScrollAreaRegion();
               }
               break;
            case "WE_CHILD_VISIBILITY":
               updateScrollAreaRegion();
               break;
            case "WE_CHILD_RELOCATED":
               updateScrollAreaRegion();
               break;
            case "WE_RESIZED":
               if(UnknownVarFromWindowController_WindowEventDispatcher_1)
               {
                  _loc2_ = WindowEvent.allocate("WE_RESIZED",this,null);
                  UnknownVarFromWindowController_WindowEventDispatcher_1.dispatchEvent(_loc2_);
                  _loc2_.recycle();
               }
         }
      }
      
      protected function updateScrollAreaRegion() : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:IWindowModel = null;
         var _loc1_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc2_:* = 0;
         if(_arrangeListItems && !UnknownVarFromItemListController_Boolean_2 && _container)
         {
            UnknownVarFromItemListController_Boolean_2 = true;
            _loc6_ = Math.max(0,-_container.x);
            _loc5_ = Math.max(0,-_container.y);
            _loc2_ = uint(_container.numChildren);
            if(_isScrollHorizontal)
            {
               _scrollAreaWidth = 0;
               UnknownVarFromItemListController_Number_1 = _height;
               _loc4_ = 0;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc7_ = _container.getChildAt(_loc3_);
                  if(_loc7_.visible)
                  {
                     _loc7_.x = _scrollAreaWidth;
                     _scrollAreaWidth += _loc7_.width + _spacing;
                     if(_scaleToFitItems)
                     {
                        _loc1_ = _loc7_.height + _loc7_.y;
                        UnknownVarFromItemListController_Number_1 = _loc1_ > UnknownVarFromItemListController_Number_1 ? _loc1_ : UnknownVarFromItemListController_Number_1;
                     }
                     if(_inverseResizeOnItemUpdate)
                     {
                        _loc1_ = getChildRequiredVerticalSpace(_loc7_);
                        _loc4_ = _loc1_ > _loc4_ ? _loc1_ : _loc4_;
                     }
                  }
                  _loc3_++;
               }
               if(_loc2_ > 0)
               {
                  _scrollAreaWidth -= _spacing;
               }
            }
            else
            {
               _scrollAreaWidth = _width;
               UnknownVarFromItemListController_Number_1 = 0;
               _loc4_ = 0;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc7_ = _container.getChildAt(_loc3_);
                  if(_loc7_.visible)
                  {
                     _loc7_.y = UnknownVarFromItemListController_Number_1;
                     UnknownVarFromItemListController_Number_1 += _loc7_.height + _spacing;
                     if(_scaleToFitItems)
                     {
                        _loc1_ = _loc7_.width + _loc7_.x;
                        _scrollAreaWidth = _loc1_ > _scrollAreaWidth ? _loc1_ : _scrollAreaWidth;
                     }
                     if(_inverseResizeOnItemUpdate)
                     {
                        _loc1_ = getChildRequiredHorizontalSpace(_loc7_);
                        _loc4_ = _loc1_ > _loc4_ ? _loc1_ : _loc4_;
                     }
                  }
                  _loc3_++;
               }
               if(_loc2_ > 0)
               {
                  UnknownVarFromItemListController_Number_1 -= _spacing;
               }
            }
            setAbsoluteScrollH(_loc6_);
            setAbsoluteScrollV(_loc5_);
            _container.height = UnknownVarFromItemListController_Number_1;
            _container.width = _scrollAreaWidth;
            if(_inverseResizeOnItemUpdate)
            {
               if(_isScrollHorizontal)
               {
                  limits.minHeight = _loc4_;
                  limits.maxHeight = _loc4_;
                  _container.height = _loc4_;
               }
               else
               {
                  limits.minWidth = _loc4_;
                  limits.maxWidth = _loc4_;
                  _container.width = _loc4_;
               }
            }
            UnknownVarFromItemListController_Boolean_2 = false;
         }
      }
      
      private function getChildRequiredHorizontalSpace(param1:IWindowModel) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:uint = uint(param1.param & 0xC0);
         if(_loc2_ == 128)
         {
            _loc4_ = Math.max(0,param1.x);
            _loc3_ = Math.max(0,_width - param1.x - param1.width);
            return param1.limits.minWidth + _loc4_ + _loc3_;
         }
         if(_loc2_ == 64)
         {
            return _width - param1.x;
         }
         if(_loc2_ == 192)
         {
            return param1.width;
         }
         return param1.x + param1.width;
      }
      
      private function getChildRequiredVerticalSpace(param1:IWindowModel) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = uint(param1.param & 0x0C00);
         if(_loc4_ == 2048)
         {
            _loc2_ = param1.y;
            _loc3_ = _height - param1.y - param1.height;
            return param1.limits.minWidth + _loc2_ + _loc3_;
         }
         if(_loc4_ == 1024)
         {
            return _height - param1.y;
         }
         if(_loc4_ == 3072)
         {
            return param1.height;
         }
         return param1.y + param1.height;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",_spacing));
         _loc1_.push(createProperty("auto_arrange_items",_arrangeListItems));
         _loc1_.push(createProperty("scale_to_fit_items",_scaleToFitItems));
         _loc1_.push(createProperty("resize_on_item_update",_resizeOnItemUpdate));
         _loc1_.push(createProperty("inverse_resize_on_item_update",_inverseResizeOnItemUpdate));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  spacing = _loc2_.value as int;
                  break;
               case "scale_to_fit_items":
                  scaleToFitItems = _loc2_.value as Boolean;
                  break;
               case "resize_on_item_update":
                  resizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case "inverse_resize_on_item_update":
                  inverseResizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case "auto_arrange_items":
                  _arrangeListItems = _loc2_.value as Boolean;
                  break;
            }
         }
         super.properties = param1;
      }
   }
}

