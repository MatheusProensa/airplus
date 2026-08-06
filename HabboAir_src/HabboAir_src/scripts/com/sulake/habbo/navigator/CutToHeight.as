package com.sulake.habbo.navigator
{
   import com.sulake.core.window.components.ITextWindow;
   
   public class CutToHeight implements ICutToHeight
   {
      private var UnknownVarFromCutToHeight_String_1:String;
      
      private var _text:ITextWindow;
      
      private var UnknownVarFromCutToHeight_Int_1:int;
      
      public function CutToHeight()
      {
         super();
      }
      
      public function test(param1:int) : Boolean
      {
         _text.text = UnknownVarFromCutToHeight_String_1.substring(0,param1) + "...";
         return _text.textHeight > UnknownVarFromCutToHeight_Int_1;
      }
      
      public function beforeSearch(param1:String, param2:ITextWindow, param3:int) : void
      {
         UnknownVarFromCutToHeight_String_1 = param1;
         _text = param2;
         UnknownVarFromCutToHeight_Int_1 = param3;
      }
   }
}

