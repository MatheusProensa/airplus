package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.components.UnknownICoreWindowComponents7;
   
   public class WindowUtils
   {
      public function WindowUtils()
      {
         super();
      }
      
      public static function disableButton(param1:IWindowModel, param2:Boolean) : void
      {
         if(param2)
         {
            param1.disable();
         }
         else
         {
            param1.enable();
         }
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
      
      public static function disableSection(param1:IWindowModel, param2:Boolean = true, param3:Number = 0.5) : void
      {
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc5_:IWindowController_1 = null;
         var _loc7_:int = 0;
         if(param1.tags.indexOf("DO_NOT_DISABLE") != -1)
         {
            return;
         }
         var _loc4_:Number = -1;
         for each(_loc9_ in param1.tags)
         {
            if(_loc9_.indexOf("BLEND=") == 0)
            {
               _loc4_ = Number(_loc9_.substring(6,_loc9_.length));
            }
         }
         if(_loc4_ == -1)
         {
            _loc4_ = getBlend(param1);
            _loc9_ = "BLEND=" + _loc4_;
            if(param1.tags.indexOf(_loc9_) == -1)
            {
               param1.tags.push(_loc9_);
            }
         }
         if(param2 && param1.tags.indexOf("INVIS_ON_DISABLE") != -1)
         {
            _loc10_ = 0;
         }
         else
         {
            _loc10_ = param2 ? _loc4_ * param3 : _loc4_;
         }
         var _loc6_:* = param1.tags.indexOf("#icon") != -1;
         var _loc8_:* = !param1.getParamFlag(16);
         if(!(param1 is UnknownICoreWindowComponents4))
         {
            if(param1 is IWindowController_1 || param1 is IItemListWindow || param1 is ISelectorWindow)
            {
               if(param1 is UnknownICoreWindowUtils5)
               {
                  for each(var _loc11_ in (param1 as UnknownICoreWindowUtils5).children)
                  {
                     disableSection(_loc11_,param2,_loc8_ ? 1 : param3);
                  }
               }
               else if(param1 is IWindowController_1)
               {
                  _loc5_ = param1 as IWindowController_1;
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_.numChildren)
                  {
                     disableSection(_loc5_.getChildAt(_loc7_),param2,_loc8_ ? 1 : param3);
                     _loc7_++;
                  }
               }
               if(param1 is UnknownICoreWindowComponents6 || param1 is UnknownICoreWindowComponents7 || _loc8_)
               {
                  setBlend(param1,_loc10_);
               }
            }
            else if(!_loc6_)
            {
               setBlend(param1,_loc10_);
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
   }
}

