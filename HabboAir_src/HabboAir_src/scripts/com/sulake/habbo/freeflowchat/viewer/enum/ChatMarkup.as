package com.sulake.habbo.freeflowchat.viewer.enum
{
   public class ChatMarkup
   {
      public static const COLOUR_ARRAY:Array = [["red",9115929],["cyan",32639],["blue",19609],["green",32768],["purple",4980812]];
      
      public static const UnknownConstFromChatMarkup_Array_1:Array = [["red",16738922],["cyan",5233370],["blue",6269183],["green",6738794],["purple",11767039]];
      
      public static const COLOUR_NAMES:Array = (function():Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in COLOUR_ARRAY)
         {
            _loc1_.push(_loc2_[0]);
         }
         return _loc1_;
      })();
      
      public function ChatMarkup()
      {
         super();
      }
      
      private static function getColourArray(param1:uint) : Array
      {
         return param1 == 16777215 ? UnknownConstFromChatMarkup_Array_1 : COLOUR_ARRAY;
      }
      
      private static function getHexColorForTag(param1:String, param2:uint) : String
      {
         var _loc3_:Array = getColourArray(param2);
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_[0] == param1)
            {
               return "#" + _loc4_[1].toString(16).toUpperCase();
            }
         }
         return null;
      }
      
      public static function applyColourToChat(param1:String, param2:uint) : String
      {
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc5_:Array = getColourArray(param2);
         for each(var _loc4_ in _loc5_)
         {
            if(param1.indexOf("@" + _loc4_[0] + "@") == 0)
            {
               _loc3_ = "#" + _loc4_[1].toString(16).toUpperCase();
               _loc6_ = param1.substring(_loc4_[0].length + 2,param1.length);
               if(_loc6_.charAt(0) == " ")
               {
                  _loc6_ = _loc6_.substr(1);
               }
               return "<font color=\"" + _loc3_ + "\">" + _loc6_ + "</font>";
            }
         }
         return param1;
      }
      
      public static function tokenize(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc5_:String = "";
         var _loc6_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc4_);
            if(_loc3_ == "[")
            {
               if(_loc5_.length > 0)
               {
                  _loc2_.push(_loc5_);
                  _loc5_ = "";
               }
               _loc6_ = true;
               _loc5_ += _loc3_;
            }
            else if(_loc3_ == "]" && _loc6_)
            {
               _loc5_ += _loc3_;
               _loc2_.push(_loc5_);
               _loc5_ = "";
               _loc6_ = false;
            }
            else
            {
               _loc5_ += _loc3_;
            }
            _loc4_++;
         }
         if(_loc5_.length > 0)
         {
            _loc2_.push(_loc5_);
         }
         return _loc2_;
      }
      
      public static function applyToElements(param1:String, param2:uint) : String
      {
         var _loc7_:int = 0;
         var _loc10_:String = null;
         var _loc8_:String = null;
         var _loc9_:* = false;
         var _loc4_:Object = null;
         var _loc3_:String = null;
         if(param1.length == 0)
         {
            return "";
         }
         var _loc5_:Array = tokenize(param1);
         var _loc6_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc10_ = _loc5_[_loc7_];
            if(_loc10_.charAt(0) == "[" && _loc10_.charAt(_loc10_.length - 1) == "]" && (_loc10_.charAt(1) == "/" || _loc10_.length > 2 && _loc10_.length <= 10))
            {
               _loc8_ = _loc10_.substring(1,_loc10_.length - 1).toLowerCase();
               _loc9_ = _loc8_.charAt(0) == "/";
               if(_loc9_)
               {
                  _loc8_ = _loc8_.substr(1);
                  if(_loc6_.length > 0 && _loc6_[_loc6_.length - 1].tag == _loc8_)
                  {
                     _loc4_ = _loc6_.pop();
                     if(_loc8_ == "b" || _loc8_ == "i" || _loc8_ == "u")
                     {
                        _loc5_[_loc4_.index] = "<" + _loc8_ + ">";
                        _loc5_[_loc7_] = "</" + _loc8_ + ">";
                     }
                     else
                     {
                        _loc3_ = getHexColorForTag(_loc8_,param2);
                        if(_loc3_ != null)
                        {
                           _loc5_[_loc4_.index] = "<font color=\"" + _loc3_ + "\">";
                           _loc5_[_loc7_] = "</font>";
                        }
                     }
                  }
               }
               else if(_loc8_ == "b" || _loc8_ == "i" || _loc8_ == "u" || COLOUR_NAMES.indexOf(_loc8_) != -1)
               {
                  _loc6_.push({
                     "tag":_loc8_,
                     "index":_loc7_
                  });
               }
            }
            _loc7_++;
         }
         return _loc5_.join("");
      }
   }
}

