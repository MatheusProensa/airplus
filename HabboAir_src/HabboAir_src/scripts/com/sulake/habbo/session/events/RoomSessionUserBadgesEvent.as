package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionUserBadgesEvent extends RoomSessionEvent
   {
      public static const USER_BADGES:String = "RSUBE_BADGES";
      
      private var _userId:int = 0;
      
      private var _selectedBadges:Array = [];
      
      public function RoomSessionUserBadgesEvent(param1:IRoomSession, param2:int, param3:Array = null, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSUBE_BADGES",param1,param4,param5);
         _userId = param2;
         _selectedBadges = param3 == null ? [] : param3;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get selectedBadges() : Array
      {
         return _selectedBadges;
      }
   }
}

