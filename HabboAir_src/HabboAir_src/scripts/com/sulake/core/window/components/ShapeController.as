package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class ShapeController extends ContainerController
   {
      public static const SHAPE_RECTANGLE:String = "rectangle";
      
      public static const SHAPE_ROUND_RECTANGLE:String = "round_rectangle";
      
      public static const SHAPE_ELLIPSE:String = "ellipse";
      
      public static const SHAPE_RHOMBUS:String = "rhombus";
      
      public static const SHAPES:Array = ["rectangle","round_rectangle","ellipse","rhombus"];
      
      private var _shape:String = "rectangle";
      
      private var _radius:Number = 0;
      
      private var _strokeColor:uint = 4278190080;
      
      private var _strokeHsvShade:Number = 0;
      
      private var _strokeThickness:Number = 0;
      
      public function ShapeController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         UnknownVarFromWindowController_Boolean_1 = true;
      }
      
      public static function normalizeShape(param1:String) : String
      {
         return SHAPES.indexOf(param1) >= 0 ? param1 : "rectangle";
      }
      
      public function get shape() : String
      {
         return _shape;
      }
      
      public function set shape(param1:String) : void
      {
         var _loc2_:String = normalizeShape(param1);
         if(_shape != _loc2_)
         {
            _shape = _loc2_;
            invalidate();
         }
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
      
      public function set radius(param1:Number) : void
      {
         var _loc2_:Number = isNaN(param1) ? 0 : Math.max(0,param1);
         if(_radius != _loc2_)
         {
            _radius = _loc2_;
            invalidate();
         }
      }
      
      public function get strokeColor() : uint
      {
         return _strokeColor;
      }
      
      public function set strokeColor(param1:uint) : void
      {
         if(_strokeColor != param1)
         {
            _strokeColor = param1;
            invalidate();
         }
      }
      
      public function get strokeHsvShade() : Number
      {
         return _strokeHsvShade;
      }
      
      public function set strokeHsvShade(param1:Number) : void
      {
         var _loc2_:Number = isNaN(param1) ? 0 : param1;
         if(_strokeHsvShade != _loc2_)
         {
            _strokeHsvShade = _loc2_;
            invalidate();
         }
      }
      
      public function get strokeThickness() : Number
      {
         return _strokeThickness;
      }
      
      public function set strokeThickness(param1:Number) : void
      {
         var _loc2_:Number = isNaN(param1) ? 0 : Math.max(0,param1);
         if(_strokeThickness != _loc2_)
         {
            _strokeThickness = _loc2_;
            invalidate();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("shape",_shape));
         _loc1_.push(createProperty("radius",_radius));
         _loc1_.push(createProperty("stroke_color",_strokeColor));
         _loc1_.push(createProperty("stroke_hsv_shade",_strokeHsvShade));
         _loc1_.push(createProperty("stroke_thickness",_strokeThickness));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:* = 0;
         var _loc6_:Boolean = false;
         for each(var _loc3_ in param1)
         {
            switch(_loc3_.key)
            {
               case "shape":
                  _loc2_ = normalizeShape(String(_loc3_.value));
                  if(_shape != _loc2_)
                  {
                     _shape = _loc2_;
                     _loc6_ = true;
                  }
                  break;
               case "radius":
                  _loc4_ = Number(_loc3_.value);
                  _loc4_ = isNaN(_loc4_) ? 0 : Math.max(0,_loc4_);
                  if(_radius != _loc4_)
                  {
                     _radius = _loc4_;
                     _loc6_ = true;
                  }
                  break;
               case "stroke_color":
                  _loc5_ = uint(_loc3_.value);
                  if(_strokeColor != _loc5_)
                  {
                     _strokeColor = _loc5_;
                     _loc6_ = true;
                  }
                  break;
               case "stroke_hsv_shade":
                  _loc4_ = Number(_loc3_.value);
                  _loc4_ = isNaN(_loc4_) ? 0 : _loc4_;
                  if(_strokeHsvShade != _loc4_)
                  {
                     _strokeHsvShade = _loc4_;
                     _loc6_ = true;
                  }
                  break;
               case "stroke_thickness":
                  _loc4_ = Number(_loc3_.value);
                  _loc4_ = isNaN(_loc4_) ? 0 : Math.max(0,_loc4_);
                  if(_strokeThickness != _loc4_)
                  {
                     _strokeThickness = _loc4_;
                     _loc6_ = true;
                  }
                  break;
            }
         }
         if(_loc6_)
         {
            invalidate();
         }
         super.properties = param1;
      }
   }
}

