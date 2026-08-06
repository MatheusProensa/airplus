package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class ListScrollParams
   {
      private var _alwaysShowScrollbar:Boolean;
      
      private var _minHeight:int;
      
      private var _maxHeight:int;
      
      private var _stickyFooter:Boolean;
      
      private var _stickyHeader:Boolean;
      
      public function ListScrollParams(param1:Boolean, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         _alwaysShowScrollbar = param1;
         _minHeight = param2;
         _maxHeight = param3;
         _stickyFooter = param4;
         _stickyHeader = param5;
      }
      
      public function get alwaysShowScrollbar() : Boolean
      {
         return _alwaysShowScrollbar;
      }
      
      public function get minHeight() : int
      {
         return _minHeight;
      }
      
      public function get maxHeight() : int
      {
         return _maxHeight;
      }
      
      public function get stickyFooter() : Boolean
      {
         return _stickyFooter;
      }
      
      public function get stickyHeader() : Boolean
      {
         return _stickyHeader;
      }
   }
}

