package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class HtmlTextParam extends TextParam
   {
      public static const DEFAULT:HtmlTextParam = new HtmlTextParam(1);
      
      private var _selectable:Boolean;
      
      public function HtmlTextParam(param1:int, param2:Boolean = false, param3:int = 0)
      {
         super(param1,false,param3);
         _selectable = param2;
      }
      
      public function get selectable() : Boolean
      {
         return _selectable;
      }
   }
}

