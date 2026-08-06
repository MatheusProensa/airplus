package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.Map;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.text.StyleSheet;
   
   public class TextStyleManager
   {
      public static const REGULAR:String = "regular";
      
      public static const ITALIC:String = "italic";
      
      public static const BOLD:String = "bold";
      
      private static var UnknownVarFromTextStyleManager_Map_1:Map;
      
      private static var _styleSheetNames:Array;
      
      private static var _events:IEventDispatcher;
      
      private static const TAG_OPEN:String = "{";
      
      private static const TAG_CLOSE:String = "}";
      
      private static const CMT_OPEN:String = "/*";
      
      private static const CMT_CLOSE:String = "*/";
      
      init();
      
      public function TextStyleManager()
      {
         super();
      }
      
      public static function get events() : IEventDispatcher
      {
         return _events;
      }
      
      private static function init() : void
      {
         var _loc1_:UnknownCoreWindowUtils3 = null;
         UnknownVarFromTextStyleManager_Map_1 = new Map();
         _styleSheetNames = [];
         _events = new EventDispatcherWrapper();
         _loc1_ = new UnknownCoreWindowUtils3();
         _loc1_.name = "regular";
         _loc1_.color = 0;
         _loc1_.fontSize = "9";
         _loc1_.fontFamily = "Courier";
         _loc1_.fontStyle = "normal";
         _loc1_.fontWeight = "normal";
         UnknownVarFromTextStyleManager_Map_1[_loc1_.name] = _loc1_;
         _styleSheetNames.push(_loc1_.name);
         _loc1_ = new UnknownCoreWindowUtils3();
         _loc1_.name = "italic";
         _loc1_.color = 0;
         _loc1_.fontSize = "9";
         _loc1_.fontFamily = "Courier";
         _loc1_.fontStyle = "italic";
         _loc1_.fontWeight = "normal";
         UnknownVarFromTextStyleManager_Map_1[_loc1_.name] = _loc1_;
         _styleSheetNames.push(_loc1_.name);
         _loc1_ = new UnknownCoreWindowUtils3();
         _loc1_.name = "bold";
         _loc1_.color = 0;
         _loc1_.fontSize = "9";
         _loc1_.fontFamily = "Courier";
         _loc1_.fontStyle = "normal";
         _loc1_.fontWeight = "bold";
         UnknownVarFromTextStyleManager_Map_1[_loc1_.name] = _loc1_;
         _styleSheetNames.push(_loc1_.name);
      }
      
      public static function getStyle(param1:String) : UnknownCoreWindowUtils3
      {
         return UnknownVarFromTextStyleManager_Map_1[param1];
      }
      
      public static function getStyleWithIndex(param1:int) : UnknownCoreWindowUtils3
      {
         return UnknownVarFromTextStyleManager_Map_1.getWithIndex(param1);
      }
      
      public static function setStyle(param1:String, param2:UnknownCoreWindowUtils3) : void
      {
         var _loc3_:* = !UnknownVarFromTextStyleManager_Map_1.hasKey(param1);
         param2.name = param1;
         UnknownVarFromTextStyleManager_Map_1[param1] = param2;
         if(_loc3_)
         {
            _styleSheetNames.push(param1);
            _events.dispatchEvent(new Event("added"));
         }
         else
         {
            _events.dispatchEvent(new Event("change"));
         }
      }
      
      public static function setStyles(param1:Array, param2:Boolean = false) : void
      {
         var _loc3_:Array = null;
         if(param2)
         {
            _loc3_ = [UnknownVarFromTextStyleManager_Map_1["regular"],UnknownVarFromTextStyleManager_Map_1["italic"],UnknownVarFromTextStyleManager_Map_1["bold"]];
            UnknownVarFromTextStyleManager_Map_1.reset();
            UnknownVarFromTextStyleManager_Map_1["regular"] = _loc3_[0];
            UnknownVarFromTextStyleManager_Map_1["italic"] = _loc3_[1];
            UnknownVarFromTextStyleManager_Map_1["bold"] = _loc3_[2];
         }
         var _loc4_:int = int(UnknownVarFromTextStyleManager_Map_1.length);
         for each(var _loc5_ in param1)
         {
            UnknownVarFromTextStyleManager_Map_1[_loc5_.name] = _loc5_;
            if(_styleSheetNames.indexOf(_loc5_.name) == -1)
            {
               _styleSheetNames.push(_loc5_.name);
            }
         }
         _events.dispatchEvent(new Event("change"));
         if(UnknownVarFromTextStyleManager_Map_1.length != _loc4_)
         {
            _events.dispatchEvent(new Event("added"));
         }
      }
      
      public static function findMatchingTextStyle(param1:String) : UnknownCoreWindowUtils3
      {
         var _loc2_:UnknownCoreWindowUtils3 = null;
         var _loc3_:UnknownCoreWindowUtils3 = parseCSS(param1)[0] as UnknownCoreWindowUtils3;
         if(_loc3_)
         {
            _loc2_ = UnknownVarFromTextStyleManager_Map_1[_loc3_.name];
            if(_loc2_ && _loc2_.equals(_loc3_))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function enumerateStyles() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = int(UnknownVarFromTextStyleManager_Map_1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.push(UnknownVarFromTextStyleManager_Map_1.getWithIndex(_loc3_));
            _loc3_++;
         }
         return _loc1_;
      }
      
      public static function enumerateStyleNames() : Array
      {
         return UnknownVarFromTextStyleManager_Map_1.getKeys();
      }
      
      public static function getStyleNameArrayRef() : Array
      {
         return _styleSheetNames;
      }
      
      public static function parseCSS(param1:String) : Array
      {
         var _loc7_:Object = null;
         var _loc6_:UnknownCoreWindowUtils3 = null;
         var _loc5_:StyleSheet = new StyleSheet();
         _loc5_.parseCSS(param1);
         var _loc3_:Array = parseStyleNamesFromCSS(param1);
         var _loc2_:Array = [];
         for each(var _loc4_ in _loc3_)
         {
            _loc7_ = _loc5_.getStyle(_loc4_);
            _loc6_ = new UnknownCoreWindowUtils3();
            _loc6_.name = _loc4_;
            _loc6_.color = !!_loc7_.color ? uint(String(_loc7_.color).replace("#","0x")) : null;
            _loc6_.fontFamily = !!_loc7_.fontFamily ? _loc7_.fontFamily : null;
            _loc6_.fontSize = !!_loc7_.fontSize ? parseInt(String(_loc7_.fontSize)) : null;
            _loc6_.fontStyle = !!_loc7_.fontStyle ? _loc7_.fontStyle : null;
            _loc6_.fontWeight = !!_loc7_.fontWeight ? _loc7_.fontWeight : null;
            _loc6_.kerning = !!_loc7_.kerning ? _loc7_.kerning == "true" : null;
            _loc6_.leading = !!_loc7_.leading ? parseInt(String(_loc7_.leading)) : null;
            _loc6_.letterSpacing = !!_loc7_.letterSpacing ? parseInt(_loc7_.letterSpacing.toString()) : null;
            _loc6_.textDecoration = !!_loc7_.textDecoration ? _loc7_.textDecoration : null;
            _loc6_.textIndent = !!_loc7_.textIndent ? parseInt(_loc7_.textIndent.toString()) : null;
            _loc6_.antiAliasType = !!_loc7_.antiAliasType ? _loc7_.antiAliasType : null;
            _loc6_.sharpness = !!_loc7_.sharpness ? parseInt(_loc7_.sharpness) : null;
            _loc6_.thickness = !!_loc7_.thickness ? parseInt(_loc7_.thickness) : null;
            _loc6_.etchingColor = !!_loc7_.etchingColor ? uint(String(_loc7_.etchingColor).replace("#","0x")) : null;
            _loc6_.etchingPosition = !!_loc7_.etchingPosition ? String(_loc7_.etchingPosition) : null;
            _loc2_.push(_loc6_);
         }
         return _loc2_;
      }
      
      private static function parseStyleNamesFromCSS(param1:String) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:* = param1;
         _loc3_ = _loc3_.split("\t").join("");
         _loc3_ = _loc3_.split("\n").join("");
         _loc3_ = _loc3_.split("\r").join("");
         var _loc4_:Array = _loc3_.split("}");
         if(countSubStrings(param1,"{") != countSubStrings(param1,"}"))
         {
            throw new Error("Mismatching amount of \"{\" versus \"}\", please check the CSS!");
         }
         for each(var _loc5_ in _loc4_)
         {
            while(_loc5_.indexOf("/*") == 0)
            {
               _loc5_ = _loc5_.substring(_loc5_.indexOf("*/") + 2,_loc5_.length);
            }
            _loc5_ = _loc5_.slice(0,_loc5_.indexOf("{")).split(" ").join("");
            if(_loc5_.length)
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      private static function countSubStrings(param1:String, param2:String) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(true)
         {
            _loc4_ = int(param1.indexOf(param2,_loc4_));
            if(_loc4_ == -1)
            {
               break;
            }
            _loc4_++;
            _loc3_++;
         }
         return _loc3_;
      }
      
      public static function toString() : String
      {
         var _loc2_:Array = enumerateStyles();
         var _loc1_:String = "";
         for each(var _loc3_ in _loc2_)
         {
            _loc1_ += _loc3_.toString() + "\n\n";
         }
         return _loc1_;
      }
   }
}

