package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.IFriendRequestsView;
   
   public class FriendRequestsDeps implements IFriendRequestsDeps_1
   {
      private var _friendList:HabboFriendList;
      
      public function FriendRequestsDeps(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function get view() : IFriendRequestsView
      {
         return _friendList.tabs.findTab(2).tabView as IFriendRequestsView;
      }
   }
}

