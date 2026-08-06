package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionFriendRequestEvent extends RoomSessionEvent
   {
      public static const FRIEND_REQUEST:String = "RSFRE_FRIEND_REQUEST";
      
      private var _requestId:int = 0;
      
      private var _userId:int = 0;
      
      private var _userName:String;
      
      public function RoomSessionFriendRequestEvent(param1:IRoomSession, param2:int, param3:int, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSFRE_FRIEND_REQUEST",param1,param5,param6);
         _requestId = param2;
         _userId = param3;
         _userName = param4;
      }
      
      public function get requestId() : int
      {
         return _requestId;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}

