package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromNotificationType_String_2:String = "RWBIUE_HABBO_CLUB";
      
      private var _daysLeft:int = 0;
      
      private var _periodsLeft:int = 0;
      
      private var _pastPeriods:int = 0;
      
      private var _allowClubDances:Boolean = false;
      
      private var _clubLevel:int;
      
      public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:int, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWBIUE_HABBO_CLUB",param6,param7);
         _daysLeft = param1;
         _periodsLeft = param2;
         _pastPeriods = param3;
         _allowClubDances = param4;
         _clubLevel = param5;
      }
      
      public function get daysLeft() : int
      {
         return _daysLeft;
      }
      
      public function get periodsLeft() : int
      {
         return _periodsLeft;
      }
      
      public function get pastPeriods() : int
      {
         return _pastPeriods;
      }
      
      public function get allowClubDances() : Boolean
      {
         return _allowClubDances;
      }
      
      public function get clubLevel() : int
      {
         return _clubLevel;
      }
   }
}

