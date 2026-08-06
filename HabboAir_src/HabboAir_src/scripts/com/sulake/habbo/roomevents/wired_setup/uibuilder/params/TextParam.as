package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class TextParam
   {
      public static const NO_COLOR_OVERRIDE:uint = 0;
      
      public static const MODE_STRETCH:int = 0;
      
      public static const MODE_MULTILINE:int = 1;
      
      public static const MODE_OVERFLOW:int = 2;
      
      public static const DEFAULT:TextParam = new TextParam(1,false);
      
      private var _mode:int;
      
      private var _bold:Boolean;
      
      private var _maxLines:int;
      
      private var _underline:Boolean;
      
      private var _alignment:String;
      
      private var _fontSize:int = -1;
      
      private var _textColor:uint = 0;
      
      public function TextParam(param1:int, param2:Boolean = false, param3:int = 0, param4:Boolean = false, param5:String = null)
      {
         super();
         _mode = param1;
         _bold = param2;
         _maxLines = param3;
         _underline = param4;
         _alignment = param5;
      }
      
      public function get mode() : int
      {
         return _mode;
      }
      
      public function get bold() : Boolean
      {
         return _bold;
      }
      
      public function get maxLines() : int
      {
         return _maxLines;
      }
      
      public function get underline() : Boolean
      {
         return _underline;
      }
      
      public function get alignment() : String
      {
         return _alignment;
      }
      
      public function get fontSize() : int
      {
         return _fontSize;
      }
      
      public function set fontSize(param1:int) : void
      {
         _fontSize = param1;
      }
      
      public function get textColor() : uint
      {
         return _textColor;
      }
      
      public function set textColor(param1:uint) : void
      {
         _textColor = param1;
      }
   }
}

