package com.sulake.habbo.navigator
{
   import com.sulake.core.window.components.ITextWindow;
   
   public class CutToWidth implements ICutToHeight
   {
      private var UnknownVarFromCutToWidth_String_1:String;
      
      private var _text:ITextWindow;
      
      private var _maxWidth:int;
      
      public function CutToWidth()
      {
         super();
      }
      
      public function test(param1:int) : Boolean
      {
         _text.text = UnknownVarFromCutToWidth_String_1.substring(0,param1) + "...";
         return _text.textWidth > _maxWidth;
      }
      
      public function beforeSearch(param1:String, param2:ITextWindow, param3:int) : void
      {
         UnknownVarFromCutToWidth_String_1 = param1;
         _text = param2;
         _maxWidth = param3;
      }
   }
}

