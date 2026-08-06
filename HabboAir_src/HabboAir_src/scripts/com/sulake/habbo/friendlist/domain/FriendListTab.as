package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.ITabView;
   
   public class FriendListTab
   {
      private var _id:int;
      
      private var _name:String;
      
      private var _footerName:String;
      
      private var _headerPicName:String;
      
      private var _tabView:ITabView;
      
      private var _newMessageArrived:Boolean;
      
      private var _selected:Boolean;
      
      private var _view:IWindowController_1;
      
      public function FriendListTab(param1:HabboFriendList, param2:int, param3:ITabView, param4:String, param5:String, param6:String)
      {
         super();
         _id = param2;
         _name = param4;
         _tabView = param3;
         _footerName = param5;
         _headerPicName = param6;
         _tabView.init(param1);
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(param1)
         {
            _newMessageArrived = false;
         }
         _selected = param1;
      }
      
      public function setNewMessageArrived(param1:Boolean) : void
      {
         if(selected)
         {
            _newMessageArrived = false;
         }
         else
         {
            _newMessageArrived = param1;
         }
      }
      
      public function get newMessageArrived() : Boolean
      {
         return _newMessageArrived;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get footerName() : String
      {
         return _footerName;
      }
      
      public function get headerPicName() : String
      {
         return _headerPicName;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get tabView() : ITabView
      {
         return _tabView;
      }
      
      public function get view() : IWindowController_1
      {
         return _view;
      }
      
      public function set view(param1:IWindowController_1) : void
      {
         _view = param1;
      }
   }
}

