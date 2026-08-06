package com.sulake.habbo.window.utils.tableview
{
   public class TableCell
   {
      public static var UnknownConstFromIlluminaChatBubbleMessage_Int_1:int = 0;
      
      public static var UnknownVarFromTableCell_Int_1:int = 1;
      
      private var _type:int;
      
      private var _contents:Object;
      
      private var _isInspectable:Boolean;
      
      private var _isEditable:Boolean;
      
      private var _textFieldValue:String;
      
      private var _linkClickCallback:Function;
      
      private var _highlightOnChange:Boolean;
      
      private var _tooltipText:String;
      
      private var _textColor:int;
      
      private var _extraBtn:String;
      
      private var _extraBtnCallback:Function;
      
      public function TableCell(param1:int, param2:Object, param3:Boolean = false, param4:Boolean = false, param5:String = null, param6:Function = null, param7:Boolean = false, param8:String = null, param9:uint = 0)
      {
         super();
         _type = param1;
         _contents = param2;
         _isEditable = param3;
         _isInspectable = param4;
         _linkClickCallback = param6;
         if(param5 == null && (param3 || param4))
         {
            param5 = param2 as String;
         }
         _textFieldValue = param5;
         _highlightOnChange = param7;
         _tooltipText = param8;
         _textColor = param9;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get isEditable() : Boolean
      {
         return _isEditable;
      }
      
      public function get contents() : Object
      {
         return _contents;
      }
      
      public function get isInspectable() : Boolean
      {
         return _isInspectable;
      }
      
      public function get textFieldValue() : String
      {
         return _textFieldValue;
      }
      
      public function get linkClickCallback() : Function
      {
         return _linkClickCallback;
      }
      
      public function get highlightOnChange() : Boolean
      {
         return _highlightOnChange;
      }
      
      public function get tooltipText() : String
      {
         return _tooltipText;
      }
      
      public function get textColor() : int
      {
         return _textColor;
      }
      
      public function setExtraBtn(param1:String, param2:Function) : *
      {
         _extraBtn = param1;
         _extraBtnCallback = param2;
      }
      
      public function get extraBtn() : String
      {
         return _extraBtn;
      }
      
      public function get extraBtnCallback() : Function
      {
         return _extraBtnCallback;
      }
   }
}

