package com.sulake.habbo.friendbar.events
{
   import flash.events.Event;
   
   public class FriendBarSelectionEvent extends Event
   {
      public static const FRIEND_SELECTED:String = "FBVE_FRIEND_SELECTED";
      
      private var _friendId:int;
      
      private var _friendName:String;
      
      public function FriendBarSelectionEvent(param1:int, param2:String)
      {
         super("FBVE_FRIEND_SELECTED");
         _friendId = param1;
         _friendName = param2;
      }
      
      public function get friendId() : int
      {
         return _friendId;
      }
      
      public function get friendName() : String
      {
         return _friendName;
      }
   }
}

