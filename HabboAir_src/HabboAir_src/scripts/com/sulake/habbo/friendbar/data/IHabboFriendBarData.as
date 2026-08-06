package com.sulake.habbo.friendbar.data
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboFriendBarData extends IUnknown
   {
      function get events() : IEventDispatcher;
      
      function get numFriends() : int;
      
      function getFriendAt(param1:int) : IFriendEntity;
      
      function getFriendByID(param1:int) : IFriendEntity;
      
      function getFriendByName(param1:String) : IFriendEntity;
      
      function get numFriendRequests() : int;
      
      function getFriendRequestAt(param1:int) : IFriendRequest;
      
      function getFriendRequestByID(param1:int) : IFriendRequest;
      
      function getFriendRequestByName(param1:String) : IFriendRequest;
      
      function getFriendRequestList() : Array;
      
      function acceptFriendRequest(param1:int) : void;
      
      function acceptAllFriendRequests() : void;
      
      function declineFriendRequest(param1:int) : void;
      
      function declineAllFriendRequests() : void;
      
      function followToRoom(param1:int) : void;
      
      function startConversation(param1:int) : void;
      
      function findNewFriends() : void;
      
      function openUserTextSearch() : void;
      
      function sendGameTabTracking(param1:String) : void;
      
      function sendGameButtonTracking(param1:String) : void;
      
      function toggleFriendList() : void;
      
      function toggleMessenger() : void;
      
      function showProfile(param1:int) : void;
      
      function showProfileByName(param1:String) : void;
   }
}

