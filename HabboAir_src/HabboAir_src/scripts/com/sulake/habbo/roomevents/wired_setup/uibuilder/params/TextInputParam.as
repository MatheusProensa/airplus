package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class TextInputParam
   {
      public static var DEFAULT:TextInputParam = new TextInputParam();
      
      private var _initialText:String;
      
      private var _maxCharacters:int;
      
      private var _placeholder:String;
      
      private var _width:int;
      
      private var _restrict:String;
      
      private var _editable:Boolean;
      
      private var _tooltip:String;
      
      public function TextInputParam(param1:String = "", param2:int = 1000, param3:String = null, param4:int = -1, param5:String = null, param6:Boolean = true, param7:String = null)
      {
         super();
         _initialText = param1;
         _maxCharacters = param2;
         _placeholder = param3;
         _width = param4;
         _restrict = param5;
         _editable = param6;
         _tooltip = param7;
      }
      
      public function get initialText() : String
      {
         return _initialText;
      }
      
      public function get maxCharacters() : int
      {
         return _maxCharacters;
      }
      
      public function get placeholder() : String
      {
         return _placeholder;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get restrict() : String
      {
         return _restrict;
      }
      
      public function get editable() : Boolean
      {
         return _editable;
      }
      
      public function get tooltip() : String
      {
         return _tooltip;
      }
   }
}

