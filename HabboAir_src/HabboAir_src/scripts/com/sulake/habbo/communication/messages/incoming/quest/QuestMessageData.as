package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class QuestMessageData
   {
      private var _campaignCode:String;
      
      private var _completedQuestsInCampaign:int;
      
      private var _questCountInCampaign:int;
      
      private var _activityPointType:int;
      
      private var _id:int;
      
      private var _accepted:Boolean;
      
      private var _type:String;
      
      private var _imageVersion:String;
      
      private var _rewardCurrencyAmount:int;
      
      private var _localizationCode:String;
      
      private var _completedSteps:int;
      
      private var _totalSteps:int;
      
      private var UnknownVarFromQuestMessageData_Int_1:int;
      
      private var _sortOrder:int;
      
      private var _catalogPageName:String;
      
      private var _chainCode:String;
      
      private var _easy:Boolean;
      
      private var _isSeasonal:Boolean;
      
      private var UnknownVarFromQuestMessageData_Int_2:int;
      
      private var _receiveTime:Date = new Date();
      
      public function QuestMessageData(param1:IMessageDataWrapper)
      {
         super();
         _campaignCode = param1.readString();
         _completedQuestsInCampaign = param1.readInteger();
         _questCountInCampaign = param1.readInteger();
         _activityPointType = param1.readInteger();
         _id = param1.readInteger();
         _accepted = param1.readBoolean();
         _type = param1.readString();
         _imageVersion = param1.readString();
         _rewardCurrencyAmount = param1.readInteger();
         _localizationCode = param1.readString();
         _completedSteps = param1.readInteger();
         _totalSteps = param1.readInteger();
         _sortOrder = param1.readInteger();
         _catalogPageName = param1.readString();
         _chainCode = param1.readString();
         _easy = param1.readBoolean();
         _isSeasonal = param1.readBoolean();
         if(_isSeasonal)
         {
            UnknownVarFromQuestMessageData_Int_2 = param1.readInteger();
         }
      }
      
      public static function getCampaignLocalizationKeyForCode(param1:String) : String
      {
         return "quests." + param1;
      }
      
      public function get campaignCode() : String
      {
         return _campaignCode;
      }
      
      public function get localizationCode() : String
      {
         return _localizationCode;
      }
      
      public function get completedQuestsInCampaign() : int
      {
         return _completedQuestsInCampaign;
      }
      
      public function get questCountInCampaign() : int
      {
         return _questCountInCampaign;
      }
      
      public function get activityPointType() : int
      {
         return _activityPointType;
      }
      
      public function get accepted() : Boolean
      {
         return _accepted;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get imageVersion() : String
      {
         return _imageVersion;
      }
      
      public function get rewardCurrencyAmount() : int
      {
         return _rewardCurrencyAmount;
      }
      
      public function get completedSteps() : int
      {
         return _completedSteps;
      }
      
      public function get totalSteps() : int
      {
         return _totalSteps;
      }
      
      public function get isCompleted() : Boolean
      {
         return _completedSteps == _totalSteps;
      }
      
      public function get waitPeriodSeconds() : int
      {
         if(UnknownVarFromQuestMessageData_Int_1 < 1)
         {
            return 0;
         }
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime() - _receiveTime.getTime();
         return int(Math.max(0,UnknownVarFromQuestMessageData_Int_1 - Math.floor(_loc2_ / 1000)));
      }
      
      public function get isSeasonal() : Boolean
      {
         return _isSeasonal;
      }
      
      public function get secondsLeft() : int
      {
         if(UnknownVarFromQuestMessageData_Int_2 <= 0)
         {
            return 0;
         }
         var _loc1_:Date = new Date();
         var _loc2_:int = (_loc1_.getTime() - _receiveTime.getTime()) / 1000;
         return UnknownVarFromQuestMessageData_Int_2 - _loc2_;
      }
      
      public function getCampaignLocalizationKey() : String
      {
         return getCampaignLocalizationKeyForCode(campaignCode);
      }
      
      public function getQuestLocalizationKey() : String
      {
         return this.getCampaignLocalizationKey() + "." + _localizationCode;
      }
      
      public function get completedCampaign() : Boolean
      {
         return _id < 1;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set accepted(param1:Boolean) : void
      {
         _accepted = param1;
      }
      
      public function get lastQuestInCampaign() : Boolean
      {
         return _completedQuestsInCampaign >= _questCountInCampaign;
      }
      
      public function get receiveTime() : Date
      {
         return _receiveTime;
      }
      
      public function set waitPeriodSeconds(param1:int) : void
      {
         UnknownVarFromQuestMessageData_Int_1 = param1;
      }
      
      public function get sortOrder() : int
      {
         return _sortOrder;
      }
      
      public function get catalogPageName() : String
      {
         return _catalogPageName;
      }
      
      public function get chainCode() : String
      {
         return _chainCode;
      }
      
      public function get campaignChainCode() : String
      {
         if(_isSeasonal)
         {
            return _campaignCode + "." + _chainCode;
         }
         return _campaignCode;
      }
      
      public function get easy() : Boolean
      {
         return _easy;
      }
   }
}

