package com.sulake.habbo.utils
{
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class InfoText
   {
      private var _input:ITextFieldWindow;
      
      private var _includeInfo:Boolean;
      
      private var UnknownVarFromInfoText_String_1:String = "";
      
      public function InfoText(param1:ITextFieldWindow, param2:String = null)
      {
         super();
         _input = param1;
         if(param2 != null)
         {
            _includeInfo = true;
            UnknownVarFromInfoText_String_1 = param2;
            _input.text = param2;
         }
         _input.addEventListener("WE_FOCUSED",onFocus);
      }
      
      public function dispose() : void
      {
         if(_input)
         {
            _input.dispose();
            _input = null;
         }
      }
      
      public function goBackToInitialState() : void
      {
         _input.text = UnknownVarFromInfoText_String_1;
         _includeInfo = true;
      }
      
      public function getText() : String
      {
         return _includeInfo ? "" : _input.text;
      }
      
      public function setText(param1:String) : void
      {
         _includeInfo = false;
         _input.text = param1;
      }
      
      public function get input() : ITextFieldWindow
      {
         return _input;
      }
      
      private function onFocus(param1:WindowEvent) : void
      {
         if(!_includeInfo)
         {
            return;
         }
         _input.text = "";
         _includeInfo = false;
      }
   }
}

