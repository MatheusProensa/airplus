package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.*;
   
   public class FriendListTabs
   {
      private var UnknownVarFromFriendListTabs_IFriendListTabsDeps_1:IFriendListTabsDeps;
      
      private var _tabs:Array = [];
      
      private var UnknownVarFromFriendListTabs_FriendListTab_1:FriendListTab;
      
      private var _tabContentHeight:int = 200;
      
      private var UnknownVarFromFriendListTabs_Int_1:int = 200;
      
      private var _windowWidth:int = 230;
      
      public function FriendListTabs(param1:IFriendListTabsDeps)
      {
         super();
         UnknownVarFromFriendListTabs_IFriendListTabsDeps_1 = param1;
         _tabs.push(new FriendListTab(UnknownVarFromFriendListTabs_IFriendListTabsDeps_1.getFriendList(),1,new FriendsView(),"${friendlist.friends}","friends_footer","hdr_friends"));
         _tabs.push(new FriendListTab(UnknownVarFromFriendListTabs_IFriendListTabsDeps_1.getFriendList(),2,new FriendRequestsView(),"${friendlist.tab.friendrequests}","friend_requests_footer","hdr_friend_requests"));
         _tabs.push(new FriendListTab(UnknownVarFromFriendListTabs_IFriendListTabsDeps_1.getFriendList(),3,new SearchView(),"${generic.search}","search_footer","hdr_search"));
         toggleSelected(null);
      }
      
      public function getTabs() : Array
      {
         return _tabs;
      }
      
      public function findTab(param1:int) : FriendListTab
      {
         for each(var _loc2_ in _tabs)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function clearSelections() : void
      {
         for each(var _loc1_ in _tabs)
         {
            _loc1_.setSelected(false);
         }
      }
      
      public function findSelectedTab() : FriendListTab
      {
         for each(var _loc1_ in _tabs)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function toggleSelected(param1:FriendListTab) : void
      {
         var _loc2_:FriendListTab = findSelectedTab();
         if(_loc2_ == null)
         {
            _tabContentHeight = UnknownVarFromFriendListTabs_Int_1;
            setSelected(determineDisplayedTab(param1),true);
         }
         else if(_loc2_ == param1 || param1 == null)
         {
            UnknownVarFromFriendListTabs_Int_1 = _tabContentHeight;
            _tabContentHeight = 0;
            clearSelections();
         }
         else
         {
            setSelected(determineDisplayedTab(param1),true);
         }
      }
      
      private function setSelected(param1:FriendListTab, param2:Boolean) : void
      {
         var _loc3_:FriendListTab = findSelectedTab();
         clearSelections();
         param1.setSelected(param2);
         if(param2)
         {
            UnknownVarFromFriendListTabs_FriendListTab_1 = param1;
         }
      }
      
      private function determineDisplayedTab(param1:FriendListTab) : FriendListTab
      {
         if(param1 != null)
         {
            return param1;
         }
         if(UnknownVarFromFriendListTabs_FriendListTab_1 != null)
         {
            return UnknownVarFromFriendListTabs_FriendListTab_1;
         }
         return _tabs[0];
      }
      
      public function get tabContentHeight() : int
      {
         return _tabContentHeight;
      }
      
      public function get windowWidth() : int
      {
         return _windowWidth;
      }
      
      public function get tabContentWidth() : int
      {
         return _windowWidth - 2;
      }
      
      public function set tabContentHeight(param1:int) : void
      {
         _tabContentHeight = param1;
      }
      
      public function set windowWidth(param1:int) : void
      {
         _windowWidth = param1;
      }
   }
}

