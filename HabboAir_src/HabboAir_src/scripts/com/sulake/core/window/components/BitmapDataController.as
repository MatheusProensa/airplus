package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.PivotPoint;
   import com.sulake.core.window.theme.IPropertyMap;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapDataController extends WindowController implements UnknownICoreWindowUtils4
   {
      protected var _bitmapData:BitmapData;
      
      protected var _pivotPoint:uint;
      
      protected var _stretchedX:Boolean;
      
      protected var _stretchedY:Boolean;
      
      protected var _zoomX:Number;
      
      protected var _zoomY:Number;
      
      protected var _greyscale:Boolean;
      
      protected var _etchingColor:uint;
      
      protected var _etchingPoint:Point = new Point(0,-1);
      
      protected var _fitSizeToContents:Boolean;
      
      protected var _flipX:Boolean;
      
      protected var _flipY:Boolean;
      
      private var _wrapX:Boolean;
      
      private var _wrapY:Boolean;
      
      private var _rotation:Number;
      
      public function BitmapDataController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc12_:IPropertyMap = param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3);
         _pivotPoint = PivotPoint.pivotFromName(String(_loc12_.get("pivot_point").value));
         _stretchedX = Boolean(_loc12_.get("stretched_x").value);
         _stretchedY = Boolean(_loc12_.get("stretched_y").value);
         _zoomX = Number(_loc12_.get("zoom_x").value);
         _zoomY = Number(_loc12_.get("zoom_y").value);
         _wrapX = Boolean(_loc12_.get("wrap_x").value);
         _wrapY = Boolean(_loc12_.get("wrap_y").value);
         _flipX = Boolean(_loc12_.get("flip_x").value);
         _flipY = Boolean(_loc12_.get("flip_y").value);
         _rotation = Number(_loc12_.get("rotation").value);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         _bitmapData = null;
         super.dispose();
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return _pivotPoint;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         _pivotPoint = param1;
      }
      
      public function get stretchedX() : Boolean
      {
         return _stretchedX;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         _stretchedX = param1;
      }
      
      public function get stretchedY() : Boolean
      {
         return _stretchedY;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         _stretchedY = param1;
      }
      
      public function get zoomX() : Number
      {
         return _zoomX;
      }
      
      public function set zoomX(param1:Number) : void
      {
         _zoomX = param1;
         fitSize();
      }
      
      public function get zoomY() : Number
      {
         return _zoomY;
      }
      
      public function set zoomY(param1:Number) : void
      {
         _zoomY = param1;
         fitSize();
      }
      
      public function get greyscale() : Boolean
      {
         return _greyscale;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         _greyscale = param1;
      }
      
      public function get etchingColor() : uint
      {
         return _etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _etchingColor = param1;
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return _fitSizeToContents;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         _fitSizeToContents = param1;
         fitSize();
      }
      
      override public function get etchingPoint() : Point
      {
         return _etchingPoint;
      }
      
      override public function set etching(param1:Array) : void
      {
         etchingColor = param1[0];
         _etchingPoint = new Point(param1[1],param1[2]);
      }
      
      public function get wrapX() : Boolean
      {
         return _wrapX;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
         _wrapX = param1;
      }
      
      public function get wrapY() : Boolean
      {
         return _wrapY;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
         _wrapY = param1;
      }
      
      public function get flipX() : Boolean
      {
         return _flipX;
      }
      
      public function set flipX(param1:Boolean) : void
      {
         _flipX = param1;
      }
      
      public function get flipY() : Boolean
      {
         return _flipY;
      }
      
      public function set flipY(param1:Boolean) : void
      {
         _flipY = param1;
      }
      
      public function get rotation() : Number
      {
         return _rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         _rotation = param1;
      }
      
      protected function fitSize() : void
      {
         if(_fitSizeToContents && _bitmapData != null)
         {
            width = Math.abs(_bitmapData.width * _zoomX);
            height = Math.abs(_bitmapData.height * _zoomY);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("pivot_point",PivotPoint.PIVOT_NAMES[_pivotPoint]));
         _loc1_.push(createProperty("stretched_x",_stretchedX));
         _loc1_.push(createProperty("stretched_y",_stretchedY));
         _loc1_.push(createProperty("wrap_x",_wrapX));
         _loc1_.push(createProperty("wrap_y",_wrapY));
         _loc1_.push(createProperty("flip_x",_flipX));
         _loc1_.push(createProperty("flip_y",_flipY));
         _loc1_.push(createProperty("zoom_x",_zoomX));
         _loc1_.push(createProperty("zoom_y",_zoomY));
         _loc1_.push(createProperty("greyscale",_greyscale));
         _loc1_.push(createProperty("etching_color",_etchingColor));
         _loc1_.push(createProperty("fit_size_to_contents",_fitSizeToContents));
         _loc1_.push(createProperty("rotation",_rotation));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "pivot_point":
                  _pivotPoint = PivotPoint.pivotFromName(String(_loc2_.value));
                  break;
               case "stretched_x":
                  _stretchedX = Boolean(_loc2_.value);
                  break;
               case "stretched_y":
                  _stretchedY = Boolean(_loc2_.value);
                  break;
               case "zoom_x":
                  _zoomX = Number(_loc2_.value);
                  break;
               case "zoom_y":
                  _zoomY = Number(_loc2_.value);
                  break;
               case "wrap_x":
                  _wrapX = Boolean(_loc2_.value);
                  break;
               case "wrap_y":
                  _wrapY = Boolean(_loc2_.value);
                  break;
               case "flip_x":
                  _flipX = Boolean(_loc2_.value);
                  break;
               case "flip_y":
                  _flipY = Boolean(_loc2_.value);
                  break;
               case "greyscale":
                  _greyscale = Boolean(_loc2_.value);
                  break;
               case "etching_color":
                  _etchingColor = uint(_loc2_.value);
                  break;
               case "fit_size_to_contents":
                  fitSizeToContents = _loc2_.value as Boolean;
                  break;
               case "rotation":
                  _rotation = Number(_loc2_.value);
                  break;
            }
         }
         super.properties = param1;
      }
   }
}

