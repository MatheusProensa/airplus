package com.sulake.habbo.messenger.events
{
   import flash.events.Event;
   
   public class MiniMailMessageEvent extends Event
   {
      public static const NEW_MESSAGE_NOTIFICATION:String = "MMME_new";
      
      public static const UnknownConstFromMiniMailMessageEvent_String_1:String = "MMME_unread";
      
      private var _unreadCount:int;
      
      public function MiniMailMessageEvent(param1:String, param2:int = -1)
      {
         super(param1);
         _unreadCount = param2;
      }
      
      public function get unreadCount() : int
      {
         return _unreadCount;
      }
   }
}

