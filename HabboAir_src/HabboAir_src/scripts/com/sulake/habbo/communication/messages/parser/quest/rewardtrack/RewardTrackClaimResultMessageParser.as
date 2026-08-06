package com.sulake.habbo.communication.messages.parser.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RewardTrackClaimResultMessageParser implements IMessageParser
   {
      public static const SUCCESS:int = 0;
      
      public static const UnknownConstFromRoomObjectVisibilityUpdateMessage_String_1:int = 1;
      
      public static const UnknownConstFromRewardTrackClaimResultMessageParser_Int_1:int = 2;
      
      public static const UnknownConstFromRewardTrackClaimResultMessageParser_Int_2:int = 3;
      
      public static const UnknownConstFromRewardTrackClaimResultMessageParser_Int_3:int = 4;
      
      public static const UnknownConstFromRewardTrackClaimResultMessageParser_Int_4:int = 5;
      
      public static const UnknownConstFromRewardTrackClaimResultMessageParser_Int_5:int = 6;
      
      public static const UnknownConstFromRewardTrackClaimResultMessageParser_Int_6:int = 7;
      
      public static const UnknownConstFromRewardTrackClaimResultMessageParser_Int_7:int = 8;
      
      private var _trackId:String;
      
      private var _rewardId:String;
      
      private var _resultCode:int;
      
      public function RewardTrackClaimResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _trackId = null;
         _rewardId = null;
         _resultCode = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _trackId = param1.readString();
         _rewardId = param1.readString();
         _resultCode = param1.readInteger();
         return true;
      }
      
      public function get trackId() : String
      {
         return _trackId;
      }
      
      public function get rewardId() : String
      {
         return _rewardId;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
   }
}

