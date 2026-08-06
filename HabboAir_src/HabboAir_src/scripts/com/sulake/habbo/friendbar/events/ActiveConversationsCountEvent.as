package com.sulake.habbo.friendbar.events
{
   import flash.events.Event;
   
   public class ActiveConversationsCountEvent extends Event
   {
      public static const ACTIVE_MESSENGER_CONVERSATION_EVENT:String = "AMC_EVENT";
      
      private var _activeConversationsCount:int;
      
      private var _hasUnread:Boolean;
      
      public function ActiveConversationsCountEvent(param1:int, param2:Boolean)
      {
         _activeConversationsCount = param1;
         _hasUnread = param2;
         super("AMC_EVENT");
      }
      
      public function get activeConversationsCount() : int
      {
         return _activeConversationsCount;
      }
      
      public function get hasUnread() : Boolean
      {
         return _hasUnread;
      }
   }
}

