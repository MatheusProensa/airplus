package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.communication.messages.incoming.friendlist.*;
   import com.sulake.habbo.communication.messages.parser.friendlist.*;
   import com.sulake.habbo.friendlist.IFriendsView;
   import com.sulake.habbo.friendlist.Util;
   import flash.utils.Dictionary;
   
   public class FriendCategories
   {
      private static const STOP_SORTING_FRIENDLIST:int = 200;
      
      private var _deps:IFriendCategoriesDeps;
      
      private var _categories:Array = [];
      
      private var _allFriends:Dictionary = new Dictionary();
      
      public function FriendCategories(param1:IFriendCategoriesDeps)
      {
         super();
         _deps = param1;
      }
      
      public function addFriend(param1:Friend) : FriendCategory
      {
         var _loc2_:int = param1.online ? param1.categoryId : -1;
         var _loc3_:FriendCategory = findCategory(_loc2_);
         if(_loc3_ != null)
         {
            _loc3_.addFriend(param1);
            _allFriends[param1.id] = param1;
            return _loc3_;
         }
         Logger.log("No category " + _loc2_ + " found for friend " + param1.id + ". Ignoring");
         return null;
      }
      
      public function sort(param1:Boolean = false) : void
      {
         for each(var _loc2_ in _categories)
         {
            if(!param1 || _loc2_.friends.length < 200)
            {
               _loc2_.sort();
            }
         }
      }
      
      public function getSelectedFriends() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in _categories)
         {
            _loc2_.getSelectedFriends(_loc1_);
         }
         return _loc1_;
      }
      
      public function getSelectedFriend() : Friend
      {
         var _loc1_:Array = getSelectedFriends();
         return _loc1_.length == 1 ? _loc1_[0] : null;
      }
      
      public function getAllFriends() : Dictionary
      {
         return _allFriends;
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean = false) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_ in _categories)
         {
            _loc3_ += _loc4_.getFriendCount(param1,param2);
         }
         return _loc3_;
      }
      
      public function getCategories() : Array
      {
         return _categories;
      }
      
      public function addCategory(param1:FriendCategory) : void
      {
         _categories.push(param1);
      }
      
      public function findFriend(param1:int) : Friend
      {
         return _allFriends[param1];
      }
      
      public function findCategory(param1:int) : FriendCategory
      {
         for each(var _loc2_ in _categories)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc5_:Friend = null;
         var _loc8_:Boolean = false;
         var _loc3_:Friend = null;
         var _loc2_:FriendListUpdateMessageParser = (param1 as FriendListUpdateEvent).getParser();
         updateCategories(_loc2_.cats);
         for each(var _loc4_ in _loc2_.removedFriendIds)
         {
            removeFriend(_loc4_,true);
         }
         for each(var _loc7_ in _loc2_.updatedFriends)
         {
            Logger.log("Got UPDATE: " + _loc7_.id + ", " + _loc7_.online + ", " + _loc7_.name + ", " + _loc7_.followingAllowed);
            _deps.messenger.setFollowingAllowed(_loc7_.id,_loc7_.followingAllowed && _loc7_.online);
            _loc8_ = isFriendOnline(_loc7_.id);
            if(_loc8_ && !_loc7_.online)
            {
               _deps.messenger.setOnlineStatus(_loc7_.id,_loc7_.online);
            }
            if(!_loc8_ && _loc7_.online)
            {
               _deps.messenger.setOnlineStatus(_loc7_.id,_loc7_.online);
               _deps.view.setNewMessageArrived();
            }
            _loc3_ = removeFriend(_loc7_.id,true);
            _loc5_ = new Friend(_loc7_);
            _loc5_.selected = _loc3_?.selected;
            addFriend(_loc5_);
            if(_loc3_ != null && !_loc3_.online && _loc5_.online)
            {
               notifyFriendOnline(_loc5_);
            }
         }
         for each(var _loc6_ in _loc2_.addedFriends)
         {
            _loc5_ = new Friend(_loc6_);
            Logger.log("Got INSERT: " + _loc6_.id + ", " + _loc6_.name);
            removeFriend(_loc6_.id,true);
            addFriend(_loc5_);
         }
         sort(true);
         this._deps.view.refreshList();
      }
      
      internal function notifyFriendOnline(param1:Friend, param2:IAvatarImage_2 = null) : void
      {
         _deps.notifications.windowManager.LilithCustomsInstance.OnFriendConnected(param1);
      }
      
      private function updateCategories(param1:Array) : void
      {
         var _loc3_:FriendCategory = null;
         flushReceivedStatus();
         findCategory(-1).received = true;
         findCategory(0).received = true;
         for each(var _loc4_ in param1)
         {
            _loc3_ = findCategory(_loc4_.id);
            if(_loc3_ != null)
            {
               _loc3_.received = true;
               if(_loc3_.name != _loc4_.name)
               {
                  _loc3_.name = _loc4_.name;
               }
            }
         }
         for each(var _loc2_ in getCategoriesNotReceived())
         {
            if(_loc2_.friends.length <= 0)
            {
               Util.remove(_categories,_loc2_);
               _loc2_.dispose();
            }
         }
      }
      
      private function removeFriend(param1:int, param2:Boolean) : Friend
      {
         if(param2)
         {
            _allFriends[param1] = null;
         }
         var _loc4_:Friend = null;
         for each(var _loc3_ in _categories)
         {
            _loc4_ = _loc3_.removeFriend(param1);
            if(_loc4_ != null)
            {
               if(param2)
               {
                  _loc4_.dispose();
               }
            }
         }
         return _loc4_;
      }
      
      private function flushReceivedStatus() : void
      {
         for each(var _loc1_ in _categories)
         {
            _loc1_.received = false;
         }
      }
      
      private function getCategoriesNotReceived() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in _categories)
         {
            if(!_loc2_.received)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function isFriendOnline(param1:int) : Boolean
      {
         var _loc2_:Friend = findFriend(param1);
         return _loc2_?.online;
      }
      
      public function getFriendNames() : Array
      {
         if(_allFriends == null)
         {
            return [];
         }
         var _loc1_:Array = [];
         for each(var _loc2_ in _allFriends)
         {
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_.name);
            }
         }
         return _loc1_;
      }
      
      public function get view() : IFriendsView
      {
         return this._deps.view;
      }
      
      public function get deps() : IFriendCategoriesDeps
      {
         return _deps;
      }
   }
}

