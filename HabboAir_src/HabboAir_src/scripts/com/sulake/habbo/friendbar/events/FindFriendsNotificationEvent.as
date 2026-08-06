package com.sulake.habbo.friendbar.events
{
   import flash.events.Event;
   
   public class FindFriendsNotificationEvent extends Event
   {
      public static const TYPE:String = "FIND_FRIENDS_RESULT";
      
      private var _success:Boolean;
      
      public function FindFriendsNotificationEvent(param1:Boolean)
      {
         _success = param1;
         super("FIND_FRIENDS_RESULT");
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
   }
}

