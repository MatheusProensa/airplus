package com.sulake.habbo.friendlist
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.IWindowController_1;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public interface IHabboFriendList extends IUnknown
   {
      function get events() : IEventDispatcher;
      
      function canBeAskedForAFriend(param1:int) : Boolean;
      
      function askForAFriend(param1:int, param2:String) : Boolean;
      
      function getFriend(param1:int) : UnknownIHabboFriendlist1;
      
      function openFriendList() : void;
      
      function openFriendRequests() : void;
      
      function openFriendSearch() : void;
      
      function close() : void;
      
      function alignBottomLeftTo(param1:Point) : void;
      
      function isOpen() : Boolean;
      
      function currentTabId() : int;
      
      function getFriendCount(param1:Boolean, param2:Boolean) : int;
      
      function openHabboWebPage(param1:String, param2:Dictionary, param3:int, param4:int) : void;
      
      function getFriendNames() : Array;
      
      function acceptFriendRequest(param1:int) : void;
      
      function acceptAllFriendRequests() : void;
      
      function declineFriendRequest(param1:int) : void;
      
      function declineAllFriendRequests() : void;
      
      function get mainWindow() : IWindowController_1;
      
      function getRelationshipStatus(param1:int) : int;
      
      function setRelationshipStatus(param1:int, param2:int) : void;
      
      function get hasfriendsListInitialized() : Boolean;
   }
}

