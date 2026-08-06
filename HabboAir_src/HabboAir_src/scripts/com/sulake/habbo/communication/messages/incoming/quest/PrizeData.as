package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class PrizeData
   {
      private var _communityGoalId:int;
      
      private var _communityGoalCode:String;
      
      private var _userRank:int;
      
      private var _rewardCode:String;
      
      private var _badge:Boolean;
      
      private var _localizedName:String;
      
      public function PrizeData(param1:IMessageDataWrapper)
      {
         super();
         _communityGoalId = param1.readInteger();
         _communityGoalCode = param1.readString();
         _userRank = param1.readInteger();
         _rewardCode = param1.readString();
         _badge = param1.readBoolean();
         _localizedName = param1.readString();
      }
      
      public function get communityGoalId() : int
      {
         return _communityGoalId;
      }
      
      public function get communityGoalCode() : String
      {
         return _communityGoalCode;
      }
      
      public function get userRank() : int
      {
         return _userRank;
      }
      
      public function get rewardCode() : String
      {
         return _rewardCode;
      }
      
      public function get badge() : Boolean
      {
         return _badge;
      }
      
      public function get localizedName() : String
      {
         return _localizedName;
      }
   }
}

