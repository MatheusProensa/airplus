package com.sulake.core.window
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WindowModel implements IComponentInterfaceQueue
   {
      private static var POINT_ZERO:Point = new Point(0,0);
      
      protected var _offsetX:int;
      
      protected var _offsetY:int;
      
      protected var _x:int;
      
      protected var _y:int;
      
      protected var _width:int;
      
      protected var _height:int;
      
      protected var UnknownVarFromWindowModel_Rectangle_1:Rectangle;
      
      protected var UnknownVarFromWindowModel_Rectangle_2:Rectangle;
      
      protected var UnknownVarFromWindowModel_Rectangle_3:Rectangle;
      
      protected var UnknownVarFromWindowModel_Rectangle_4:Rectangle;
      
      protected var _context:WindowContext;
      
      protected var _background:Boolean = false;
      
      protected var _fillColor:uint = 16777215;
      
      protected var _dynamicStyleColor:ColorTransform;
      
      protected var _alphaColor:uint;
      
      protected var _mouseThreshold:uint = 10;
      
      protected var _ignoreMouseEvents:Boolean = false;
      
      protected var _clipping:Boolean = true;
      
      protected var _visible:Boolean = true;
      
      protected var _blend:Number = 1;
      
      protected var _param:uint;
      
      protected var _state:uint;
      
      protected var _style:uint;
      
      protected var _type:uint;
      
      protected var _caption:String = "";
      
      protected var _name:String;
      
      protected var _id:uint;
      
      protected var UnknownVarFromWindowModel_Array_1:Array;
      
      protected var _disposed:Boolean = false;
      
      protected var _dynamicStyle:String = "";
      
      public function WindowModel(param1:uint, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:Array = null, param9:String = "")
      {
         super();
         _id = param1;
         _name = param2;
         _type = param3;
         _param = param5;
         _state = 0;
         _style = param4;
         UnknownVarFromWindowModel_Array_1 = param8;
         _context = param6;
         _dynamicStyle = param9;
         _x = param7.x;
         _y = param7.y;
         _width = param7.width;
         _height = param7.height;
         UnknownVarFromWindowModel_Rectangle_1 = param7.clone();
         UnknownVarFromWindowModel_Rectangle_2 = param7.clone();
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get position() : Point
      {
         return new Point(_x,_y);
      }
      
      public function get rectangle() : Rectangle
      {
         return new Rectangle(_x,_y,_width,_height);
      }
      
      public function get context() : IWindowContext_3
      {
         return _context;
      }
      
      public function get mouseThreshold() : uint
      {
         return _mouseThreshold;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get background() : Boolean
      {
         return _background;
      }
      
      public function get clipping() : Boolean
      {
         return _clipping;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function get color() : uint
      {
         return _fillColor;
      }
      
      public function get alpha() : uint
      {
         return _alphaColor >>> 24;
      }
      
      public function get blend() : Number
      {
         return _blend;
      }
      
      public function get param() : uint
      {
         return _param;
      }
      
      public function get state() : uint
      {
         return _state;
      }
      
      public function get style() : uint
      {
         return _style;
      }
      
      public function get type() : uint
      {
         return _type;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get tags() : Array
      {
         return !!UnknownVarFromWindowModel_Array_1 ? UnknownVarFromWindowModel_Array_1 : (UnknownVarFromWindowModel_Array_1 = []);
      }
      
      public function get left() : int
      {
         return _x;
      }
      
      public function get top() : int
      {
         return _y;
      }
      
      public function get right() : int
      {
         return _x + _width;
      }
      
      public function get bottom() : int
      {
         return _y + _height;
      }
      
      public function get renderingX() : int
      {
         return _offsetX + _x;
      }
      
      public function get renderingY() : int
      {
         return _offsetY + _y;
      }
      
      public function get renderingWidth() : int
      {
         return _width + Math.abs(etchingPoint.x);
      }
      
      public function get renderingHeight() : int
      {
         return _height + Math.abs(etchingPoint.y);
      }
      
      public function get renderingRectangle() : Rectangle
      {
         return new Rectangle(renderingX,renderingY,renderingWidth,renderingHeight);
      }
      
      public function get etchingPoint() : Point
      {
         return POINT_ZERO;
      }
      
      public function get dynamicStyle() : String
      {
         return _dynamicStyle;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _context = null;
            _state = 1073741824;
            UnknownVarFromWindowModel_Array_1 = null;
            _x = _y = _width = _height = 0;
         }
      }
      
      public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      public function getInitialWidth() : int
      {
         return UnknownVarFromWindowModel_Rectangle_1.width;
      }
      
      public function getInitialHeight() : int
      {
         return UnknownVarFromWindowModel_Rectangle_1.height;
      }
      
      public function getPreviousWidth() : int
      {
         return UnknownVarFromWindowModel_Rectangle_2.width;
      }
      
      public function getPreviousHeight() : int
      {
         return UnknownVarFromWindowModel_Rectangle_2.height;
      }
      
      public function getMinimizedWidth() : int
      {
         return !!UnknownVarFromWindowModel_Rectangle_3 ? UnknownVarFromWindowModel_Rectangle_3.width : 0;
      }
      
      public function getMinimizedHeight() : int
      {
         return !!UnknownVarFromWindowModel_Rectangle_3 ? UnknownVarFromWindowModel_Rectangle_3.height : 0;
      }
      
      public function getMaximizedWidth() : int
      {
         return !!UnknownVarFromWindowModel_Rectangle_4 ? UnknownVarFromWindowModel_Rectangle_4.width : 2147483647;
      }
      
      public function getMaximizedHeight() : int
      {
         return !!UnknownVarFromWindowModel_Rectangle_4 ? UnknownVarFromWindowModel_Rectangle_4.height : 2147483647;
      }
      
      public function testTypeFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (_type & param2 ^ param1) == 0;
         }
         return (_type & param1) == param1;
      }
      
      public function testStateFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (_state & param2 ^ param1) == 0;
         }
         return (_state & param1) == param1;
      }
      
      public function testStyleFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (_style & param2 ^ param1) == 0;
         }
         return (_style & param1) == param1;
      }
      
      public function testParamFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (_param & param2 ^ param1) == 0;
         }
         return (_param & param1) == param1;
      }
   }
}

