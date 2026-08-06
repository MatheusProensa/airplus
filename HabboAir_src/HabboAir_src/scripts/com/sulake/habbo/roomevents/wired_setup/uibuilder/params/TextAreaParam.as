package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class TextAreaParam
   {
      private var _height:int;
      
      private var _width:int;
      
      private var _maxLines:int;
      
      private var _maxCharactersPerLine:int;
      
      private var _maxCharacters:int;
      
      private var _initialText:String;
      
      private var _placeholder:String;
      
      private var _restrict:String;
      
      private var _editable:Boolean;
      
      private var _wordwrap:Boolean;
      
      private var _tooltip:String;
      
      public function TextAreaParam(param1:int, param2:int = -1, param3:int = -1, param4:int = -1, param5:int = 1000, param6:String = "", param7:String = null, param8:String = null, param9:Boolean = true, param10:Boolean = false, param11:String = null)
      {
         super();
         _height = param1;
         _width = param2;
         _maxLines = param3;
         _maxCharactersPerLine = param4;
         _maxCharacters = param5;
         _initialText = param6;
         _placeholder = param7;
         _restrict = param8;
         _editable = param9;
         _wordwrap = param10;
         _tooltip = param11;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get maxLines() : int
      {
         return _maxLines;
      }
      
      public function get maxCharactersPerLine() : int
      {
         return _maxCharactersPerLine;
      }
      
      public function get maxCharacters() : int
      {
         return _maxCharacters;
      }
      
      public function get initialText() : String
      {
         return _initialText;
      }
      
      public function get placeholder() : String
      {
         return _placeholder;
      }
      
      public function get editable() : Boolean
      {
         return _editable;
      }
      
      public function get restrict() : String
      {
         return _restrict;
      }
      
      public function get wordwrap() : Boolean
      {
         return _wordwrap;
      }
      
      public function get tooltip() : String
      {
         return _tooltip;
      }
   }
}

