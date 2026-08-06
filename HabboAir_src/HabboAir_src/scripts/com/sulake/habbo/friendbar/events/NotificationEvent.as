package com.sulake.habbo.friendbar.events
{
   import com.sulake.habbo.friendbar.data.IFriendNotification;
   import flash.events.Event;
   
   public class NotificationEvent extends Event
   {
      public static const FRIEND_NOTIFICATION_EVENT:String = "FBE_NOTIFICATION_EVENT";
      
      public var friendId:int;
      
      public var notification:IFriendNotification;
      
      public function NotificationEvent(param1:int, param2:IFriendNotification)
      {
         super("FBE_NOTIFICATION_EVENT");
         this.friendId = param1;
         this.notification = param2;
      }
   }
}

