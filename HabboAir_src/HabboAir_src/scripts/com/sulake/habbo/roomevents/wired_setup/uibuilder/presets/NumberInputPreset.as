package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NumberInputPreset extends WiredUIPreset
   {
      private var _window:IWindowModel;
      
      private var UnknownVarFromNumberInputPreset_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromNumberInputPreset_NumberInputParam_1:NumberInputParam;
      
      private var UnknownVarFromNumberInputPreset_Int_1:int;
      
      private var _value:int;
      
      private var _latestValidValueStr:String;
      
      private var _min:int;
      
      private var UnknownVarFromNumberInputPreset_Int_2:int;
      
      private var UnknownVarFromNumberInputPreset_Int_3:int;
      
      private var UnknownVarFromNumberInputPreset_Boolean_1:Boolean;
      
      private var UnknownVarFromNumberInputPreset_Int_4:int;
      
      private var UnknownVarFromNumberInputPreset_Function_1:Function;
      
      private var _ignoreListeners:Boolean = false;
      
      public function NumberInputPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:NumberInputParam)
      {
         super(param1,param2,param3);
         _window = param3.createTextInputView();
         UnknownVarFromNumberInputPreset_ITextFieldWindow_1 = _window.findChildByName("field") as ITextFieldWindow;
         UnknownVarFromNumberInputPreset_NumberInputParam_1 = param4;
         UnknownVarFromNumberInputPreset_Int_4 = _window.width - UnknownVarFromNumberInputPreset_ITextFieldWindow_1.width;
         if(param4.width >= 0)
         {
            _window.width = param4.width + UnknownVarFromNumberInputPreset_Int_4;
         }
         UnknownVarFromNumberInputPreset_ITextFieldWindow_1.restrict = "0123456789" + (param4.min < 0 ? "\\-" : "") + (param4.precision > 0 ? ",." : "") + (param4.nonDecimalNotations ? "xba-fA-F" : "");
         UnknownVarFromNumberInputPreset_Boolean_1 = param4.endsWithFive;
         _min = UnknownVarFromNumberInputPreset_Boolean_1 ? param4.min * 5 : param4.min;
         UnknownVarFromNumberInputPreset_Int_2 = UnknownVarFromNumberInputPreset_Boolean_1 ? param4.max * 5 : param4.max;
         UnknownVarFromNumberInputPreset_Int_3 = param4.precision;
         if(param4.tooltip != null)
         {
            UnknownVarFromNumberInputPreset_ITextFieldWindow_1.toolTipCaption = param4.tooltip;
         }
         setValue(param4.initialValue);
         UnknownVarFromNumberInputPreset_ITextFieldWindow_1.addEventListener("WE_CHANGE",onTextChange);
      }
      
      private static function swapChars(param1:String, param2:int, param3:int) : String
      {
         var _loc5_:Array = param1.split("");
         var _loc4_:String = _loc5_[param2];
         _loc5_[param2] = _loc5_[param3];
         _loc5_[param3] = _loc4_;
         return _loc5_.join("");
      }
      
      private static function isValidInt(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^-?\d+$/;
         return _loc2_.test(param1);
      }
      
      public function set onValueChange(param1:Function) : void
      {
         UnknownVarFromNumberInputPreset_Function_1 = param1;
      }
      
      private function displayValue(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = param1.toString();
         if(UnknownVarFromNumberInputPreset_Int_3 > 0)
         {
            while(_loc2_.length < UnknownVarFromNumberInputPreset_Int_3 + 1)
            {
               _loc2_ = "0" + _loc2_;
            }
            _loc2_ = _loc2_.substring(0,_loc2_.length - UnknownVarFromNumberInputPreset_Int_3) + "." + _loc2_.substring(_loc2_.length - UnknownVarFromNumberInputPreset_Int_3);
            while(_loc2_.charAt(_loc2_.length - 1) == "0")
            {
               _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
            }
            if(_loc2_.charAt(_loc2_.length - 1) == ".")
            {
               _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
            }
         }
         if(UnknownVarFromNumberInputPreset_Int_3 < 0)
         {
            _loc3_ = 0;
            while(_loc3_ > UnknownVarFromNumberInputPreset_Int_3)
            {
               _loc2_ += "0";
               _loc3_ -= 1;
            }
         }
         return _loc2_;
      }
      
      private function setValue(param1:int) : void
      {
         _ignoreListeners = true;
         UnknownVarFromNumberInputPreset_Int_1 = param1;
         _value = param1;
         _latestValidValueStr = displayValue(UnknownVarFromNumberInputPreset_Boolean_1 ? param1 * 5 : param1);
         UnknownVarFromNumberInputPreset_ITextFieldWindow_1.text = _latestValidValueStr;
         _ignoreListeners = false;
      }
      
      public function set value(param1:int) : void
      {
         setValue(param1);
      }
      
      public function reset() : void
      {
         setValue(UnknownVarFromNumberInputPreset_NumberInputParam_1.initialValue);
      }
      
      private function onTextChange(param1:WindowEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:RegExp = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc5_ = 0;
         if(_ignoreListeners)
         {
            return;
         }
         var _loc8_:String = UnknownVarFromNumberInputPreset_ITextFieldWindow_1.text;
         if(_loc8_ == "" || _loc8_ == "-" && UnknownVarFromNumberInputPreset_NumberInputParam_1.min < 0)
         {
            return;
         }
         var _loc3_:String = _loc8_.charAt(_loc8_.length - 1);
         if(UnknownVarFromNumberInputPreset_Int_3 == 0 && UnknownVarFromNumberInputPreset_Boolean_1 && _loc3_ != "0" && _loc3_ != "5")
         {
            return;
         }
         if(UnknownVarFromNumberInputPreset_Int_3 < 0 && _loc3_ == "0")
         {
            return;
         }
         if(UnknownVarFromNumberInputPreset_NumberInputParam_1.nonDecimalNotations && (_loc8_.indexOf("0b") == 0 || _loc8_.indexOf("0x") == 0))
         {
            _loc2_ = _loc8_.indexOf("0b") == 0 ? parseInt(_loc8_.substr(2),2) : parseInt(_loc8_.substr(2),16);
            setValidValueAndNotify(_loc2_ < _min ? _min : (_loc2_ > UnknownVarFromNumberInputPreset_Int_2 ? UnknownVarFromNumberInputPreset_Int_2 : _loc2_));
            return;
         }
         var _loc9_:String = _loc8_.replace(",",".");
         if(UnknownVarFromNumberInputPreset_Int_3 > 0)
         {
            if(_loc9_.charAt(_loc9_.length - 1) == ".")
            {
               _loc9_ = _loc9_.substring(0,_loc9_.length - 1);
            }
            _loc4_ = /^-?([0-9]*[.])?[0-9]+$/;
            if(!_loc4_.test(_loc9_))
            {
               _ignoreListeners = true;
               UnknownVarFromNumberInputPreset_ITextFieldWindow_1.text = _latestValidValueStr;
               _ignoreListeners = false;
               return;
            }
            _loc5_ = 0;
            while(_loc5_ < UnknownVarFromNumberInputPreset_Int_3)
            {
               _loc6_ = int(_loc9_.indexOf("."));
               if(_loc6_ == -1)
               {
                  _loc9_ += "0";
               }
               else
               {
                  _loc9_ = swapChars(_loc9_,_loc6_,_loc6_ + 1);
                  if(_loc9_.charAt(_loc9_.length - 1) == ".")
                  {
                     _loc9_ = _loc9_.substring(0,_loc9_.length - 1);
                  }
               }
               _loc5_++;
            }
         }
         else if(UnknownVarFromNumberInputPreset_Int_3 < 0)
         {
            _loc5_ = 0;
            while(_loc5_ > UnknownVarFromNumberInputPreset_Int_3)
            {
               if(_loc9_ == "0" || _loc9_ == "-0" || _loc9_ == "")
               {
                  break;
               }
               if(_loc9_.charAt(_loc9_.length - 1) == "0")
               {
                  _loc9_ = _loc9_.substring(0,_loc9_.length - 1);
               }
               else
               {
                  _ignoreListeners = true;
                  UnknownVarFromNumberInputPreset_ITextFieldWindow_1.text = _latestValidValueStr;
                  _ignoreListeners = false;
               }
               _loc5_ -= 1;
            }
         }
         var _loc7_:ITextFieldWindow = UnknownVarFromNumberInputPreset_ITextFieldWindow_1;
         if(UnknownVarFromNumberInputPreset_Boolean_1 && _loc9_.charAt(_loc9_.length - 1) != "0" && _loc9_.charAt(_loc9_.length - 1) != "5")
         {
            _loc7_.text = _latestValidValueStr;
            return;
         }
         _loc2_ = int(_loc9_);
         if(!isNaN(_loc2_) && isValidInt(_loc9_))
         {
            if(String(_loc2_).length <= String(UnknownVarFromNumberInputPreset_NumberInputParam_1.min).length && _loc2_ < UnknownVarFromNumberInputPreset_NumberInputParam_1.min && String(UnknownVarFromNumberInputPreset_NumberInputParam_1.max).length > String(UnknownVarFromNumberInputPreset_NumberInputParam_1.min).length)
            {
               return;
            }
            if(_loc2_ >= _min && _loc2_ <= UnknownVarFromNumberInputPreset_Int_2)
            {
               _latestValidValueStr = _loc7_.text;
            }
            else if(_loc2_ < _min)
            {
               _loc2_ = _min;
               _latestValidValueStr = displayValue(_min);
               _loc7_.text = _latestValidValueStr;
            }
            else
            {
               _loc2_ = UnknownVarFromNumberInputPreset_Int_2;
               _latestValidValueStr = displayValue(UnknownVarFromNumberInputPreset_Int_2);
               _loc7_.text = _latestValidValueStr;
            }
            setValidValueAndNotify(UnknownVarFromNumberInputPreset_Boolean_1 ? _loc2_ / 5 : _loc2_);
         }
         else
         {
            _loc7_.text = _latestValidValueStr;
         }
      }
      
      private function setValidValueAndNotify(param1:int) : void
      {
         _value = param1;
         if(UnknownVarFromNumberInputPreset_Function_1 != null)
         {
            UnknownVarFromNumberInputPreset_Function_1(param1);
         }
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get number() : Number
      {
         return Number(_latestValidValueStr);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return UnknownVarFromNumberInputPreset_NumberInputParam_1.width >= 0;
      }
      
      override public function get staticWidth() : int
      {
         if(UnknownVarFromNumberInputPreset_NumberInputParam_1.width >= 0)
         {
            return UnknownVarFromNumberInputPreset_NumberInputParam_1.width + UnknownVarFromNumberInputPreset_Int_4;
         }
         throw new Exception("Number input with -1 width has no static width");
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var _loc2_:int = int(UnknownVarFromNumberInputPreset_NumberInputParam_1.width >= 0 ? UnknownVarFromNumberInputPreset_NumberInputParam_1.width + UnknownVarFromNumberInputPreset_Int_4 : param1);
         _window.width = _loc2_;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _window.dispose();
         _window = null;
         UnknownVarFromNumberInputPreset_NumberInputParam_1 = null;
      }
   }
}

