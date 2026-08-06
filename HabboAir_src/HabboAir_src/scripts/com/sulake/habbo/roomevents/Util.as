package com.sulake.habbo.roomevents
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.components.UnknownICoreWindowComponents7;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils5;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.room.utils.ColorConverter;
   
   public class Util
   {
      public static const VARIABLE_SYNTAX_MODE_PRETTIFY:int = 0;
      
      public static const VARIABLE_SYNTAX_MODE_NONE:int = 1;
      
      public function Util()
      {
         super();
      }
      
      public static function setProcDirectly(param1:IWindowModel, param2:Function) : void
      {
         param1.setParamFlag(1,true);
         param1.procedure = param2;
      }
      
      public static function getLowestPoint(param1:IWindowController_1) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindowModel = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible && _loc4_.height > 0)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function getLowestPointList(param1:IItemListWindow) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindowModel = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numListItems)
         {
            _loc4_ = param1.getListItemAt(_loc2_);
            if(_loc4_.visible && _loc4_.height > 0)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function hideChildren(param1:IWindowController_1, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IWindowModel = null;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(!(param2 && _loc4_.name == "ruler"))
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
      }
      
      public static function showChildren(param1:IWindowController_1) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = true;
            _loc2_++;
         }
      }
      
      public static function moveChildrenToColumn(param1:IWindowController_1, param2:Array, param3:int, param4:int) : void
      {
         var _loc6_:IWindowModel = null;
         for each(var _loc5_ in param2)
         {
            _loc6_ = param1.getChildByName(_loc5_);
            if(_loc6_ != null && _loc6_.visible && _loc6_.height > 0)
            {
               _loc6_.y = param3;
               param3 += _loc6_.height + param4;
            }
         }
      }
      
      public static function moveAllChildrenToColumn(param1:IWindowController_1, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IWindowModel = null;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_);
            if(_loc5_ != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public static function select(param1:UnknownICoreWindowComponents2, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      public static function flatVariableName(param1:WiredVariable) : String
      {
         return param1.variableName.replace("@","").replace("~","").replace(/\./g,"_");
      }
      
      public static function splitName(param1:WiredVariable) : Array
      {
         var _loc3_:Array = param1.variableName.split(".");
         var _loc2_:Array = [];
         for each(var _loc4_ in _loc3_)
         {
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function variableValueWithString(param1:WiredVariable, param2:int) : String
      {
         if(!param1.hasValue)
         {
            return null;
         }
         var _loc4_:Boolean = param2 == 2147483647 || param2 == -2147483648;
         if(_loc4_)
         {
            return "Hidden";
         }
         var _loc3_:String = getConnectedText(param1,param2);
         return String(param2) + (_loc3_ == null ? "" : " (" + _loc3_ + ")");
      }
      
      public static function getConnectedText(param1:WiredVariable, param2:int) : String
      {
         var _loc3_:Map = param1.textConnector;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getValue(param2);
      }
      
      public static function getIntFromInput(param1:ITextFieldWindow, param2:int, param3:Boolean = false) : int
      {
         return getIntFromString(param1.text,param2,param3);
      }
      
      public static function getIntFromString(param1:String, param2:int, param3:Boolean = false) : int
      {
         if(param3 && param1.indexOf("0b") == 0)
         {
            return parseInt(param1.substr(2),2);
         }
         if(param3 && param1.indexOf("0x") == 0)
         {
            return parseInt(param1.substr(2),16);
         }
         if(isNaN(Number(param1)))
         {
            return param2;
         }
         return int(param1);
      }
      
      public static function pushIntAsLong(param1:Array, param2:int) : void
      {
         param1.push(param2 < 0 ? -1 : 0);
         param1.push(param2);
      }
      
      private static function getBlend(param1:IWindowModel) : Number
      {
         if(param1 is UnknownICoreWindowComponents7)
         {
            return (param1.color >>> 24 & 0xFF) / 255;
         }
         return param1.blend;
      }
      
      private static function setBlend(param1:IWindowModel, param2:Number) : void
      {
         var _loc3_:* = 0;
         if(param1 is UnknownICoreWindowComponents7)
         {
            _loc3_ = Math.max(0,Math.min(255,int(param2 * 255)));
            param1.color = param1.color & 0xFFFFFF | _loc3_ << 24;
         }
         else
         {
            param1.blend = param2;
         }
      }
      
      public static function disableSection(param1:IWindowModel, param2:Boolean = true) : void
      {
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc4_:IWindowController_1 = null;
         var _loc6_:int = 0;
         if(param1.tags.indexOf("DO_NOT_DISABLE") != -1)
         {
            return;
         }
         var _loc3_:Number = -1;
         if(param1.isEnabled() && param2)
         {
            _loc3_ = getBlend(param1);
            _loc7_ = "BLEND=" + _loc3_;
            if(param1.tags.indexOf(_loc7_) == -1)
            {
               param1.tags.push(_loc7_);
            }
         }
         else if(!param1.isEnabled() && !param2)
         {
            for each(_loc7_ in param1.tags)
            {
               if(_loc7_.indexOf("BLEND=") == 0)
               {
                  _loc3_ = Number(_loc7_.substring(6,_loc7_.length));
               }
            }
         }
         if(_loc3_ == -1)
         {
            _loc8_ = getBlend(param1);
         }
         else
         {
            _loc8_ = param2 ? _loc3_ / 2 : _loc3_;
         }
         var _loc5_:* = param1.tags.indexOf("#icon") != -1;
         if(!(param1 is UnknownICoreWindowComponents4))
         {
            if(param1 is IWindowController_1 || param1 is IItemListWindow || param1 is ISelectorWindow)
            {
               if(param1 is UnknownICoreWindowUtils5)
               {
                  for each(var _loc9_ in (param1 as UnknownICoreWindowUtils5).children)
                  {
                     disableSection(_loc9_,param2);
                  }
               }
               else if(param1 is IWindowController_1)
               {
                  _loc4_ = param1 as IWindowController_1;
                  _loc6_ = 0;
                  while(_loc6_ < _loc4_.numChildren)
                  {
                     disableSection(_loc4_.getChildAt(_loc6_),param2);
                     _loc6_++;
                  }
               }
               if(param1 is UnknownICoreWindowComponents6 || param1 is UnknownICoreWindowComponents7)
               {
                  setBlend(param1,_loc8_);
               }
            }
            else if(!_loc5_)
            {
               setBlend(param1,_loc8_);
            }
         }
         if(param2)
         {
            param1.disable();
         }
         else
         {
            param1.enable();
         }
      }
      
      private static function variableCompare(param1:WiredVariable, param2:WiredVariable) : int
      {
         var _loc4_:* = param1.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.INTERNAL;
         var _loc3_:* = param2.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.INTERNAL;
         if(_loc4_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc4_)
         {
            return -1;
         }
         if(_loc4_)
         {
            if(Number(param1.variableId) > Number(param2.variableId))
            {
               return -1;
            }
            if(Number(param1.variableId) == Number(param2.variableId))
            {
               return 0;
            }
            return 1;
         }
         return param1.variableName.localeCompare(param2.variableName);
      }
      
      public static function sortVariables(param1:*) : void
      {
         param1.sort(variableCompare);
      }
      
      public static function compareIntArrays(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(param1.length != param2.length)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != param2[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function findVariableById(param1:Array, param2:String) : WiredVariable
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.variableId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function uintToHexColor(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "#" + _loc2_;
      }
      
      public static function snakeToTitle(param1:String) : String
      {
         var text:String = param1;
         if(!text)
         {
            return "";
         }
         text = text.toLowerCase().replace(/_/g," ");
         return text.replace(/\b\w/g,function():String
         {
            return arguments[0].toUpperCase();
         });
      }
      
      public static function lightenColor(param1:uint, param2:Number) : uint
      {
         var _loc3_:uint = ColorConverter.rgbToHSL(param1);
         var _loc4_:uint = uint(_loc3_ & 0xFF);
         _loc4_ = Math.min(255,_loc4_ * param2);
         _loc3_ = uint(_loc3_ & -256 | _loc4_);
         return ColorConverter.hslToRGB(_loc3_);
      }
   }
}

