package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class GradientController extends WindowController
   {
      public static const MODE_LINEAR:String = "linear";
      
      public static const MODE_RADIAL:String = "radial";
      
      public static const UnknownConstFromGradientController_String_1:String = "up_left";
      
      public static const DIRECTION_UP_RIGHT:String = "up_right";
      
      public static const UnknownConstFromGradientController_String_2:String = "down_left";
      
      public static const DIRECTION_DOWN_RIGHT:String = "down_right";
      
      private static const DEFAULT_COLOR1:uint = 4294967295;
      
      private static const DEFAULT_COLOR2:uint = 4278190080;
      
      private static const DEFAULT_MODE:String = "linear";
      
      private static const DEFAULT_DIRECTION:String = "down";
      
      public static const MODES:Array = ["linear","radial"];
      
      public static const UnknownConstFromAvatarImageWidget_Array_1:Array = ["up","down","left","right","up_left","up_right","down_left","down_right"];
      
      private var _color1:uint = 4294967295;
      
      private var _color2:uint = 4278190080;
      
      private var _mode:String = "linear";
      
      private var _direction:String = "down";
      
      public function GradientController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public static function normalizeMode(param1:String) : String
      {
         return param1 == "radial" ? "radial" : "linear";
      }
      
      public static function normalizeDirection(param1:String) : String
      {
         return UnknownConstFromAvatarImageWidget_Array_1.indexOf(param1) >= 0 ? param1 : "down";
      }
      
      public function get color1() : uint
      {
         return _color1;
      }
      
      public function set color1(param1:uint) : void
      {
         if(_color1 != param1)
         {
            _color1 = param1;
            invalidate();
         }
      }
      
      public function get color2() : uint
      {
         return _color2;
      }
      
      public function set color2(param1:uint) : void
      {
         if(_color2 != param1)
         {
            _color2 = param1;
            invalidate();
         }
      }
      
      public function get mode() : String
      {
         return _mode;
      }
      
      public function set mode(param1:String) : void
      {
         var _loc2_:String = normalizeMode(param1);
         if(_mode != _loc2_)
         {
            _mode = _loc2_;
            invalidate();
         }
      }
      
      public function get direction() : String
      {
         return _direction;
      }
      
      public function set direction(param1:String) : void
      {
         var _loc2_:String = normalizeDirection(param1);
         if(_direction != _loc2_)
         {
            _direction = _loc2_;
            invalidate();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("color1",_color1));
         _loc1_.push(createProperty("color2",_color2));
         _loc1_.push(createProperty("mode",_mode));
         _loc1_.push(new PropertyStruct("direction",_direction,"String",_direction != "down",UnknownConstFromAvatarImageWidget_Array_1));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "color1":
                  if(_color1 != uint(_loc2_.value))
                  {
                     _color1 = uint(_loc2_.value);
                     _loc4_ = true;
                  }
                  break;
               case "color2":
                  if(_color2 != uint(_loc2_.value))
                  {
                     _color2 = uint(_loc2_.value);
                     _loc4_ = true;
                  }
                  break;
               case "mode":
                  _loc3_ = normalizeMode(String(_loc2_.value));
                  if(_mode != _loc3_)
                  {
                     _mode = _loc3_;
                     _loc4_ = true;
                  }
                  break;
               case "direction":
                  _loc3_ = normalizeDirection(String(_loc2_.value));
                  if(_direction != _loc3_)
                  {
                     _direction = _loc3_;
                     _loc4_ = true;
                  }
                  break;
            }
         }
         if(_loc4_)
         {
            invalidate();
         }
         super.properties = param1;
      }
   }
}

