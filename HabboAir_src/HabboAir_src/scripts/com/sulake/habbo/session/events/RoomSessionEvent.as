package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   import flash.events.Event;
   
   public class RoomSessionEvent extends Event
   {
      public static const UnknownConstFromRoomSessionEvent_String_1:String = "RSE_CREATED";
      
      public static const UnknownConstFromRoomSessionEvent_String_2:String = "RSE_STARTED";
      
      public static const UnknownConstFromRoomSessionEvent_String_3:String = "RSE_ENDED";
      
      public static const SESSION_ROOM_DATA:String = "RSE_ROOM_DATA";
      
      private var _session:IRoomSession;
      
      private var _openLandingPage:Boolean;
      
      public function RoomSessionEvent(param1:String, param2:IRoomSession, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _session = param2;
         _openLandingPage = param3;
      }
      
      public function get session() : IRoomSession
      {
         return _session;
      }
      
      public function get openLandingPage() : Boolean
      {
         return _openLandingPage;
      }
   }
}

