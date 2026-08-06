package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionUserFigureUpdateEvent extends RoomSessionEvent
   {
      public static const USER_FIGURE:String = "RSUBE_FIGURE";
      
      private var _userId:int = 0;
      
      private var _figure:String = "";
      
      private var _gender:String = "";
      
      private var _customInfo:String = "";
      
      private var _achievementScore:int;
      
      private var _badgesRank:int = -1;
      
      public function RoomSessionUserFigureUpdateEvent(param1:IRoomSession, param2:int, param3:String, param4:String, param5:String, param6:int, param7:int = -1, param8:Boolean = false, param9:Boolean = false)
      {
         super("RSUBE_FIGURE",param1,param8,param9);
         _userId = param2;
         _figure = param3;
         _gender = param4;
         _customInfo = param5;
         _achievementScore = param6;
         _badgesRank = param7;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get customInfo() : String
      {
         return _customInfo;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function get badgesRank() : int
      {
         return _badgesRank;
      }
   }
}

