package com.sulake.habbo.ui.widget.uihelpbubbles
{
   public class HelpBubbleItem
   {
      private var _name:String;
      
      private var _text:String;
      
      private var _icon:String;
      
      private var _modal:Boolean;
      
      public function HelpBubbleItem()
      {
         super();
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get icon() : String
      {
         return _icon;
      }
      
      public function set icon(param1:String) : void
      {
         _icon = param1;
      }
      
      public function get modal() : Boolean
      {
         return _modal;
      }
      
      public function set modal(param1:Boolean) : void
      {
         _modal = param1;
      }
   }
}

