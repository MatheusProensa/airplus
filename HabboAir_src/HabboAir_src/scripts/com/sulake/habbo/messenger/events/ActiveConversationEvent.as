package com.sulake.habbo.messenger.events
{
   import flash.events.Event;
   
   public class ActiveConversationEvent extends Event
   {
      public static const ACTIVE_CONVERSATION_COUNT_CHANGED:String = "ACCE_changed";
      
      private var _activeConversationsCount:int;
      
      private var _hasUnread:Boolean;
      
      public function ActiveConversationEvent(param1:String, param2:int, param3:Boolean)
      {
         super(param1);
         _activeConversationsCount = param2;
         _hasUnread = param3;
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

