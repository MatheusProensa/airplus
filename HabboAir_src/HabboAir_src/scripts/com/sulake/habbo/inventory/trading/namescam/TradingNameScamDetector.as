package com.sulake.habbo.inventory.trading.namescam
{
   public class TradingNameScamDetector
   {
      private static const MAX_CASE_CHANGES:int = 2;
      
      private static const MAX_SMALL_PUNCTUATION_DEVIATIONS:int = 2;
      
      private static const ALLOWED_PUNCTUATION:String = "_-=?!@:.,;";
      
      private static const SMALL_PUNCTUATION:String = ".,:";
      
      private static const EXTRA_ALLOWED_LETTERS:String = "ÅÄÖåäöŞÇÜĞşçıüğ";
      
      private static var UnknownVarFromTradingNameScamDetector_Object_1:Object;
      
      private static const CONFUSABLE_GROUPS:Array = ["0OoÖö","1lI!",".,",";:","AÅÄaåä","CÇcç","GĞgğ","SŞsş","UÜuü"];
      
      public function TradingNameScamDetector()
      {
         super();
      }
      
      public static function detect(param1:String, param2:Array, param3:Array) : TradingNameScamDetectionResult
      {
         return new TradingNameScamDetectionResult(collectMatchingNames(param1,param2),collectMatchingNames(param1,param3));
      }
      
      public static function isPotentialScamName(param1:String, param2:String) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1.length == 0 || param2.length == 0 || param1 == param2)
         {
            return false;
         }
         if(!isAllowedName(param1) || !isAllowedName(param2))
         {
            return false;
         }
         return compareNames(param1,param2,0,0,0,0,{});
      }
      
      private static function collectMatchingNames(param1:String, param2:Array) : Array
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = [];
         if(param2 == null || param1 == null || param1.length == 0)
         {
            return _loc6_;
         }
         var _loc7_:Object = {};
         for each(var _loc3_ in param2)
         {
            _loc4_ = _loc3_ as String;
            if(!(_loc4_ == null || _loc4_.length == 0 || _loc4_ == param1))
            {
               _loc5_ = "name:" + _loc4_;
               if(!_loc7_[_loc5_])
               {
                  if(isPotentialScamName(param1,_loc4_))
                  {
                     _loc7_[_loc5_] = true;
                     _loc6_.push(_loc4_);
                  }
               }
            }
         }
         return _loc6_;
      }
      
      private static function compareNames(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int, param7:Object) : Boolean
      {
         var _loc9_:String = null;
         var _loc11_:String = null;
         if(param5 > 2 || param6 > 2)
         {
            return false;
         }
         var _loc10_:String = param3 + "|" + param4 + "|" + param5 + "|" + param6;
         if(param7[_loc10_] !== undefined)
         {
            return param7[_loc10_];
         }
         var _loc8_:Boolean = false;
         if(param3 == param1.length && param4 == param2.length)
         {
            _loc8_ = true;
         }
         else if(param3 < param1.length && param4 < param2.length)
         {
            _loc9_ = param1.charAt(param3);
            _loc11_ = param2.charAt(param4);
            if(_loc9_ == _loc11_)
            {
               _loc8_ = compareNames(param1,param2,param3 + 1,param4 + 1,param5,param6,param7);
            }
            else if(isCaseOnlyChange(_loc9_,_loc11_))
            {
               _loc8_ = compareNames(param1,param2,param3 + 1,param4 + 1,param5,param6 + 1,param7);
            }
            else if(areConfusable(_loc9_,_loc11_))
            {
               _loc8_ = compareNames(param1,param2,param3 + 1,param4 + 1,param5,param6,param7);
            }
         }
         if(!_loc8_ && param3 < param1.length && isSmallPunctuation(param1.charAt(param3)))
         {
            _loc8_ = compareNames(param1,param2,param3 + 1,param4,param5 + 1,param6,param7);
         }
         if(!_loc8_ && param4 < param2.length && isSmallPunctuation(param2.charAt(param4)))
         {
            _loc8_ = compareNames(param1,param2,param3,param4 + 1,param5 + 1,param6,param7);
         }
         param7[_loc10_] = _loc8_;
         return _loc8_;
      }
      
      private static function isAllowedName(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(!isAllowedCharacter(param1.charAt(_loc2_)))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private static function isAllowedCharacter(param1:String) : Boolean
      {
         if(param1 == null || param1.length != 1)
         {
            return false;
         }
         var _loc2_:int = int(param1.charCodeAt(0));
         if(_loc2_ >= 48 && _loc2_ <= 57 || _loc2_ >= 65 && _loc2_ <= 90 || _loc2_ >= 97 && _loc2_ <= 122)
         {
            return true;
         }
         return "_-=?!@:.,;".indexOf(param1) >= 0 || "ÅÄÖåäöŞÇÜĞşçıüğ".indexOf(param1) >= 0;
      }
      
      private static function isLetter(param1:String) : Boolean
      {
         if(param1 == null || param1.length != 1)
         {
            return false;
         }
         var _loc2_:int = int(param1.charCodeAt(0));
         return _loc2_ >= 65 && _loc2_ <= 90 || _loc2_ >= 97 && _loc2_ <= 122 || "ÅÄÖåäöŞÇÜĞşçıüğ".indexOf(param1) >= 0;
      }
      
      private static function isCaseOnlyChange(param1:String, param2:String) : Boolean
      {
         if(!isLetter(param1) || !isLetter(param2) || param1 == param2)
         {
            return false;
         }
         return param1.toLowerCase() == param2.toLowerCase() && param1.toUpperCase() == param2.toUpperCase();
      }
      
      private static function isSmallPunctuation(param1:String) : Boolean
      {
         return ".,:".indexOf(param1) >= 0;
      }
      
      private static function areConfusable(param1:String, param2:String) : Boolean
      {
         if(param1 == null || param2 == null || param1 == param2)
         {
            return false;
         }
         var _loc5_:Object = getConfusableGroupByCharacter();
         var _loc4_:String = _loc5_[param1];
         var _loc3_:String = _loc5_[param2];
         return _loc4_ != null && _loc4_ == _loc3_;
      }
      
      private static function getConfusableGroupByCharacter() : Object
      {
         var _loc1_:int = 0;
         if(UnknownVarFromTradingNameScamDetector_Object_1 == null)
         {
            UnknownVarFromTradingNameScamDetector_Object_1 = {};
            for each(var _loc2_ in CONFUSABLE_GROUPS)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc2_.length)
               {
                  UnknownVarFromTradingNameScamDetector_Object_1[_loc2_.charAt(_loc1_)] = _loc2_;
                  _loc1_++;
               }
            }
         }
         return UnknownVarFromTradingNameScamDetector_Object_1;
      }
   }
}

