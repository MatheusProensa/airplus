package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.utils.IMouseCursorControl;
   
   public class AlertDialogCaption implements IMouseCursorControl
   {
      private var _text:String;
      
      private var _toolTip:String;
      
      private var _visible:Boolean;
      
      public function AlertDialogCaption(param1:String, param2:String, param3:Boolean)
      {
         super();
         _text = param1;
         _toolTip = param2;
         _visible = param3;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function get toolTip() : String
      {
         return _toolTip;
      }
      
      public function set toolTip(param1:String) : void
      {
         _toolTip = param1;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _visible = param1;
      }
   }
}

