package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class StrokeController extends WindowController
   {
      public static const SIDE_TOP:uint = 1;
      
      public static const SIDE_RIGHT:uint = 2;
      
      public static const SIDE_BOTTOM:uint = 4;
      
      public static const SIDE_LEFT:uint = 8;
      
      public static const SIDES_ALL:String = "all";
      
      private static const SIDE_MASK_ALL:uint = 15;
      
      public static const SIDE_NAMES:Array = ["top","right","bottom","left"];
      
      private var _radius:Number = 0;
      
      private var _strokeThickness:Number = 0;
      
      private var _sides:String = "all";
      
      private var _sideMask:uint = 15;
      
      public function StrokeController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public static function sidesFromString(param1:String) : uint
      {
         if(param1 == null)
         {
            return 15;
         }
         var _loc2_:String = trim(param1).toLowerCase();
         if(_loc2_ == "" || _loc2_ == "all")
         {
            return 15;
         }
         var _loc4_:uint = 0;
         var _loc3_:Array = _loc2_.split(",");
         for each(var _loc5_ in _loc3_)
         {
            switch(trim(_loc5_))
            {
               case "all":
                  return 15;
               case "top":
                  _loc4_ |= 1;
                  break;
               case "right":
                  _loc4_ |= 2;
                  break;
               case "bottom":
                  _loc4_ |= 4;
                  break;
               case "left":
                  _loc4_ |= 8;
                  break;
            }
         }
         return _loc4_ == 0 ? 15 : _loc4_;
      }
      
      private static function clampNumber(param1:Number) : Number
      {
         return isNaN(param1) ? 0 : Math.max(0,param1);
      }
      
      private static function normalizeSideMask(param1:uint) : uint
      {
         var _loc2_:uint = uint(param1 & 0x0F);
         return _loc2_ == 0 ? 15 : _loc2_;
      }
      
      private static function sidesToString(param1:uint) : String
      {
         param1 = normalizeSideMask(param1);
         if(param1 == 15)
         {
            return "all";
         }
         var _loc2_:Array = [];
         if((param1 & 1) != 0)
         {
            _loc2_.push(SIDE_NAMES[0]);
         }
         if((param1 & 2) != 0)
         {
            _loc2_.push(SIDE_NAMES[1]);
         }
         if((param1 & 4) != 0)
         {
            _loc2_.push(SIDE_NAMES[2]);
         }
         if((param1 & 8) != 0)
         {
            _loc2_.push(SIDE_NAMES[3]);
         }
         return _loc2_.join(",");
      }
      
      private static function trim(param1:String) : String
      {
         return param1 == null ? "" : param1.replace(/^\s+|\s+$/g,"");
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
      
      public function set radius(param1:Number) : void
      {
         var _loc2_:Number = clampNumber(param1);
         if(_radius != _loc2_)
         {
            _radius = _loc2_;
            invalidate();
         }
      }
      
      public function get strokeThickness() : Number
      {
         return _strokeThickness;
      }
      
      public function set strokeThickness(param1:Number) : void
      {
         var _loc2_:Number = clampNumber(param1);
         if(_strokeThickness != _loc2_)
         {
            _strokeThickness = _loc2_;
            invalidate();
         }
      }
      
      public function get sides() : String
      {
         return _sides;
      }
      
      public function set sides(param1:String) : void
      {
         setSidesMask(sidesFromString(param1));
      }
      
      public function get sideMask() : uint
      {
         return _sideMask;
      }
      
      public function set sideMask(param1:uint) : void
      {
         setSidesMask(normalizeSideMask(param1));
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("radius",_radius));
         _loc1_.push(createProperty("stroke_thickness",_strokeThickness));
         _loc1_.push(createProperty("sides",_sides));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:* = 0;
         var _loc5_:Boolean = false;
         for each(var _loc3_ in param1)
         {
            switch(_loc3_.key)
            {
               case "radius":
                  _loc4_ = clampNumber(Number(_loc3_.value));
                  if(_radius != _loc4_)
                  {
                     _radius = _loc4_;
                     _loc5_ = true;
                  }
                  break;
               case "stroke_thickness":
                  _loc4_ = clampNumber(Number(_loc3_.value));
                  if(_strokeThickness != _loc4_)
                  {
                     _strokeThickness = _loc4_;
                     _loc5_ = true;
                  }
                  break;
               case "sides":
                  _loc2_ = sidesFromString(String(_loc3_.value));
                  if(updateSides(_loc2_))
                  {
                     _loc5_ = true;
                  }
                  break;
            }
         }
         if(_loc5_)
         {
            invalidate();
         }
         super.properties = param1;
      }
      
      private function setSidesMask(param1:uint) : void
      {
         if(updateSides(param1))
         {
            invalidate();
         }
      }
      
      private function updateSides(param1:uint) : Boolean
      {
         param1 = normalizeSideMask(param1);
         var _loc2_:String = sidesToString(param1);
         if(_sideMask != param1 || _sides != _loc2_)
         {
            _sideMask = param1;
            _sides = _loc2_;
            return true;
         }
         return false;
      }
   }
}

