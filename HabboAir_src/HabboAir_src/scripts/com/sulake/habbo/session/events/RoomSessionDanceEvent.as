package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionDanceEvent extends RoomSessionEvent
   {
      public static const UnknownConstFromRoomSessionDanceEvent_String_1:String = "RSDE_DANCE";
      
      private var _userId:int;
      
      private var _danceStyle:int;
      
      public function RoomSessionDanceEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSDE_DANCE",param1,param4,param5);
         _userId = param2;
         _danceStyle = param3;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get danceStyle() : int
      {
         return _danceStyle;
      }
   }
}

