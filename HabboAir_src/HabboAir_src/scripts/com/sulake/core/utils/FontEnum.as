package com.sulake.core.utils
{
   import flash.text.Font;
   import flash.utils.getQualifiedClassName;
   
   public class FontEnum
   {
      private static var _init:Boolean = false;
      
      private static const _systemFonts:Map = new Map();
      
      private static const _embeddedFonts:Map = new Map();
      
      init();
      
      public function FontEnum()
      {
         super();
      }
      
      public static function isSystemFont(param1:String) : Boolean
      {
         return _systemFonts.getValue(param1) != null;
      }
      
      public static function isEmbeddedFont(param1:String) : Boolean
      {
         return _embeddedFonts.getValue(param1) != null;
      }
      
      public static function get systemFonts() : Map
      {
         return _systemFonts;
      }
      
      public static function get embeddedFonts() : Map
      {
         return _embeddedFonts;
      }
      
      public static function registerFont(param1:Class) : Font
      {
         var _loc2_:Font = null;
         var _loc5_:* = 0;
         Font.registerFont(param1 as Class);
         var _loc3_:String = getQualifiedClassName(param1);
         var _loc6_:Array = Font.enumerateFonts(false);
         var _loc4_:int;
         _loc5_ = _loc4_ = int(_loc6_.length);
         while(_loc5_ > 0)
         {
            _loc2_ = _loc6_[_loc5_ - 1];
            if(getQualifiedClassName(_loc2_) == _loc3_)
            {
               break;
            }
            _loc5_--;
         }
         _embeddedFonts.add(_loc2_.fontName,_loc2_);
         return _loc2_;
      }
      
      private static function init() : void
      {
         var _loc2_:Array = null;
         var _loc1_:Array = null;
         if(!_init)
         {
            _loc2_ = Font.enumerateFonts(true);
            _loc1_ = Font.enumerateFonts(false);
            for each(var _loc3_ in _loc2_)
            {
               if(_loc1_.indexOf(_loc3_) == -1)
               {
                  _systemFonts.add(_loc3_.fontName,_loc3_);
               }
            }
            _init = true;
         }
      }
      
      public static function refresh() : void
      {
         var _loc1_:Font = null;
         var _loc5_:Font = null;
         var _loc3_:int = 0;
         var _loc4_:Array = Font.enumerateFonts(false);
         var _loc2_:int = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc4_[_loc3_];
            _loc5_ = _embeddedFonts.getValue(_loc1_.fontName);
            if(!_loc5_ || _loc5_.fontType != _loc1_.fontType || _loc5_.fontStyle != _loc1_.fontStyle)
            {
               _embeddedFonts.add(_loc1_.fontName,_loc1_);
            }
            _loc3_++;
         }
      }
   }
}

