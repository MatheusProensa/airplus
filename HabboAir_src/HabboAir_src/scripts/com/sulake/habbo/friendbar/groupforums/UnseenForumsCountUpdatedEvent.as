package com.sulake.habbo.friendbar.groupforums
{
   import flash.events.Event;
   
   public class UnseenForumsCountUpdatedEvent extends Event
   {
      public static const TYPE:String = "UNSEEN_FORUMS_COUNT";
      
      private var _unseenForumsCount:int;
      
      public function UnseenForumsCountUpdatedEvent(param1:String, param2:int)
      {
         super(param1);
         _unseenForumsCount = param2;
      }
      
      public function get unseenForumsCount() : int
      {
         return _unseenForumsCount;
      }
   }
}

