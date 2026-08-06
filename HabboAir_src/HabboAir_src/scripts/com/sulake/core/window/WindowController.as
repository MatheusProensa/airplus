package com.sulake.core.window
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.dynamicstyle.DynamicStyle;
   import com.sulake.core.window.dynamicstyle.DynamicStyleManager;
   import com.sulake.core.window.events.WindowDisposeEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowEventDispatcher;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.services.IMouseListenerService;
   import com.sulake.core.window.theme.IPropertyMap;
   import com.sulake.core.window.utils.DefaultAttStruct;
   import com.sulake.core.window.utils.IRectLimiter;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils5;
   import com.sulake.core.window.utils.WindowRectLimits;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class WindowController extends WindowModel implements IWindowModel, IGraphicContextHost, UnknownICoreWindowUtils5
   {
      private static var UnknownVarFromWindowController_Uint_1:uint = 0;
      
      public static const TAG_EXCLUDE:String = "_EXCLUDE";
      
      public static const TAG_INTERNAL:String = "_INTERNAL";
      
      public static const TAG_COLORIZE:String = "_COLORIZE";
      
      public static const TAG_IGNORE_INHERITED_STYLE:String = "_IGNORE_INHERITED_STYLE";
      
      private static const UnknownConstFromWindowController_Rectangle_1:Rectangle = new Rectangle();
      
      private static const _POINT_ZERO:Point = new Point();
      
      protected var UnknownVarFromWindowController_WindowEventDispatcher_1:WindowEventDispatcher;
      
      protected var UnknownVarFromWindowController_IGraphicContext_1:IGraphicContext;
      
      protected var UnknownVarFromWindowController_Function_1:Function;
      
      protected var UnknownVarFromWindowController_Boolean_1:Boolean = true;
      
      protected var _parent:WindowController;
      
      protected var _children:Vector.<IWindowModel>;
      
      protected var _debug:Boolean = false;
      
      protected var UnknownVarFromWindowController_WindowRectLimits_1:WindowRectLimits;
      
      protected var _immediateClickMode:Boolean = false;
      
      private var UnknownVarFromWindowController_DynamicStyle_1:DynamicStyle;
      
      private var UnknownVarFromWindowController_Boolean_2:Boolean = false;
      
      private var UnknownVarFromWindowController_Rectangle_1:Rectangle;
      
      private var _hCenterRem2:int = 0;
      
      private var UnknownVarFromWindowController_Boolean_3:Boolean = false;
      
      private var UnknownVarFromWindowController_Uint_2:uint;
      
      private var UnknownVarFromWindowController_IPropertyMap_1:IPropertyMap;
      
      private var _lookupCache:Dictionary;
      
      public function WindowController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0, param12:String = "")
      {
         var _loc13_:* = 0;
         UnknownVarFromWindowController_Uint_2 = UnknownVarFromWindowController_Uint_1++;
         var _loc14_:XML = param5.getWindowFactory().getLayoutByTypeAndStyle(param2,param3);
         if(param6 == null)
         {
            param6 = new Rectangle(0,0,!!_loc14_ ? int(_loc14_.attribute("width")) : 10,!!_loc14_ ? int(_loc14_.attribute("height")) : 10);
         }
         UnknownVarFromWindowController_IPropertyMap_1 = param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3);
         super(param11,param1,param2,param3,param4,param5,param6,param10,param12);
         if(!UnknownVarFromWindowController_IGraphicContext_1)
         {
            UnknownVarFromWindowController_IGraphicContext_1 = getGraphicContext(!testParamFlag(16));
         }
         UnknownVarFromWindowController_Rectangle_1 = new Rectangle();
         if(_loc14_ != null)
         {
            UnknownVarFromWindowModel_Rectangle_1 = new Rectangle(0,0,int(_loc14_.attribute("width")),int(_loc14_.attribute("height")));
            UnknownVarFromWindowModel_Rectangle_2 = UnknownVarFromWindowModel_Rectangle_1.clone();
            _x = UnknownVarFromWindowModel_Rectangle_1.x;
            _y = UnknownVarFromWindowModel_Rectangle_1.y;
            _width = UnknownVarFromWindowModel_Rectangle_1.width;
            _height = UnknownVarFromWindowModel_Rectangle_1.height;
            param5.getWindowParser().parseAndConstruct(_loc14_,this,null);
            _loc13_ = _param;
            _param &= ~12582912;
            setRectangle(param6.x,param6.y,param6.width,param6.height);
            _param = _loc13_;
            UnknownVarFromWindowModel_Rectangle_2.x = param6.x;
            UnknownVarFromWindowModel_Rectangle_2.y = param6.y;
            UnknownVarFromWindowModel_Rectangle_2.width = param6.width;
            UnknownVarFromWindowModel_Rectangle_2.height = param6.height;
         }
         var _loc15_:DefaultAttStruct = param5.getWindowFactory().getDefaultsByTypeAndStyle(param2,param3);
         if(_loc15_)
         {
            _blend = _loc15_.blend;
            _mouseThreshold = _loc15_.threshold;
            if(_background != _loc15_.background)
            {
               background = _loc15_.background;
            }
            if(_fillColor != _loc15_.color)
            {
               color = _loc15_.color;
            }
            if(_loc15_.hasRectLimits())
            {
               WindowRectLimits(limits).assign(_loc15_.width_min,_loc15_.width_max,_loc15_.height_min,_loc15_.height_max);
            }
         }
         if(param9)
         {
            this.properties = param9;
         }
         UnknownVarFromWindowController_Function_1 = param8;
         if(param7 != null)
         {
            _parent = param7 as WindowController;
            WindowController(param7).addChild(this);
            if(UnknownVarFromWindowController_IGraphicContext_1)
            {
               _context.invalidate(this,null,1);
            }
         }
      }
      
      private static function calculateMouseRegion(param1:WindowController, param2:Rectangle) : void
      {
         var _loc7_:int = 0;
         var _loc3_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc3_);
         var _loc5_:int = param1.numChildren;
         var _loc4_:int = _loc3_.x;
         var _loc6_:int = _loc3_.y;
         param2.left = _loc4_ < param2.left ? _loc4_ : param2.left;
         param2.top = _loc6_ < param2.top ? _loc6_ : param2.top;
         param2.right = _loc3_.right > param2.right ? _loc3_.right : param2.right;
         param2.bottom = _loc3_.bottom > param2.bottom ? _loc3_.bottom : param2.bottom;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            WindowController.calculateMouseRegion(param1.getChildAt(_loc7_) as WindowController,param2);
            _loc7_++;
         }
      }
      
      public static function expandToAccommodateChild(param1:WindowController, param2:IWindowModel) : void
      {
         var _loc6_:* = 0;
         var _loc9_:* = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc10_:int = param1.width;
         var _loc5_:int = param1.height;
         var _loc8_:Boolean = false;
         if(param2.x < 0)
         {
            _loc4_ = param2.x;
            _loc10_ -= _loc4_;
            param2.x = 0;
            _loc8_ = true;
         }
         if(param2.right > _loc10_)
         {
            _loc10_ = param2.x + param2.width;
            _loc8_ = true;
         }
         if(param2.y < 0)
         {
            _loc3_ = param2.y;
            _loc5_ -= _loc3_;
            param2.y = 0;
            _loc8_ = true;
         }
         if(param2.bottom > _loc5_)
         {
            _loc5_ = param2.y + param2.height;
            _loc8_ = true;
         }
         if(_loc8_)
         {
            _loc6_ = uint(param1.param & (131072 | 147456));
            if(_loc6_)
            {
               param1.setParamFlag(_loc6_,false);
            }
            param1.setRectangle(param1.x + _loc4_,param1.y + _loc3_,_loc10_,_loc5_);
            if(_loc3_ != 0 || _loc4_ != 0)
            {
               var _loc7_:uint = uint(param1.numChildren);
               _loc9_ = 0;
               while(_loc9_ < _loc7_)
               {
                  IWindowModel(param1.getChildAt(_loc9_)).offset(-_loc4_,-_loc3_);
                  _loc9_++;
               }
            }
            if(_loc6_)
            {
               param1.setParamFlag(_loc6_,true);
            }
         }
      }
      
      public static function resizeToAccommodateChildren(param1:WindowController) : void
      {
         var _loc11_:IWindowModel = null;
         var _loc9_:* = 0;
         var _loc7_:* = 0;
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = -2147483648;
         var _loc10_:int = -2147483648;
         var _loc8_:Boolean = false;
         var _loc6_:uint = uint(param1.numChildren);
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc11_ = param1.getChildAt(_loc9_);
            if(_loc11_.visible && _loc11_.x + _loc11_.width > _loc5_)
            {
               _loc5_ = _loc11_.x + _loc11_.width;
               _loc8_ = true;
            }
            if(_loc11_.visible && _loc11_.y + _loc11_.height > _loc10_)
            {
               _loc10_ = _loc11_.y + _loc11_.height;
               _loc8_ = true;
            }
            _loc9_++;
         }
         if(_loc8_)
         {
            _loc7_ = uint(param1.param & (131072 | 147456));
            if(_loc7_)
            {
               param1.setParamFlag(_loc7_,false);
            }
            if(_loc3_ != 0 || _loc2_ != 0)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc6_)
               {
                  _loc11_ = param1.getChildAt(_loc9_);
                  _loc4_ = _loc11_.testParamFlag(32);
                  if(_loc4_)
                  {
                     _loc11_.setParamFlag(32,false);
                  }
                  _loc11_.offset(-_loc3_,-_loc2_);
                  if(_loc4_)
                  {
                     _loc11_.setParamFlag(32,true);
                  }
                  _loc9_++;
               }
            }
            param1.width = _loc5_;
            param1.height = _loc10_;
            if(_loc7_)
            {
               param1.setParamFlag(_loc7_,true);
            }
         }
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function get procedure() : Function
      {
         return UnknownVarFromWindowController_Function_1 ?? (_parent != null ? _parent.procedure : nullEventProc);
      }
      
      public function get filters() : Array
      {
         return hasGraphicsContext() ? getGraphicContext(true).filters : [];
      }
      
      public function get parent() : IWindowModel
      {
         return _parent;
      }
      
      public function get debug() : Boolean
      {
         return _debug;
      }
      
      public function get limits() : IRectLimiter
      {
         return !!UnknownVarFromWindowController_WindowRectLimits_1 ? UnknownVarFromWindowController_WindowRectLimits_1 : (UnknownVarFromWindowController_WindowRectLimits_1 = new WindowRectLimits(this));
      }
      
      public function get immediateClickMode() : Boolean
      {
         return _immediateClickMode;
      }
      
      public function set x(param1:int) : void
      {
         if(param1 != _x)
         {
            setRectangle(param1,_y,_width,_height);
         }
      }
      
      public function set y(param1:int) : void
      {
         if(param1 != _y)
         {
            setRectangle(_x,param1,_width,_height);
         }
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set width(param1:int) : void
      {
         if(param1 != _width)
         {
            setRectangle(_x,_y,param1,_height);
         }
      }
      
      public function set height(param1:int) : void
      {
         if(param1 != _height)
         {
            setRectangle(_x,_y,_width,param1);
         }
      }
      
      public function set position(param1:Point) : void
      {
         setRectangle(param1.x,param1.y,_width,_height);
      }
      
      public function set rectangle(param1:Rectangle) : void
      {
         setRectangle(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function set background(param1:Boolean) : void
      {
         _background = param1;
         _fillColor = _background ? _fillColor | _alphaColor : _fillColor & 0xFFFFFF;
         UnknownVarFromWindowController_Boolean_1 ||= param1;
         _context.invalidate(this,null,1);
      }
      
      public function set color(param1:uint) : void
      {
         _alphaColor = param1 & 4278190080;
         _fillColor = _background ? param1 : param1 & 0xFFFFFF;
         _context.invalidate(this,null,1);
      }
      
      public function set alpha(param1:uint) : void
      {
         _alphaColor = param1 << 24;
         _fillColor = _background ? _alphaColor | _fillColor : 0xFFFFFF & _fillColor;
         _context.invalidate(this,null,1);
      }
      
      public function set blend(param1:Number) : void
      {
         param1 = param1 > 1 ? 1 : (param1 < 0 ? 0 : param1);
         if(param1 != _blend)
         {
            _blend = param1;
            _context.invalidate(this,null,16);
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         var _loc2_:WindowEvent = null;
         if(param1 != _visible)
         {
            _visible = param1;
            if(UnknownVarFromWindowController_IGraphicContext_1 && !param1)
            {
               UnknownVarFromWindowController_IGraphicContext_1.visible = false;
            }
            _context.invalidate(this,null,1);
            _loc2_ = WindowEvent.allocate("WE_CHILD_VISIBILITY",this,this);
            update(this,_loc2_);
            _loc2_.recycle();
         }
      }
      
      public function set type(param1:uint) : void
      {
         if(param1 != _type)
         {
            _type = param1;
            _context.invalidate(this,null,1);
         }
      }
      
      public function set caption(param1:String) : void
      {
         param1 = !!param1 ? param1 : "";
         if(param1 != caption)
         {
            _caption = param1;
            _context.invalidate(this,null,1);
         }
      }
      
      public function set tags(param1:Array) : void
      {
         if(param1 != null)
         {
            UnknownVarFromWindowModel_Array_1 = param1;
         }
      }
      
      public function set mouseThreshold(param1:uint) : void
      {
         _mouseThreshold = param1 > 255 ? 255 : param1;
      }
      
      public function set ignoreMouseEvents(param1:Boolean) : void
      {
         _ignoreMouseEvents = param1;
      }
      
      public function set procedure(param1:Function) : void
      {
         UnknownVarFromWindowController_Function_1 = param1;
      }
      
      public function set filters(param1:Array) : void
      {
         if(hasGraphicsContext())
         {
            getGraphicContext(true).filters = param1;
         }
      }
      
      public function set debug(param1:Boolean) : void
      {
         _debug = param1;
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function set offsetX(param1:int) : void
      {
         _offsetX = param1;
      }
      
      public function set offsetY(param1:int) : void
      {
         _offsetY = param1;
      }
      
      public function set etching(param1:Array) : void
      {
      }
      
      public function set state(param1:uint) : void
      {
         if(param1 != _state)
         {
            _state = param1;
            _context.invalidate(this,null,8);
         }
      }
      
      public function set dynamicStyleColor(param1:ColorTransform) : void
      {
         _dynamicStyleColor = param1;
      }
      
      public function get dynamicStyleColor() : ColorTransform
      {
         return _dynamicStyleColor;
      }
      
      public function set style(param1:uint) : void
      {
         var _loc2_:Array = null;
         var _loc3_:WindowController = null;
         var _loc4_:* = 0;
         if(param1 != _style)
         {
            _style = param1;
            _loc2_ = [];
            groupChildrenWithTag("_INTERNAL",_loc2_);
            _loc4_ = _loc2_.length;
            while(--_loc4_ > -1)
            {
               _loc3_ = _loc2_[_loc4_] as WindowController;
               if(_loc3_.tags.indexOf("_IGNORE_INHERITED_STYLE") == -1)
               {
                  _loc3_.style = _style;
               }
            }
            _context.invalidate(this,null,1);
            UnknownVarFromWindowController_IPropertyMap_1 = _context.getWindowFactory().getThemeManager().getPropertyDefaults(_style);
         }
      }
      
      public function set dynamicStyle(param1:String) : void
      {
         _dynamicStyle = param1;
         _context.invalidate(this,null,1);
      }
      
      public function set clipping(param1:Boolean) : void
      {
         if(param1 != _clipping)
         {
            _clipping = param1;
            _context.invalidate(this,null,1);
         }
      }
      
      public function get host() : IWindowModel
      {
         return _parent == desktop ? this : _parent.host;
      }
      
      public function get desktop() : IDesktopController
      {
         return _context.getDesktopWindow();
      }
      
      public function set parent(param1:IWindowModel) : void
      {
         var _loc3_:WindowEvent = null;
         if(param1 == this)
         {
            throw new Error("Attempted to assign self as parent!");
         }
         if(param1 != null && param1.context != _context)
         {
            _context = WindowContext(param1.context);
            if(_children)
            {
               for each(var _loc4_ in _children)
               {
                  _loc4_.parent = this;
               }
            }
         }
         var _loc2_:IWindowModel = _parent;
         if(_parent != param1)
         {
            if(_parent != null)
            {
               _parent.removeChild(this);
            }
            _parent = WindowController(param1);
            if(_parent != null)
            {
               UnknownVarFromWindowController_Rectangle_1 = _parent.rectangle;
               UnknownVarFromWindowModel_Rectangle_2.x = _x;
               UnknownVarFromWindowModel_Rectangle_2.y = _y;
               UnknownVarFromWindowModel_Rectangle_2.width = _width;
               UnknownVarFromWindowModel_Rectangle_2.height = _height;
               _loc3_ = WindowEvent.allocate("WE_PARENT_ADDED",this,_parent);
               update(this,_loc3_);
            }
            else
            {
               UnknownVarFromWindowController_Rectangle_1.x = 0;
               UnknownVarFromWindowController_Rectangle_1.y = 0;
               UnknownVarFromWindowController_Rectangle_1.width = 0;
               UnknownVarFromWindowController_Rectangle_1.height = 0;
               _loc3_ = WindowEvent.allocate("WE_PARENT_REMOVED",this,_loc2_);
               update(this,_loc3_);
            }
            _loc3_.recycle();
         }
      }
      
      public function hasGraphicsContext() : Boolean
      {
         return UnknownVarFromWindowController_IGraphicContext_1 != null || !testParamFlag(16);
      }
      
      public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !UnknownVarFromWindowController_IGraphicContext_1)
         {
            UnknownVarFromWindowController_IGraphicContext_1 = new GraphicContext("GC {" + _name + "}",1,new Rectangle(_x,_y,_width,_height));
            UnknownVarFromWindowController_IGraphicContext_1.visible = _visible;
         }
         return UnknownVarFromWindowController_IGraphicContext_1;
      }
      
      public function setupGraphicsContext() : IGraphicContext
      {
         var _loc1_:int = 0;
         UnknownVarFromWindowController_IGraphicContext_1 = getGraphicContext(true);
         if(_parent)
         {
            _parent.setupGraphicsContext();
         }
         if(_children && _children.length > 0)
         {
            if(UnknownVarFromWindowController_IGraphicContext_1.numChildContexts != numChildren)
            {
               _loc1_ = 0;
               for each(var _loc2_ in _children)
               {
                  UnknownVarFromWindowController_IGraphicContext_1.addChildContextAt(_loc2_.getGraphicContext(true),_loc1_++);
               }
            }
         }
         UnknownVarFromWindowController_Boolean_2 = true;
         return UnknownVarFromWindowController_IGraphicContext_1;
      }
      
      public function releaseGraphicsContext() : void
      {
         UnknownVarFromWindowController_Boolean_2 = false;
         if(!UnknownVarFromWindowController_IGraphicContext_1)
         {
         }
      }
      
      public function clone() : IWindowModel
      {
         var _loc2_:Class = Object(this).constructor;
         var _loc1_:WindowController = new _loc2_(_name,_type,_style,_param,_context,new Rectangle(_x,_y,_width,_height),null,UnknownVarFromWindowController_Function_1,properties,!!UnknownVarFromWindowModel_Array_1 ? UnknownVarFromWindowModel_Array_1.concat() : null,_id) as WindowController;
         _loc1_.dynamicStyle = _dynamicStyle;
         _loc1_._mouseThreshold = _mouseThreshold;
         _loc1_._ignoreMouseEvents = _ignoreMouseEvents;
         _loc1_.UnknownVarFromWindowController_Boolean_1 = UnknownVarFromWindowController_Boolean_1;
         _loc1_._debug = _debug;
         _loc1_.UnknownVarFromWindowController_Rectangle_1 = UnknownVarFromWindowController_Rectangle_1.clone();
         _loc1_._hCenterRem2 = _hCenterRem2;
         _loc1_._x = _x;
         _loc1_._y = _y;
         _loc1_._width = _width;
         _loc1_._height = _height;
         _loc1_.UnknownVarFromWindowModel_Rectangle_1 = UnknownVarFromWindowModel_Rectangle_1.clone();
         _loc1_.UnknownVarFromWindowModel_Rectangle_2 = UnknownVarFromWindowModel_Rectangle_2.clone();
         _loc1_.UnknownVarFromWindowModel_Rectangle_3 = !!UnknownVarFromWindowModel_Rectangle_3 ? UnknownVarFromWindowModel_Rectangle_3.clone() : null;
         _loc1_.UnknownVarFromWindowModel_Rectangle_4 = !!UnknownVarFromWindowModel_Rectangle_4 ? UnknownVarFromWindowModel_Rectangle_4.clone() : null;
         _loc1_.UnknownVarFromWindowController_WindowRectLimits_1 = !!UnknownVarFromWindowController_WindowRectLimits_1 ? UnknownVarFromWindowController_WindowRectLimits_1.clone(_loc1_) : null;
         _loc1_._context = _context;
         _loc1_._fillColor = _fillColor;
         _loc1_._alphaColor = _alphaColor;
         _loc1_.clipping = _clipping;
         _loc1_._visible = _visible;
         _loc1_._blend = _blend;
         if(_loc1_.UnknownVarFromWindowController_IGraphicContext_1 && !_loc1_.testParamFlag(16))
         {
            _loc1_.UnknownVarFromWindowController_IGraphicContext_1.blend = _blend;
         }
         _loc1_._param = _param;
         _loc1_._state = _state;
         _loc1_._name = _name;
         _loc1_._id = _id;
         _loc1_.caption = _caption;
         _loc1_.background = _background;
         cloneChildWindows(_loc1_);
         return _loc1_;
      }
      
      protected function cloneChildWindows(param1:WindowController) : void
      {
         var _loc2_:* = null;
         if(_children)
         {
            for each(_loc2_ in _children)
            {
               if(_loc2_.tags.indexOf("_EXCLUDE") == -1)
               {
                  param1.addChild(_loc2_.clone());
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:WindowDisposeEvent = null;
         if(!_disposed)
         {
            _lookupCache = null;
            immediateClickMode = false;
            UnknownVarFromWindowController_Function_1 = null;
            if(!_context.disposed)
            {
               if(!isChildWindow())
               {
                  if(getStateFlag(1))
                  {
                     deactivate();
                  }
               }
            }
            if(_children)
            {
               while(_children.length > 0)
               {
                  IComponentInterfaceQueue(_children.pop()).dispose();
               }
            }
            _children = null;
            if(parent)
            {
               parent = null;
            }
            if(UnknownVarFromWindowController_WindowEventDispatcher_1)
            {
               _loc1_ = WindowDisposeEvent.allocate(this);
               UnknownVarFromWindowController_WindowEventDispatcher_1.dispatchEvent(_loc1_);
               _loc1_.recycle();
               if(UnknownVarFromWindowController_WindowEventDispatcher_1 is IComponentInterfaceQueue)
               {
                  IComponentInterfaceQueue(UnknownVarFromWindowController_WindowEventDispatcher_1).dispose();
                  UnknownVarFromWindowController_WindowEventDispatcher_1 = null;
               }
            }
            if(UnknownVarFromWindowController_IGraphicContext_1 != null)
            {
               UnknownVarFromWindowController_IGraphicContext_1.dispose();
               UnknownVarFromWindowController_IGraphicContext_1 = null;
            }
            super.dispose();
         }
      }
      
      public function toString() : String
      {
         return "[Window " + getQualifiedClassName(this) + " " + _name + " " + UnknownVarFromWindowController_Uint_2 + "]";
      }
      
      override public function invalidate(param1:Rectangle = null) : void
      {
         _context.invalidate(this,param1,1);
      }
      
      public function resolve() : uint
      {
         return 0;
      }
      
      public function center() : void
      {
         if(_parent != null)
         {
            x = _parent.width / 2 - _width / 2;
            y = _parent.height / 2 - _height / 2;
         }
      }
      
      public function setRectangle(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc7_:int = 0;
         var _loc15_:WindowEvent = null;
         if(UnknownVarFromWindowController_WindowRectLimits_1)
         {
            param4 = Math.max(UnknownVarFromWindowController_WindowRectLimits_1.minHeight,param4);
            param4 = Math.min(UnknownVarFromWindowController_WindowRectLimits_1.maxHeight,param4);
            param3 = Math.max(UnknownVarFromWindowController_WindowRectLimits_1.minWidth,param3);
            param3 = Math.min(UnknownVarFromWindowController_WindowRectLimits_1.maxWidth,param3);
         }
         var _loc8_:* = param1 != _x;
         var _loc11_:* = param3 != _width;
         var _loc5_:Boolean = param1 != _x || param2 != _y;
         var _loc12_:Boolean = _loc11_ || param4 != _height;
         var _loc10_:int = _hCenterRem2;
         var _loc9_:Boolean = false;
         var _loc6_:* = param1;
         if(_loc12_ && !_loc5_)
         {
            _loc13_ = uint(_param & 786432);
            if(_loc11_)
            {
               if(_loc13_ == 786432)
               {
                  _loc14_ = _loc10_ - (param3 - _width);
                  _loc7_ = _loc14_ / 2;
                  param1 += _loc7_;
                  _loc10_ = _loc14_ - _loc7_ * 2;
                  _loc9_ = true;
                  _loc6_ = param1;
                  _loc5_ = param1 != _x || param2 != _y;
               }
               else if(_loc13_ == 262144)
               {
                  param1 -= param3 - _width;
                  _loc5_ = true;
               }
            }
            _loc13_ = uint(_param & 3145728);
            if(_loc13_ == 3145728)
            {
               param2 -= (param4 - _height) / 2;
               _loc5_ = true;
            }
            else if(_loc13_ == 1048576)
            {
               param2 -= param4 - _height;
               _loc5_ = true;
            }
         }
         if(testParamFlag(32))
         {
            if(_parent != null && _parent.name != "_CONTEXT_SUBSTITUTE_PARENT")
            {
               param1 = int(param1 < 0 ? 0 : param1);
               param2 = int(param2 < 0 ? 0 : param2);
               if(_loc5_)
               {
                  param1 -= param1 + param3 > _parent.width ? param1 + param3 - _parent.width : 0;
                  param2 -= param2 + param4 > _parent.height ? param2 + param4 - _parent.height : 0;
                  _loc5_ = param1 != _x || param2 != _y;
               }
               else
               {
                  param3 -= param1 + param3 > _parent.width ? param1 + param3 - _parent.width : 0;
                  param4 -= param2 + param4 > _parent.height ? param2 + param4 - _parent.height : 0;
                  _loc12_ = param3 != _width || param4 != _height;
               }
            }
         }
         if(_loc5_ || _loc12_)
         {
            if(_loc5_)
            {
               _loc15_ = WindowEvent.allocate("WE_RELOCATE",this,null,true);
               update(this,_loc15_);
               if(_loc15_.isWindowOperationPrevented())
               {
                  _loc5_ = false;
               }
               _loc15_.recycle();
            }
            if(_loc12_)
            {
               _loc15_ = WindowEvent.allocate("WE_RESIZE",this,null,true);
               update(this,_loc15_);
               if(_loc15_.isWindowOperationPrevented())
               {
                  _loc12_ = false;
               }
               _loc15_.recycle();
            }
            if(_loc8_ && (_loc5_ || _loc12_))
            {
               _hCenterRem2 = 0;
            }
            else if(_loc11_ && _loc12_)
            {
               _hCenterRem2 = _loc9_ && (!_loc5_ || param1 == _loc6_) ? _loc10_ : 0;
            }
            if(_loc5_)
            {
               UnknownVarFromWindowModel_Rectangle_2.x = _x;
               UnknownVarFromWindowModel_Rectangle_2.y = _y;
               UnknownVarFromWindowModel_Rectangle_2.width = _width;
               UnknownVarFromWindowModel_Rectangle_2.height = _height;
               _x = param1;
               _y = param2;
            }
            if(_loc12_)
            {
               UnknownVarFromWindowModel_Rectangle_2.width = _width;
               UnknownVarFromWindowModel_Rectangle_2.height = _height;
               _width = param3;
               _height = param4;
            }
            if(_loc5_)
            {
               _loc15_ = WindowEvent.allocate("WE_RELOCATED",this,null);
               update(this,_loc15_);
               _loc15_.recycle();
            }
            if(_loc12_)
            {
               _loc15_ = WindowEvent.allocate("WE_RESIZED",this,null);
               update(this,_loc15_);
               _loc15_.recycle();
            }
         }
      }
      
      public function getRegionProperties(param1:Rectangle = null, param2:Rectangle = null, param3:Rectangle = null, param4:Rectangle = null) : void
      {
         if(param1 != null)
         {
            param1.x = _x;
            param1.y = _y;
            param1.width = _width;
            param1.height = _height;
         }
         if(param2 != null)
         {
            param2.x = UnknownVarFromWindowModel_Rectangle_2.x;
            param2.y = UnknownVarFromWindowModel_Rectangle_2.y;
            param2.width = UnknownVarFromWindowModel_Rectangle_2.width;
            param2.height = UnknownVarFromWindowModel_Rectangle_2.height;
         }
         if(param3 != null && UnknownVarFromWindowModel_Rectangle_3 != null)
         {
            param3.x = UnknownVarFromWindowModel_Rectangle_3.x;
            param3.y = UnknownVarFromWindowModel_Rectangle_3.y;
            param3.width = UnknownVarFromWindowModel_Rectangle_3.width;
            param3.height = UnknownVarFromWindowModel_Rectangle_3.height;
         }
         if(param4 != null && UnknownVarFromWindowModel_Rectangle_4 != null)
         {
            param4.x = UnknownVarFromWindowModel_Rectangle_4.x;
            param4.y = UnknownVarFromWindowModel_Rectangle_4.y;
            param4.width = UnknownVarFromWindowModel_Rectangle_4.width;
            param4.height = UnknownVarFromWindowModel_Rectangle_4.height;
         }
      }
      
      public function setRegionProperties(param1:Rectangle = null, param2:Rectangle = null, param3:Rectangle = null) : void
      {
         if(param3 != null)
         {
            if(param3.width < 0 || param3.height < 0)
            {
               throw new Error("Invalid rectangle; maximized size can\'t be less than zero!");
            }
            if(UnknownVarFromWindowModel_Rectangle_4 == null)
            {
               UnknownVarFromWindowModel_Rectangle_4 = new Rectangle();
            }
            UnknownVarFromWindowModel_Rectangle_4.x = param3.x;
            UnknownVarFromWindowModel_Rectangle_4.y = param3.y;
            UnknownVarFromWindowModel_Rectangle_4.width = param3.width;
            UnknownVarFromWindowModel_Rectangle_4.height = param3.height;
         }
         if(param2 != null)
         {
            if(param2.width < 0 || param2.height < 0)
            {
               throw new Error("Invalid rectangle; minimized size can\'t be less than zero!");
            }
            if(UnknownVarFromWindowModel_Rectangle_3 == null)
            {
               UnknownVarFromWindowModel_Rectangle_3 = new Rectangle();
            }
            UnknownVarFromWindowModel_Rectangle_3.x = param2.x;
            UnknownVarFromWindowModel_Rectangle_3.y = param2.y;
            UnknownVarFromWindowModel_Rectangle_3.width = param2.width;
            UnknownVarFromWindowModel_Rectangle_3.height = param2.height;
         }
         if(param3.width < param2.width || param3.height < param2.height)
         {
            param3.width = param2.width;
            param3.height = param2.height;
            throw new Error("Maximized rectangle can\'t be smaller than minimized rectangle!");
         }
         if(param1 != null)
         {
            setRectangle(param1.x,param1.y,param1.width,param1.height);
         }
      }
      
      public function buildFromXML(param1:XML, param2:Map = null) : Boolean
      {
         return _context.getWindowParser().parseAndConstruct(param1,this,param2) != null;
      }
      
      public function fetchDrawBuffer() : IBitmapDrawable
      {
         return !testParamFlag(16) ? getGraphicContext(true).fetchDrawBuffer() : (_parent != null ? _parent.fetchDrawBuffer() : null);
      }
      
      public function getDrawRegion(param1:Rectangle) : void
      {
         if(!testParamFlag(16))
         {
            param1.x = 0;
            param1.y = 0;
            param1.width = _width;
            param1.height = _height;
         }
         else if(_parent != null)
         {
            _parent.getDrawRegion(param1);
            param1.x += _x;
            param1.y += _y;
            param1.width = _width;
            param1.height = _height;
         }
         else
         {
            param1.x = 0;
            param1.y = 0;
            param1.width = 0;
            param1.height = 0;
         }
      }
      
      public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc5_:IMouseListenerService = null;
         var _loc6_:IWindowModel = null;
         var _loc4_:WindowEvent = null;
         var _loc3_:* = 0;
         if(!testParamFlag(9))
         {
            procedure(param2,this);
            if(_disposed)
            {
               return true;
            }
            if(!param2.isWindowOperationPrevented())
            {
               if(hasEventListener(param2.type))
               {
                  UnknownVarFromWindowController_WindowEventDispatcher_1.dispatchEvent(param2);
                  if(_disposed)
                  {
                     return true;
                  }
               }
            }
            if(param2.cancelable)
            {
               if(param2.isWindowOperationPrevented())
               {
                  return true;
               }
            }
         }
         if(param2 is WindowMouseEvent)
         {
            switch(param2.type)
            {
               case "WME_DOWN":
                  if(activate())
                  {
                     if(param2.cancelable)
                     {
                        param2.preventDefault();
                     }
                  }
                  if(disposed)
                  {
                     return true;
                  }
                  setStateFlag(16,true);
                  _loc5_ = _context.getWindowServices().getMouseListenerService();
                  _loc5_.begin(this);
                  _loc5_.eventTypes.push("WME_UP");
                  _loc5_.areaLimit = 3;
                  if(testParamFlag(257))
                  {
                     _loc6_ = this;
                     while(_loc6_ != null)
                     {
                        if(_loc6_.testParamFlag(32768))
                        {
                           _context.getWindowServices().getMouseDraggingService().begin(_loc6_);
                           break;
                        }
                        _loc6_ = _loc6_.parent;
                     }
                  }
                  if((_param & 0x3000) > 0)
                  {
                     _loc6_ = this;
                     while(_loc6_ != null)
                     {
                        if(_loc6_.testParamFlag(65536))
                        {
                           _context.getWindowServices().getMouseScalingService().begin(_loc6_,_param & 0x3000);
                           break;
                        }
                        _loc6_ = _loc6_.parent;
                     }
                  }
                  break;
               case "WME_UP":
                  if(testStateFlag(16))
                  {
                     setStateFlag(16,false);
                  }
                  _context.getWindowServices().getMouseListenerService().end(this);
                  if(testParamFlag(32768))
                  {
                     _context.getWindowServices().getMouseDraggingService().end(this);
                  }
                  if(testParamFlag(65536))
                  {
                     _context.getWindowServices().getMouseScalingService().end(this);
                  }
                  break;
               case "WME_OUT":
                  if(testStateFlag(4))
                  {
                     setStateFlag(4,false);
                  }
                  if(testStateFlag(16))
                  {
                     setStateFlag(16,false);
                  }
                  break;
               case "WME_OVER":
                  if(!testStateFlag(4))
                  {
                     setStateFlag(4,true);
                  }
                  break;
               default:
                  break;
               case "WME_WHEEL":
               case "WME_WHEEL_HORIZONTAL":
                  return false;
            }
         }
         else if(param2 is WindowEvent)
         {
            switch(param2.type)
            {
               case "WE_RESIZED":
                  if(param1 == this)
                  {
                     UnknownConstFromWindowController_Rectangle_1.x = _x < UnknownVarFromWindowModel_Rectangle_2.x ? _x : UnknownVarFromWindowModel_Rectangle_2.x;
                     UnknownConstFromWindowController_Rectangle_1.y = _y < UnknownVarFromWindowModel_Rectangle_2.y ? _y : UnknownVarFromWindowModel_Rectangle_2.y;
                     UnknownConstFromWindowController_Rectangle_1.right = _x + _width > UnknownVarFromWindowModel_Rectangle_2.right ? _x + _width : UnknownVarFromWindowModel_Rectangle_2.right;
                     UnknownConstFromWindowController_Rectangle_1.bottom = _y + _height > UnknownVarFromWindowModel_Rectangle_2.bottom ? _y + _height : UnknownVarFromWindowModel_Rectangle_2.bottom;
                     UnknownConstFromWindowController_Rectangle_1.offset(-_x,-_y);
                     _context.invalidate(this,UnknownConstFromWindowController_Rectangle_1,2);
                     _loc4_ = WindowEvent.allocate("WE_PARENT_RESIZED",this,null);
                     notifyChildren(_loc4_);
                     _loc4_.recycle();
                     if(testParamFlag(192,192))
                     {
                        updateScaleRelativeToParent();
                     }
                     else if(testParamFlag(3072,3072))
                     {
                        updateScaleRelativeToParent();
                     }
                     if(_parent != null)
                     {
                        _loc3_ = _param;
                        _param &= -3265;
                        if(testParamFlag(4194304))
                        {
                           _parent.width += _width - UnknownVarFromWindowModel_Rectangle_2.width;
                        }
                        if(testParamFlag(8388608))
                        {
                           _parent.height += _height - UnknownVarFromWindowModel_Rectangle_2.height;
                        }
                        _param = _loc3_;
                        _loc4_ = WindowEvent.allocate("WE_CHILD_RESIZED",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
                  break;
               case "WE_RELOCATED":
                  if(param1 == this)
                  {
                     UnknownConstFromWindowController_Rectangle_1.x = _x < UnknownVarFromWindowModel_Rectangle_2.x ? _x : UnknownVarFromWindowModel_Rectangle_2.x;
                     UnknownConstFromWindowController_Rectangle_1.y = _y < UnknownVarFromWindowModel_Rectangle_2.y ? _y : UnknownVarFromWindowModel_Rectangle_2.y;
                     UnknownConstFromWindowController_Rectangle_1.right = _x + _width > UnknownVarFromWindowModel_Rectangle_2.right ? _x + _width : UnknownVarFromWindowModel_Rectangle_2.right;
                     UnknownConstFromWindowController_Rectangle_1.bottom = _y + _height > UnknownVarFromWindowModel_Rectangle_2.bottom ? _y + _height : UnknownVarFromWindowModel_Rectangle_2.bottom;
                     UnknownConstFromWindowController_Rectangle_1.offset(-_x,-_y);
                     _context.invalidate(this,UnknownConstFromWindowController_Rectangle_1,4);
                     _loc4_ = WindowEvent.allocate("WE_PARENT_RELOCATED",this,null);
                     notifyChildren(_loc4_);
                     _loc4_.recycle();
                     if(_parent != null)
                     {
                        _loc4_ = WindowEvent.allocate("WE_CHILD_RELOCATED",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
                  break;
               case "WE_ACTIVATED":
                  if(param1 == this)
                  {
                     _loc4_ = WindowEvent.allocate("WE_PARENT_ACTIVATED",this,null);
                     notifyChildren(_loc4_);
                     _loc4_.recycle();
                     if(_parent != null)
                     {
                        _loc4_ = WindowEvent.allocate("WE_CHILD_ACTIVATED",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
                  break;
               case "WE_PARENT_ADDED":
                  if(testParamFlag(192,192))
                  {
                     updateScaleRelativeToParent();
                  }
                  else if(testParamFlag(3072,3072))
                  {
                     updateScaleRelativeToParent();
                  }
                  _context.invalidate(this,null,1);
                  if(UnknownVarFromWindowController_Boolean_3)
                  {
                     invalidateOwnGraphicContextDescendants();
                  }
                  UnknownVarFromWindowController_Boolean_3 = true;
                  break;
               case "WE_PARENT_RESIZED":
                  _parent.getRegionProperties(null,UnknownVarFromWindowController_Rectangle_1);
                  updateScaleRelativeToParent();
                  break;
               case "WE_CHILD_ADDED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  else if(testParamFlag(131072))
                  {
                     expandToAccommodateChild(this,param2.related);
                  }
                  renderDynamicStyle();
                  break;
               case "WE_CHILD_REMOVED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  break;
               case "WE_CHILD_ACTIVATED":
                  activate();
                  break;
               case "WE_CHILD_RESIZED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  else if(testParamFlag(131072))
                  {
                     expandToAccommodateChild(this,param2.related);
                  }
                  break;
               case "WE_CHILD_RELOCATED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  else if(testParamFlag(131072))
                  {
                     expandToAccommodateChild(this,param2.related);
                  }
                  break;
               case "WE_CHILD_VISIBILITY":
                  if(param1 == this)
                  {
                     if(_parent != null)
                     {
                        _loc4_ = WindowEvent.allocate("WE_CHILD_VISIBILITY",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
            }
         }
         return true;
      }
      
      private function renderDynamicStyle() : void
      {
         var _loc1_:* = 0;
         if(_dynamicStyle == "")
         {
            return;
         }
         if(!UnknownVarFromWindowController_DynamicStyle_1 || UnknownVarFromWindowController_DynamicStyle_1.name != _dynamicStyle)
         {
            UnknownVarFromWindowController_DynamicStyle_1 = DynamicStyleManager.getStyle(_dynamicStyle);
         }
         if(getStateFlag(32))
         {
            _loc1_ = 32;
         }
         else if(getStateFlag(16))
         {
            _loc1_ = 16;
         }
         else if(getStateFlag(4))
         {
            _loc1_ = 4;
         }
         else
         {
            _loc1_ = 0;
         }
         applyDynamicStyleByState(this,UnknownVarFromWindowController_DynamicStyle_1,_loc1_);
         if(_children)
         {
            recursivelyUpdateChildrensDynamicStyles(_children,_loc1_);
         }
      }
      
      private function applyDynamicStyleByState(param1:WindowController, param2:DynamicStyle, param3:uint) : void
      {
         var _loc5_:Array = null;
         var _loc4_:Object = param2.getStyleByWindowState(param3);
         param1.offsetX = !!_loc4_.offsetX ? _loc4_.offsetX : 0;
         param1.offsetY = !!_loc4_.offsetY ? _loc4_.offsetY : 0;
         if(param1.hasGraphicsContext())
         {
            param1.UnknownVarFromWindowController_IGraphicContext_1.getDisplayObject().transform.colorTransform = param2.getColorTransform(param3);
         }
         else
         {
            param1._dynamicStyleColor = param2.getColorTransform(param3);
            param1.invalidate();
         }
         if(_loc4_.etchingPoint)
         {
            _loc5_ = [_loc4_.etchingColor,_loc4_.etchingPoint[0],_loc4_.etchingPoint[1]];
            param1.etching = _loc5_;
            param1.invalidate();
         }
         else
         {
            param1.etching = [0,0,1];
            param1.invalidate();
         }
      }
      
      private function recursivelyUpdateChildrensDynamicStyles(param1:Vector.<IWindowModel>, param2:uint) : void
      {
         for each(var _loc3_ in param1)
         {
            if(UnknownVarFromWindowController_DynamicStyle_1.getChildStyle(_loc3_))
            {
               applyDynamicStyleByState(_loc3_,UnknownVarFromWindowController_DynamicStyle_1.getChildStyle(_loc3_),param2);
            }
            if(_loc3_._children)
            {
               recursivelyUpdateChildrensDynamicStyles(_loc3_._children,param2);
            }
         }
      }
      
      private function invalidateOwnGraphicContextDescendants() : void
      {
         if(_children == null)
         {
            return;
         }
         for each(var _loc1_ in _children)
         {
            if(!_loc1_.testParamFlag(16))
            {
               _loc1_.invalidate();
            }
            _loc1_.invalidateOwnGraphicContextDescendants();
         }
      }
      
      protected function notifyEventListeners(param1:WindowEvent) : void
      {
         procedure(param1,this);
         if(!param1.isWindowOperationPrevented())
         {
            if(hasEventListener(param1.type))
            {
               UnknownVarFromWindowController_WindowEventDispatcher_1.dispatchEvent(param1);
            }
         }
      }
      
      private function nullEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
      }
      
      private function notifyChildren(param1:WindowEvent) : void
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               _loc2_.update(this,param1);
            }
         }
      }
      
      public function convertPointFromGlobalToLocalSpace(param1:Point) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         if(_parent == null)
         {
            param1.x = _x;
            param1.y = _y;
         }
         else
         {
            _parent.getGlobalPosition(param1);
            param1.x += _x;
            param1.y += _y;
         }
         param1.x = _loc2_ - param1.x;
         param1.y = _loc3_ - param1.y;
      }
      
      public function convertPointFromLocalToGlobalSpace(param1:Point) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         if(_parent == null)
         {
            param1.x = _x;
            param1.y = _y;
         }
         else
         {
            _parent.getGlobalPosition(param1);
            param1.x += _x;
            param1.y += _y;
         }
         param1.x += _loc2_;
         param1.y += _loc3_;
      }
      
      public function getRelativeMousePosition(param1:Point) : void
      {
         getGlobalPosition(param1);
         param1.x = _context.getDesktopWindow().mouseX - param1.x;
         param1.y = _context.getDesktopWindow().mouseY - param1.y;
      }
      
      public function getAbsoluteMousePosition(param1:Point) : void
      {
         param1.x = _context.getDesktopWindow().mouseX;
         param1.y = _context.getDesktopWindow().mouseY;
      }
      
      public function getLocalPosition(param1:Point) : void
      {
         param1.x = _x;
         param1.y = _y;
      }
      
      public function getLocalRectangle(param1:Rectangle) : void
      {
         param1.x = _x;
         param1.y = _y;
         param1.width = _width;
         param1.height = _height;
      }
      
      public function hitTestLocalPoint(param1:Point) : Boolean
      {
         return param1.x >= _x && param1.x < _x + _width && param1.y >= _y && param1.y < _y + _height;
      }
      
      public function hitTestLocalRectangle(param1:Rectangle) : Boolean
      {
         return rectangle.intersects(param1);
      }
      
      public function validateLocalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         return testLocalPointHitAgainstAlpha(param1,param2,_mouseThreshold);
      }
      
      public function get ignoreMouseEvents() : Boolean
      {
         return _ignoreMouseEvents;
      }
      
      public function getGlobalPosition(param1:Point) : void
      {
         if(_parent != null)
         {
            _parent.getGlobalPosition(param1);
            param1.x += _x;
            param1.y += _y;
         }
         else
         {
            param1.x = _x;
            param1.y = _y;
         }
      }
      
      public function setGlobalPosition(param1:Point) : void
      {
         var _loc2_:Point = new Point();
         if(_parent != null)
         {
            _parent.getGlobalPosition(_loc2_);
            _loc2_.x += _x;
            _loc2_.y += _y;
         }
         else
         {
            _loc2_.x = _x;
            _loc2_.y = _y;
         }
         x += param1.x - _loc2_.x;
         y += param1.y - _loc2_.y;
      }
      
      public function getGlobalRectangle(param1:Rectangle) : void
      {
         if(_parent != null)
         {
            _parent.getGlobalRectangle(param1);
            param1.x += _x;
            param1.y += _y;
         }
         else
         {
            param1.x = _x;
            param1.y = _y;
         }
         param1.width = _width;
         param1.height = _height;
      }
      
      public function setGlobalRectangle(param1:Rectangle) : void
      {
         var _loc2_:Point = new Point();
         if(_parent != null)
         {
            _parent.getGlobalPosition(_loc2_);
            _loc2_.x += _x;
            _loc2_.y += _y;
         }
         else
         {
            _loc2_.x = _x;
            _loc2_.y = _y;
         }
         setRectangle(x + (param1.x - _loc2_.x),y + (param1.y - _loc2_.y),param1.width,param1.height);
      }
      
      public function hitTestGlobalPoint(param1:Point) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle();
         getGlobalRectangle(_loc2_);
         return _loc2_.containsPoint(param1);
      }
      
      public function hitTestGlobalRectangle(param1:Rectangle) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle();
         getGlobalRectangle(_loc2_);
         return _loc2_.intersects(param1);
      }
      
      public function validateGlobalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         var _loc3_:Point = new Point();
         getGlobalPosition(_loc3_);
         _loc3_.x = param1.x - _loc3_.x;
         _loc3_.y = param1.y - _loc3_.y;
         return testLocalPointHitAgainstAlpha(_loc3_,param2,_mouseThreshold);
      }
      
      public function getMouseRegion(param1:Rectangle) : void
      {
         var _loc2_:Rectangle = null;
         getGlobalRectangle(param1);
         if(param1.width < 0)
         {
            param1.width = 0;
         }
         if(param1.height < 0)
         {
            param1.height = 0;
         }
         if(testParamFlag(16))
         {
            _loc2_ = new Rectangle();
            IWindowModel(_parent).getMouseRegion(_loc2_);
            if(param1.left < _loc2_.left)
            {
               param1.left = _loc2_.left;
            }
            if(param1.top < _loc2_.top)
            {
               param1.top = _loc2_.top;
            }
            if(param1.right > _loc2_.right)
            {
               param1.right = _loc2_.right;
            }
            if(param1.bottom > _loc2_.bottom)
            {
               param1.bottom = _loc2_.bottom;
            }
         }
      }
      
      protected function testLocalPointHitAgainstAlpha(param1:Point, param2:BitmapData, param3:uint) : Boolean
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Boolean = false;
         if(_width < 1 || _height < 1)
         {
            return false;
         }
         if(UnknownVarFromWindowController_Boolean_1 && _mouseThreshold > 0)
         {
            if(!testParamFlag(16))
            {
               if(param1.x <= _width && param1.y <= _height)
               {
                  _loc4_ = getGraphicContext(true).fetchDrawBuffer() as BitmapData;
                  if(_loc4_ != null)
                  {
                     _loc5_ = _loc4_.hitTest(_POINT_ZERO,param3,param1);
                  }
               }
            }
            else
            {
               _loc5_ = param2 != null ? param2.hitTest(_POINT_ZERO,param3,param1) : false;
            }
            return _loc5_;
         }
         return isInWindowBounds(param1);
      }
      
      public function isInWindowBounds(param1:Point) : Boolean
      {
         return param1.x >= 0 && param1.x < _width && param1.y >= 0 && param1.y < _height;
      }
      
      public function isCapableOfUsingSharedGraphicContext() : Boolean
      {
         return true;
      }
      
      public function resolveVerticalScale() : Number
      {
         return _height / UnknownVarFromWindowModel_Rectangle_1.height;
      }
      
      public function resolveHorizontalScale() : Number
      {
         return _width / UnknownVarFromWindowModel_Rectangle_1.width;
      }
      
      public function offset(param1:Number, param2:Number) : void
      {
         setRectangle(_x + param1,_y + param2,_width,_height);
      }
      
      public function scale(param1:Number, param2:Number) : void
      {
         setRectangle(_x,_y,_width + param1,_height + param2);
      }
      
      public function scaleToAccommodateChildren() : void
      {
         var _loc9_:* = null;
         var _loc8_:Array = null;
         var _loc6_:* = 0;
         if(!_children)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Boolean = false;
         var _loc4_:uint = uint(param & (131072 | 147456));
         for each(_loc9_ in _children)
         {
            if(_loc9_.visible && _loc9_.x < _loc2_)
            {
               _loc7_ -= _loc9_.x - _loc2_;
               _loc2_ = _loc9_.x;
               _loc5_ = true;
            }
            if(_loc9_.visible && _loc9_.x + _loc9_.width > _loc7_)
            {
               _loc7_ = _loc9_.x + _loc9_.width;
               _loc5_ = true;
            }
            if(_loc9_.visible && _loc9_.y < _loc1_)
            {
               _loc3_ -= _loc9_.y - _loc1_;
               _loc1_ = _loc9_.y;
               _loc5_ = true;
            }
            if(_loc9_.visible && _loc9_.y + _loc9_.height > _loc3_)
            {
               _loc3_ = _loc9_.y + _loc9_.height;
               _loc5_ = true;
            }
         }
         if(_loc5_)
         {
            _loc8_ = [];
            for each(_loc9_ in _children)
            {
               _loc6_ = uint(_loc9_.param & (0xC0 | 0x0C00));
               _loc9_.setParamFlag(_loc6_,false);
               _loc8_.push(_loc6_);
            }
            if(_loc4_)
            {
               setParamFlag(_loc4_,false);
            }
            setRectangle(_x + _loc2_,_y + _loc1_,_loc7_,_loc3_);
            for each(_loc9_ in _children)
            {
               _loc9_.offset(-_loc2_,-_loc1_);
               _loc9_.setParamFlag(_loc8_.shift(),true);
            }
            if(_loc4_)
            {
               setParamFlag(_loc4_,true);
            }
         }
      }
      
      public function getStateFlag(param1:uint) : Boolean
      {
         return (_state & param1) != 0;
      }
      
      public function setStateFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:uint = _state;
         _state = param2 ? (_state = _state | param1) : (uint(_state = _state & ~param1));
         if(_state != _loc3_)
         {
            renderDynamicStyle();
            _context.invalidate(this,null,8);
         }
      }
      
      public function getStyleFlag(param1:uint) : Boolean
      {
         return (_style & param1) != 0;
      }
      
      public function setStyleFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:Array = null;
         var _loc4_:WindowController = null;
         var _loc6_:* = 0;
         var _loc5_:uint = _style;
         _style = param2 ? (_style = _style | param1) : (uint(_style = _style & ~param1));
         if(_style != _loc5_)
         {
            _loc3_ = [];
            groupChildrenWithTag("_INTERNAL",_loc3_);
            _loc6_ = _loc3_.length;
            while(--_loc6_ > -1)
            {
               _loc4_ = _loc3_[_loc6_] as WindowController;
               if(_loc4_.tags.indexOf("_IGNORE_INHERITED_STYLE") == -1)
               {
                  _loc4_.style = _style;
               }
            }
            _context.invalidate(this,null,1);
         }
      }
      
      public function getParamFlag(param1:uint) : Boolean
      {
         return (_param & param1) != 0;
      }
      
      public function setParamFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:uint = _param;
         _param = param2 ? (_param = _param | param1) : (uint(_param = _param & ~param1));
         if(_param != _loc3_)
         {
            if(!(_param & 0x10))
            {
               if(!UnknownVarFromWindowController_IGraphicContext_1)
               {
                  setupGraphicsContext();
                  _context.invalidate(this,null,1);
               }
            }
            else if(_param & 0x10)
            {
               if(UnknownVarFromWindowController_IGraphicContext_1)
               {
                  _context.invalidate(this,null,1);
               }
            }
         }
      }
      
      protected function updateScaleRelativeToParent() : void
      {
         var _loc9_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:int = 0;
         if(_parent == null)
         {
            return;
         }
         var _loc1_:* = !testParamFlag(0,192);
         var _loc8_:* = !testParamFlag(0,3072);
         var _loc4_:int = _x;
         var _loc7_:int = _y;
         var _loc3_:int = _width;
         var _loc5_:int = _height;
         if(_loc1_ || _loc8_)
         {
            if(_loc1_)
            {
               _loc6_ = _parent.width - UnknownVarFromWindowController_Rectangle_1.width;
               _loc9_ = uint(_param & 0xC0);
               if(_loc9_ == 128)
               {
                  _loc3_ += _loc6_;
               }
               else if(_loc9_ == 64)
               {
                  _loc4_ += _loc6_;
               }
               else if(_loc9_ == 192)
               {
                  if(_parent.width < _loc3_ && getParamFlag(16))
                  {
                     _loc4_ = 0;
                  }
                  else
                  {
                     _loc4_ = Math.floor(_parent.width / 2) - Math.floor(_loc3_ / 2);
                  }
               }
            }
            if(_loc8_)
            {
               _loc6_ = _parent.height - UnknownVarFromWindowController_Rectangle_1.height;
               _loc9_ = uint(_param & 0x0C00);
               if(_loc9_ == 2048)
               {
                  _loc5_ += _loc6_;
               }
               else if(_loc9_ == 1024)
               {
                  _loc7_ += _loc6_;
               }
               else if(_loc9_ == 3072)
               {
                  if(_parent.height < _loc5_ && getParamFlag(16))
                  {
                     _loc7_ = 0;
                  }
                  else
                  {
                     _loc7_ = Math.floor(_parent.height / 2) - Math.floor(_loc5_ / 2);
                  }
               }
            }
            _loc2_ = _param;
            _param &= -12586177;
            setRectangle(_loc4_,_loc7_,_loc3_,_loc5_);
            _param = _loc2_;
         }
         else if(testParamFlag(32))
         {
            if(_parent != null)
            {
               _loc4_ = int(_loc4_ < 0 ? 0 : _loc4_);
               _loc7_ = int(_loc7_ < 0 ? 0 : _loc7_);
               _loc4_ -= _loc4_ + _loc3_ > _parent.width ? _loc4_ + _loc3_ - _parent.width : 0;
               _loc7_ -= _loc7_ + _loc5_ > _parent.height ? _loc7_ + _loc5_ - _parent.height : 0;
               _loc3_ -= _loc4_ + _loc3_ > _parent.width ? _loc4_ + _loc3_ - _parent.width : 0;
               _loc5_ -= _loc7_ + _loc5_ > _parent.height ? _loc7_ + _loc5_ - _parent.height : 0;
               if(_loc4_ != _x || _loc7_ != _y || _loc3_ != _width || _loc5_ != _height)
               {
                  _loc2_ = _param;
                  _param &= -12586177;
                  setRectangle(_loc4_,_loc7_,_loc3_,_loc5_);
                  _param = _loc2_;
               }
            }
         }
      }
      
      protected function isChildWindow() : Boolean
      {
         return _parent != context.getDesktopWindow();
      }
      
      public function destroy() : Boolean
      {
         if(_state == 1073741824)
         {
            return true;
         }
         _state = 1073741824;
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_DESTROY",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         _loc1_ = WindowEvent.allocate("WE_DESTROYED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         dispose();
         return true;
      }
      
      public function minimize() : Boolean
      {
         if(_state & 0x40)
         {
            return false;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_MINIMIZE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,true);
         _loc1_ = WindowEvent.allocate("WE_MINIMIZED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function maximize() : Boolean
      {
         if(_state & 0x40)
         {
            return false;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_MAXIMIZE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,true);
         _loc1_ = WindowEvent.allocate("WE_MAXIMIZED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function restore() : Boolean
      {
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_RESTORE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,false);
         _loc1_ = WindowEvent.allocate("WE_RESTORED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function activate() : Boolean
      {
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_ACTIVATE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(1,true);
         _loc1_ = WindowEvent.allocate("WE_ACTIVATED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function deactivate() : Boolean
      {
         if(!getStateFlag(1))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_DEACTIVATE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(1,false);
         _loc1_ = WindowEvent.allocate("WE_DEACTIVATED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function lock() : Boolean
      {
         if(getStateFlag(64))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_LOCK",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,true);
         _loc1_ = WindowEvent.allocate("WE_LOCKED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function unlock() : Boolean
      {
         if(!getStateFlag(64))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_UNLOCK",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,false);
         _loc1_ = WindowEvent.allocate("WE_UNLOCKED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function enable() : Boolean
      {
         if(!getStateFlag(32))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_ENABLE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(32,false);
         _loc1_ = WindowEvent.allocate("WE_ENABLED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function disable() : Boolean
      {
         if(getStateFlag(32))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_DISABLE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(32,true);
         _loc1_ = WindowEvent.allocate("WE_DISABLED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function focus() : Boolean
      {
         if(getStateFlag(2))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_FOCUS",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(2,true);
         _loc1_ = WindowEvent.allocate("WE_FOCUSED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function unfocus() : Boolean
      {
         if(!getStateFlag(2))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_UNFOCUS",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(2,false);
         _loc1_ = WindowEvent.allocate("WE_UNFOCUSED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function getChildUnderPoint(param1:Point) : IWindowModel
      {
         var _loc3_:Rectangle = null;
         var _loc5_:IWindowModel = null;
         var _loc4_:Boolean = false;
         if(_visible)
         {
            _loc3_ = new Rectangle();
            getMouseRegion(_loc3_);
            _loc4_ = _loc3_.containsPoint(param1);
            var _loc2_:uint = uint(numChildren);
            if(_loc4_)
            {
               while(_loc2_ > 0)
               {
                  _loc5_ = WindowController(_children[_loc2_ - 1]).getChildUnderPoint(param1);
                  if(_loc5_ != null)
                  {
                     return _loc5_;
                  }
                  _loc2_--;
               }
            }
            if(validateGlobalPointIntersection(param1,null))
            {
               return this;
            }
         }
         return null;
      }
      
      public function groupChildrenUnderPoint(param1:Point, param2:Array) : void
      {
         var _loc3_:* = null;
         if(_visible)
         {
            if(param1.x >= _x && param1.x < _x + _width && param1.y >= _y && param1.y < _y + _height)
            {
               param2.push(this);
               if(_children)
               {
                  param1.offset(-_x,-_y);
                  for each(_loc3_ in _children)
                  {
                     _loc3_.groupChildrenUnderPoint(param1,param2);
                  }
                  param1.offset(_x,_y);
               }
            }
            else if(!_clipping)
            {
               if(_children)
               {
                  param1.offset(-_x,-_y);
                  for each(_loc3_ in _children)
                  {
                     _loc3_.groupChildrenUnderPoint(param1,param2);
                  }
                  param1.offset(_x,_y);
               }
            }
         }
      }
      
      public function groupParameterFilteredChildrenUnderPoint(param1:Point, param2:Array, param3:uint = 0) : void
      {
         var _loc4_:* = null;
         if(_visible)
         {
            if(param1.x >= _x && param1.x < _x + _width && param1.y >= _y && param1.y < _y + _height)
            {
               if((_param & param3) == param3)
               {
                  param2.push(this);
               }
               if(_children)
               {
                  param1.offset(-_x,-_y);
                  for each(_loc4_ in _children)
                  {
                     _loc4_.groupParameterFilteredChildrenUnderPoint(param1,param2,param3);
                  }
                  param1.offset(_x,_y);
               }
            }
            else if(!_clipping)
            {
               if(_children)
               {
                  param1.offset(-_x,-_y);
                  for each(_loc4_ in _children)
                  {
                     _loc4_.groupParameterFilteredChildrenUnderPoint(param1,param2,param3);
                  }
                  param1.offset(_x,_y);
               }
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:int = 0) : void
      {
         if(!_disposed)
         {
            if(!UnknownVarFromWindowController_WindowEventDispatcher_1)
            {
               UnknownVarFromWindowController_WindowEventDispatcher_1 = new WindowEventDispatcher(this);
            }
            UnknownVarFromWindowController_WindowEventDispatcher_1.addEventListener(param1,param2,param3);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _disposed || !UnknownVarFromWindowController_WindowEventDispatcher_1 ? false : UnknownVarFromWindowController_WindowEventDispatcher_1.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         if(!_disposed && UnknownVarFromWindowController_WindowEventDispatcher_1)
         {
            UnknownVarFromWindowController_WindowEventDispatcher_1.removeEventListener(param1,param2);
         }
      }
      
      public function get children() : Vector.<IWindowModel>
      {
         return _children;
      }
      
      public function get numChildren() : int
      {
         return !!_children ? _children.length : 0;
      }
      
      public function populate(param1:Array) : void
      {
         var _loc2_:Boolean = false;
         if(!_children)
         {
            _children = new Vector.<IWindowModel>();
         }
         for each(var _loc3_ in param1)
         {
            if(_loc3_ && _loc3_.parent != this)
            {
               _children.push(_loc3_);
               _loc3_.parent = this;
               _loc2_ ||= _loc3_.hasGraphicsContext();
            }
         }
         if(UnknownVarFromWindowController_Boolean_2 || _loc2_)
         {
            setupGraphicsContext();
         }
      }
      
      public function addChild(param1:IWindowModel) : IWindowModel
      {
         var _loc2_:WindowController = WindowController(param1);
         if(_loc2_.parent != null)
         {
            WindowController(_loc2_.parent).removeChild(_loc2_);
         }
         if(!_children)
         {
            _children = new Vector.<IWindowModel>();
         }
         _children.push(_loc2_);
         _loc2_.parent = this;
         if(UnknownVarFromWindowController_Boolean_2 || _loc2_.hasGraphicsContext())
         {
            setupGraphicsContext();
            if(_loc2_.getGraphicContext(true).parent != UnknownVarFromWindowController_IGraphicContext_1)
            {
               UnknownVarFromWindowController_IGraphicContext_1.addChildContext(_loc2_.getGraphicContext(true));
            }
         }
         var _loc3_:WindowEvent = WindowEvent.allocate("WE_CHILD_ADDED",this,param1);
         update(this,_loc3_);
         _loc3_.recycle();
         return param1;
      }
      
      public function addChildAt(param1:IWindowModel, param2:int) : IWindowModel
      {
         var _loc3_:WindowController = WindowController(param1);
         if(_loc3_.parent != null)
         {
            WindowController(_loc3_.parent).removeChild(_loc3_);
         }
         if(!_children)
         {
            _children = new Vector.<IWindowModel>();
         }
         _children.splice(param2,0,_loc3_);
         _loc3_.parent = this;
         if(UnknownVarFromWindowController_Boolean_2 || _loc3_.hasGraphicsContext())
         {
            setupGraphicsContext();
            if(_loc3_.getGraphicContext(true).parent != UnknownVarFromWindowController_IGraphicContext_1)
            {
               UnknownVarFromWindowController_IGraphicContext_1.addChildContextAt(_loc3_.getGraphicContext(true),param2);
            }
         }
         var _loc4_:WindowEvent = WindowEvent.allocate("WE_CHILD_ADDED",this,param1);
         update(this,_loc4_);
         _loc4_.recycle();
         return param1;
      }
      
      public function getChildAt(param1:int) : IWindowModel
      {
         return !!_children ? (param1 < _children.length && param1 > -1 ? _children[param1] : null) : null;
      }
      
      public function getChildByID(param1:int) : IWindowModel
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getChildByName(param1:String) : IWindowModel
      {
         if(_lookupCache != null && param1 in _lookupCache)
         {
            return _lookupCache[param1];
         }
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.name == param1)
               {
                  if(_lookupCache != null)
                  {
                     _lookupCache[param1] = _loc2_;
                  }
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function enableLookupCache() : void
      {
         if(_lookupCache == null)
         {
            _lookupCache = new Dictionary();
         }
      }
      
      public function findChildByName(param1:String) : IWindowModel
      {
         var _loc2_:WindowController = null;
         if(_lookupCache != null && param1 in _lookupCache)
         {
            return _lookupCache[param1];
         }
         if(_children)
         {
            for each(_loc2_ in _children)
            {
               if(_loc2_.name == param1)
               {
                  if(_lookupCache != null)
                  {
                     _lookupCache[param1] = _loc2_;
                  }
                  return _loc2_;
               }
            }
            for each(_loc2_ in _children)
            {
               _loc2_ = _loc2_.findChildByName(param1) as WindowController;
               if(_loc2_)
               {
                  if(_lookupCache != null)
                  {
                     _lookupCache[param1] = _loc2_;
                  }
                  return _loc2_ as IWindowModel;
               }
            }
         }
         return null;
      }
      
      public function getChildByTag(param1:String) : IWindowModel
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.tags.indexOf(param1) > -1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function findChildByTag(param1:String) : IWindowModel
      {
         if(UnknownVarFromWindowModel_Array_1 && UnknownVarFromWindowModel_Array_1.indexOf(param1) > -1)
         {
            return this;
         }
         var _loc2_:WindowController = WindowController(getChildByTag(param1));
         if(_loc2_ == null && _children)
         {
            for each(_loc2_ in _children)
            {
               _loc2_ = _loc2_.findChildByTag(param1) as WindowController;
               if(_loc2_ != null)
               {
                  break;
               }
            }
         }
         return _loc2_ as IWindowModel;
      }
      
      public function windowIsChild(param1:IWindowModel) : Boolean
      {
         if(this == param1)
         {
            return true;
         }
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.windowIsChild(param1))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getChildIndex(param1:IWindowModel) : int
      {
         return !!_children ? _children.indexOf(param1) : -1;
      }
      
      public function removeChild(param1:IWindowModel) : IWindowModel
      {
         if(!_children)
         {
            return null;
         }
         var _loc3_:int = int(_children.indexOf(param1));
         if(_loc3_ < 0)
         {
            return null;
         }
         _children.splice(_loc3_,1);
         param1.parent = null;
         var _loc2_:IGraphicContextHost = param1 as IGraphicContextHost;
         if(_loc2_ && _loc2_.hasGraphicsContext())
         {
            UnknownVarFromWindowController_IGraphicContext_1.removeChildContext(_loc2_.getGraphicContext(true));
         }
         var _loc4_:WindowEvent = WindowEvent.allocate("WE_CHILD_REMOVED",this,param1);
         update(this,_loc4_);
         _loc4_.recycle();
         return param1;
      }
      
      public function removeChildAt(param1:int) : IWindowModel
      {
         return removeChild(getChildAt(param1));
      }
      
      public function setChildIndex(param1:IWindowModel, param2:int) : void
      {
         var _loc4_:WindowController = null;
         if(!_children)
         {
            return;
         }
         var _loc3_:int = int(_children.indexOf(param1));
         if(_loc3_ > -1 && param2 != _loc3_)
         {
            _children.splice(_loc3_,1);
            _children.splice(param2,0,param1);
            _loc4_ = WindowController(param1);
            if(_loc4_.hasGraphicsContext())
            {
               UnknownVarFromWindowController_IGraphicContext_1.setChildContextIndex(_loc4_.getGraphicContext(true),getChildIndex(_loc4_));
            }
         }
      }
      
      public function swapChildren(param1:IWindowModel, param2:IWindowModel) : void
      {
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = null;
         var _loc4_:* = 0;
         if(!_children)
         {
            return;
         }
         if(param1 != null && param2 != null && param1 != param2)
         {
            _loc3_ = int(_children.indexOf(param1));
            if(_loc3_ < 0)
            {
               return;
            }
            _loc6_ = int(_children.indexOf(param2));
            if(_loc6_ < 0)
            {
               return;
            }
            if(_loc6_ < _loc3_)
            {
               _loc5_ = param1;
               param1 = param2;
               param2 = _loc5_;
               _loc4_ = _loc3_;
               _loc3_ = _loc6_;
               _loc6_ = _loc4_;
            }
            _children.splice(_loc6_,1);
            _children.splice(_loc3_,1);
            _children.splice(_loc3_,0,param2);
            _children.splice(_loc6_,0,param1);
            if(WindowController(param1).hasGraphicsContext() || Boolean(WindowController(param2).hasGraphicsContext()))
            {
               UnknownVarFromWindowController_IGraphicContext_1.swapChildContexts(WindowController(param1).getGraphicContext(true),WindowController(param2).getGraphicContext(true));
            }
         }
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         if(!_children)
         {
            return;
         }
         swapChildren(_children[param1],_children[param2]);
         UnknownVarFromWindowController_IGraphicContext_1.swapChildContextsAt(param1,param2);
      }
      
      public function groupChildrenWithID(param1:uint, param2:Array, param3:int = 0) : uint
      {
         var _loc5_:* = null;
         if(!_children)
         {
            return 0;
         }
         var _loc4_:uint = 0;
         for each(_loc5_ in _children)
         {
            if(_loc5_.id == param1)
            {
               param2.push(_loc5_);
               _loc4_++;
            }
            if(param3 > 0 || param3 < 0)
            {
               param3--;
               _loc4_ += _loc5_.groupChildrenWithID(param1,param2,param3);
            }
         }
         return _loc4_;
      }
      
      public function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         var _loc5_:* = null;
         if(!_children)
         {
            return 0;
         }
         var _loc4_:uint = 0;
         for each(_loc5_ in _children)
         {
            if(_loc5_.tags.indexOf(param1) > -1)
            {
               param2.push(_loc5_);
               _loc4_++;
            }
            if(param3 > 0 || param3 < 0)
            {
               _loc4_ += _loc5_.groupChildrenWithTag(param1,param2,param3 - 1);
            }
         }
         return _loc4_;
      }
      
      public function findParentByName(param1:String) : IWindowModel
      {
         if(_name == param1)
         {
            return this;
         }
         if(_parent != null)
         {
            if(_parent.name == param1)
            {
               return _parent;
            }
            return _parent.findParentByName(param1);
         }
         return null;
      }
      
      protected function requiresOwnGraphicContext() : Boolean
      {
         var _loc1_:* = null;
         if(testParamFlag(16))
         {
            if(_children)
            {
               for each(_loc1_ in _children)
               {
                  if(_loc1_.requiresOwnGraphicContext())
                  {
                     return true;
                  }
               }
            }
            return false;
         }
         return true;
      }
      
      public function createProperty(param1:String, param2:Object) : PropertyStruct
      {
         return UnknownVarFromWindowController_IPropertyMap_1.get(param1).withValue(param2);
      }
      
      public function getDefaultProperty(param1:String) : PropertyStruct
      {
         return UnknownVarFromWindowController_IPropertyMap_1.get(param1);
      }
      
      public function isEnabled() : Boolean
      {
         return !getStateFlag(32);
      }
      
      public function enableChildren(param1:Boolean, param2:Array) : void
      {
         var _loc4_:IWindowModel = null;
         for each(var _loc3_ in param2)
         {
            _loc4_ = this.findChildByName(_loc3_);
            if(_loc4_ != null)
            {
               if(param1)
               {
                  _loc4_.enable();
               }
               else
               {
                  _loc4_.disable();
               }
            }
         }
      }
      
      public function activateChildren(param1:Boolean, param2:Array) : void
      {
         var _loc4_:IWindowModel = null;
         for each(var _loc3_ in param2)
         {
            _loc4_ = this.findChildByName(_loc3_);
            if(_loc4_ != null)
            {
               if(param1)
               {
                  _loc4_.activate();
               }
               else
               {
                  _loc4_.deactivate();
               }
            }
         }
      }
      
      public function setVisibleChildren(param1:Boolean, param2:Array) : void
      {
         var _loc4_:IWindowModel = null;
         for each(var _loc3_ in param2)
         {
            _loc4_ = this.findChildByName(_loc3_);
            if(_loc4_ != null)
            {
               _loc4_.visible = param1;
            }
         }
      }
      
      public function set immediateClickMode(param1:Boolean) : void
      {
         var _loc2_:IGraphicContext = null;
         if(param1 != _immediateClickMode)
         {
            _immediateClickMode = param1;
            _loc2_ = getGraphicContext(false);
            if(_loc2_)
            {
               if(_immediateClickMode)
               {
                  _loc2_.mouse = true;
                  _loc2_.addEventListener("click",immediateClickHandler);
               }
               else
               {
                  _loc2_.mouse = false;
                  _loc2_.removeEventListener("click",immediateClickHandler);
               }
            }
         }
      }
      
      protected function immediateClickHandler(param1:Event) : void
      {
         var _loc5_:IWindowModel = null;
         var _loc2_:MouseEvent = param1 as MouseEvent;
         var _loc6_:Point = new Point(_loc2_.stageX,_loc2_.stageY);
         var _loc3_:Array = [];
         desktop.groupChildrenUnderPoint(_loc6_,_loc3_);
         while(_loc3_.length > 0)
         {
            _loc5_ = _loc3_.pop();
            if(_loc5_ == this)
            {
               break;
            }
            if(_loc5_.getParamFlag(1))
            {
               return;
            }
         }
         getRelativeMousePosition(_loc6_);
         var _loc4_:WindowEvent = WindowMouseEvent.allocate("WME_CLICK",this,null,_loc6_.x,_loc6_.y,_loc2_.stageX,_loc2_.stageY,_loc2_.altKey,_loc2_.ctrlKey,_loc2_.shiftKey,_loc2_.buttonDown,_loc2_.delta);
         if(UnknownVarFromWindowController_WindowEventDispatcher_1)
         {
            UnknownVarFromWindowController_WindowEventDispatcher_1.dispatchEvent(_loc4_);
         }
         if(!_loc4_.isWindowOperationPrevented())
         {
            if(procedure != null)
            {
               procedure(_loc4_,this);
            }
         }
         param1.stopImmediatePropagation();
         _loc4_.recycle();
      }
   }
}

