package com.sulake.core.window.dynamicstyle
{
   import com.sulake.core.window.WindowController;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class DynamicStyle
   {
      public static const STYLE_LIFTED_HOVER:String = "lifted_hover";
      
      public static const UnknownConstFromHabboWindowType_Uint_2:String = "button";
      
      public static const BRIGHTNESS_AND_SHADOW_UNDER:String = "brightness_and_shadow_under";
      
      public static const BRIGHTNESS_AND_SHADOW_UNDER_GENTLE:String = "brightness_and_shadow_under_gentle";
      
      public static const REWARD_TRACK_ITEM:String = "reward_track_item";
      
      public var name:String;
      
      public var hoverStyles:Object = {};
      
      public var defaultStyles:Object = {};
      
      public var pressedSyles:Object = {};
      
      public var disabledStyles:Object = {"colorTransform":[1,1,1,0.5,0,0,0,0]};
      
      public var childDynamicStyles:Dictionary = new Dictionary();
      
      public function DynamicStyle(param1:String = "")
      {
         super();
         this.name = param1;
      }
      
      public function getStyleByWindowState(param1:uint) : Object
      {
         switch(param1)
         {
            case 16:
               return pressedSyles;
            case 4:
               return hoverStyles;
            case 0:
               return defaultStyles;
            case 32:
               return disabledStyles;
            default:
               return {};
         }
      }
      
      private function getChildDynamicStyleByKey(param1:String) : DynamicStyle
      {
         if(childDynamicStyles[param1])
         {
            return childDynamicStyles[param1];
         }
         return new DynamicStyle();
      }
      
      public function getChildStyle(param1:WindowController) : DynamicStyle
      {
         for each(var _loc2_ in param1.tags)
         {
            if(_loc2_.charAt(0) == "#")
            {
               return getChildDynamicStyleByKey(_loc2_);
            }
         }
         return null;
      }
      
      public function getColorValue(param1:uint) : uint
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(getStyleByWindowState(param1).colorTransform)
         {
            _loc2_ = getStyleByWindowState(param1).colorTransform;
            _loc3_ = "";
            _loc4_ = 0;
            while(_loc4_ < 3)
            {
               _loc5_ = _loc2_[_loc4_] * 255 + _loc2_[_loc4_ + 4];
               _loc3_ += Math.min(255,_loc5_).toString(16);
               _loc4_++;
            }
            return parseInt(_loc3_,16);
         }
         return null;
      }
      
      public function getColorTransform(param1:uint) : ColorTransform
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         if(getStyleByWindowState(param1).colorTransform)
         {
            _loc2_ = getStyleByWindowState(param1).colorTransform;
            _loc3_ = getStyleByWindowState(param1).tint;
            if(!_loc3_)
            {
               _loc3_ = [255,255,255];
            }
            return new ColorTransform(_loc2_[0] * _loc3_[0] / 255,_loc2_[1] * _loc3_[1] / 255,_loc2_[2] * _loc3_[2] / 255,_loc2_[3],_loc2_[4],_loc2_[5],_loc2_[6],_loc2_[7]);
         }
         return new ColorTransform();
      }
   }
}

