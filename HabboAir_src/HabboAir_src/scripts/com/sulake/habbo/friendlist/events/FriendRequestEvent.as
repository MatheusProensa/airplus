package com.sulake.habbo.friendlist.events
{
   import flash.events.Event;
   
   public class FriendRequestEvent extends Event
   {
      public static const ACCEPTED:String = "FRE_ACCEPTED";
      
      public static const DECLINED:String = "FRE_DECLINED";
      
      private var _requestId:int;
      
      public function FriendRequestEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _requestId = param2;
      }
      
      public function get requestId() : int
      {
         return _requestId;
      }
   }
}

