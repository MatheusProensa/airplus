package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import flash.geom.Point;
   
   public class TextFieldManager
   {
      private var _navigator:IHabboNavigator_2;
      
      private var _input:ITextFieldWindow;
      
      private var _includeInfo:Boolean;
      
      private var UnknownVarFromTextFieldManager_String_1:String = "";
      
      private var _maxTextLen:int;
      
      private var UnknownVarFromTextFieldManager_Function_1:Function;
      
      private var UnknownVarFromTextFieldManager_String_2:String = "";
      
      private var _errorPopup:IWindowController_1;
      
      private var UnknownVarFromTextFieldManager_Boolean_1:Boolean;
      
      private var _orgTextBackgroundColor:uint;
      
      public function TextFieldManager(param1:IHabboNavigator_2, param2:ITextFieldWindow, param3:int = 1000, param4:Function = null, param5:String = null)
      {
         super();
         _navigator = param1;
         _input = param2;
         _maxTextLen = param3;
         param2.maxChars = param3;
         UnknownVarFromTextFieldManager_Function_1 = param4;
         if(param5 != null)
         {
            _includeInfo = true;
            UnknownVarFromTextFieldManager_String_1 = param5;
            _input.text = param5;
         }
         Util.setProcDirectly(_input,onInputClick);
         _input.addEventListener("WKE_KEY_DOWN",checkEnterPress);
         _input.addEventListener("WE_CHANGE",checkMaxLen);
         this.UnknownVarFromTextFieldManager_Boolean_1 = _input.textBackground;
         this._orgTextBackgroundColor = _input.textBackgroundColor;
      }
      
      public function dispose() : void
      {
         if(_input)
         {
            _input.dispose();
            _input = null;
         }
         if(_errorPopup)
         {
            _errorPopup.dispose();
            _errorPopup = null;
         }
         _navigator = null;
      }
      
      public function checkMandatory(param1:String) : Boolean
      {
         if(!isInputValid())
         {
            displayError(param1);
            return false;
         }
         restoreBackground();
         return true;
      }
      
      public function restoreBackground() : void
      {
         _input.textBackground = this.UnknownVarFromTextFieldManager_Boolean_1;
         _input.textBackgroundColor = this._orgTextBackgroundColor;
      }
      
      public function displayError(param1:String) : void
      {
         _input.textBackground = true;
         _input.textBackgroundColor = 4294021019;
         if(this._errorPopup == null)
         {
            this._errorPopup = IWindowController_1(_navigator.getXmlWindow("nav_error_popup"));
            _navigator.refreshButton(this._errorPopup,"popup_arrow_down",true,null,0);
            IWindowController_1(_input.parent).addChild(this._errorPopup);
         }
         var _loc4_:ITextWindow = ITextWindow(this._errorPopup.findChildByName("error_text"));
         _loc4_.text = param1;
         _loc4_.width = _loc4_.textWidth + 5;
         _errorPopup.findChildByName("border").width = _loc4_.width + 15;
         _errorPopup.width = _loc4_.width + 15;
         var _loc2_:Point = new Point();
         _input.getLocalPosition(_loc2_);
         this._errorPopup.x = _loc2_.x;
         this._errorPopup.y = _loc2_.y - this._errorPopup.height + 3;
         var _loc3_:IWindowModel = _errorPopup.findChildByName("popup_arrow_down");
         _loc3_.x = this._errorPopup.width / 2 - _loc3_.width / 2;
         _errorPopup.x += (_input.width - _errorPopup.width) / 2;
         this._errorPopup.visible = true;
      }
      
      public function goBackToInitialState() : void
      {
         clearErrors();
         if(UnknownVarFromTextFieldManager_String_1 != null)
         {
            _input.text = UnknownVarFromTextFieldManager_String_1;
            _includeInfo = true;
         }
         else
         {
            _input.text = "";
            _includeInfo = false;
         }
      }
      
      public function getText() : String
      {
         if(_includeInfo)
         {
            return UnknownVarFromTextFieldManager_String_2;
         }
         return _input.text;
      }
      
      public function setText(param1:String) : void
      {
         _includeInfo = false;
         _input.text = param1;
      }
      
      public function clearErrors() : void
      {
         this.restoreBackground();
         if(this._errorPopup != null)
         {
            _errorPopup.visible = false;
         }
      }
      
      public function get input() : ITextFieldWindow
      {
         return _input;
      }
      
      private function isInputValid() : Boolean
      {
         return !_includeInfo && Util.trim(getText()).length > 2;
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(!_includeInfo)
         {
            return;
         }
         _input.text = UnknownVarFromTextFieldManager_String_2;
         _includeInfo = false;
         this.restoreBackground();
      }
      
      private function checkEnterPress(param1:WindowKeyboardEvent) : void
      {
         if(param1.charCode == 13)
         {
            if(UnknownVarFromTextFieldManager_Function_1 != null)
            {
               UnknownVarFromTextFieldManager_Function_1();
            }
         }
      }
      
      private function checkMaxLen(param1:WindowEvent) : void
      {
         var _loc2_:String = _input.text;
         if(_loc2_.length > _maxTextLen)
         {
            _input.text = _loc2_.substring(0,_maxTextLen);
         }
      }
   }
}

