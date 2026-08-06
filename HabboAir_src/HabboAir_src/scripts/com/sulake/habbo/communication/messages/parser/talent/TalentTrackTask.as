package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class TalentTrackTask
   {
      public static const UnknownConstFromTalentTrackTask_String_1:String = "ACH_HabboWayGraduate1";
      
      public static const UnknownConstFromTalentTrackTask_String_2:String = "ACH_GuideGroupMember1";
      
      public static const UnknownConstFromTalentTrackTask_String_3:String = "ACH_SafetyQuizGraduate1";
      
      public static const UnknownConstFromTalentTrackTask_String_4:String = "ACH_EmailVerification1";
      
      public static const ROOM_ENTRY_1:String = "ACH_RoomEntry1";
      
      public static const ROOM_ENTRY_2:String = "ACH_RoomEntry2";
      
      public static const UnknownConstFromTalentTrackTask_String_5:String = "ACH_AvatarLooks1";
      
      public static const UnknownConstFromTalentTrackTask_String_6:String = "ACH_GuideAdvertisementReader1";
      
      private var _achievementId:int;
      
      private var _requiredLevel:int;
      
      private var _badgeCode:String;
      
      private var _state:int;
      
      private var _currentScore:int;
      
      private var _totalScore:int;
      
      public function TalentTrackTask(param1:IMessageDataWrapper)
      {
         super();
         _achievementId = param1.readInteger();
         _requiredLevel = param1.readInteger();
         _badgeCode = param1.readString();
         _state = param1.readInteger();
         _currentScore = param1.readInteger();
         _totalScore = param1.readInteger();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get achievementId() : int
      {
         return _achievementId;
      }
      
      public function get requiredLevel() : int
      {
         return _requiredLevel;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get currentScore() : int
      {
         return _currentScore;
      }
      
      public function get totalScore() : int
      {
         return _totalScore;
      }
      
      public function hasProgressDisplay() : Boolean
      {
         switch(badgeCode)
         {
            case "ACH_HabboWayGraduate1":
            case "ACH_SafetyQuizGraduate1":
            case "ACH_EmailVerification1":
            case "ACH_AvatarLooks1":
               break;
            default:
               return true;
         }
         return false;
      }
   }
}

