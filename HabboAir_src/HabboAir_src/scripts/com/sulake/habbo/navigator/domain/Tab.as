package com.sulake.habbo.navigator.domain
{
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;
   
   public class Tab
   {
      private var _navigator:HabboNavigator;
      
      private var _id:int;
      
      private var _defaultSearchType:int;
      
      private var _button:ITabButtonWindow;
      
      private var _tabPageDecorator:ITabPageDecorator;
      
      private var _selected:Boolean;
      
      private var _searchMsg:int;
      
      public function Tab(param1:HabboNavigator, param2:int, param3:int, param4:ITabPageDecorator, param5:int = 1)
      {
         super();
         _navigator = param1;
         _id = param2;
         _defaultSearchType = param3;
         _tabPageDecorator = param4;
         _searchMsg = param5;
      }
      
      public function sendSearchRequest() : void
      {
         var _loc1_:Boolean = _navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator");
         if(_loc1_ && id == 2)
         {
            _defaultSearchType = 22;
         }
         _navigator.mainViewCtrl.startSearch(_id,_defaultSearchType,"-1",_searchMsg);
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get defaultSearchType() : int
      {
         return _defaultSearchType;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get tabPageDecorator() : ITabPageDecorator
      {
         return _tabPageDecorator;
      }
      
      public function get searchMsg() : int
      {
         return _searchMsg;
      }
      
      public function get button() : ITabButtonWindow
      {
         return _button;
      }
      
      public function set button(param1:ITabButtonWindow) : void
      {
         _button = param1;
      }
   }
}

