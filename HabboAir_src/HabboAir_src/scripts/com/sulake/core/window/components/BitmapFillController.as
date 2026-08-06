package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.theme.IPropertyMap;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class BitmapFillController extends StaticBitmapWrapperController
   {
      public static const FILL_MODE_STRETCH:String = "stretch";
      
      public static const FILL_MODE_TILE:String = "tile";
      
      public static const FILL_MODE_CENTER:String = "center";
      
      public static const FILL_MODE_COVER:String = "cover";
      
      public static const FILL_MODE_CONTAIN:String = "contain";
      
      public static const FILL_MODES:Array = ["stretch","tile","center","cover","contain"];
      
      private var _fillMode:String = "stretch";
      
      private var _tint:Boolean = false;
      
      private var _spacing:Number = 0;
      
      public function BitmapFillController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc12_:IPropertyMap = param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3);
         _fillMode = normalizeFillMode(String(_loc12_.get("fill_mode").value));
         _tint = parseBoolean(_loc12_.get("tint").value);
         _spacing = normalizeSpacing(Number(_loc12_.get("spacing").value));
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public static function normalizeFillMode(param1:String) : String
      {
         return FILL_MODES.indexOf(param1) >= 0 ? param1 : "stretch";
      }
      
      public static function normalizeSpacing(param1:Number) : Number
      {
         return isNaN(param1) ? 0 : Math.max(0,param1);
      }
      
      private static function parseBoolean(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(param1 is Boolean)
         {
            return Boolean(param1);
         }
         if(param1 is String)
         {
            _loc2_ = String(param1).replace(/^\s+|\s+$/g,"").toLowerCase();
            return _loc2_ == "true" || _loc2_ == "1";
         }
         return Boolean(param1);
      }
      
      public function get fillMode() : String
      {
         return _fillMode;
      }
      
      public function set fillMode(param1:String) : void
      {
         var _loc2_:String = normalizeFillMode(param1);
         if(_fillMode != _loc2_)
         {
            _fillMode = _loc2_;
            invalidate();
         }
      }
      
      public function get tint() : Boolean
      {
         return _tint;
      }
      
      public function set tint(param1:Boolean) : void
      {
         if(_tint != param1)
         {
            _tint = param1;
            invalidate();
         }
      }
      
      public function get spacing() : Number
      {
         return _spacing;
      }
      
      public function set spacing(param1:Number) : void
      {
         var _loc2_:Number = normalizeSpacing(param1);
         if(_spacing != _loc2_)
         {
            _spacing = _loc2_;
            invalidate();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("fill_mode",_fillMode));
         _loc1_.push(createProperty("tint",_tint));
         _loc1_.push(createProperty("spacing",_spacing));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         for each(var _loc3_ in param1)
         {
            switch(_loc3_.key)
            {
               case "fill_mode":
                  _loc2_ = normalizeFillMode(String(_loc3_.value));
                  if(_fillMode != _loc2_)
                  {
                     _fillMode = _loc2_;
                     _loc6_ = true;
                  }
                  break;
               case "tint":
                  _loc4_ = parseBoolean(_loc3_.value);
                  if(_tint != _loc4_)
                  {
                     _tint = _loc4_;
                     _loc6_ = true;
                  }
                  break;
               case "spacing":
                  _loc5_ = normalizeSpacing(Number(_loc3_.value));
                  if(_spacing != _loc5_)
                  {
                     _spacing = _loc5_;
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

