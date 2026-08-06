package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentLevelUpMessageParser implements IMessageParser
   {
      private var _talentTrackName:String;
      
      private var _level:int;
      
      private var _rewardPerks:Vector.<TalentTrackRewardPerk>;
      
      private var _rewardProducts:Vector.<TalentTrackRewardProduct>;
      
      public function TalentLevelUpMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _talentTrackName = null;
         _rewardPerks = null;
         _rewardProducts = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _talentTrackName = param1.readString();
         _level = param1.readInteger();
         _rewardPerks = new Vector.<TalentTrackRewardPerk>();
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _rewardPerks.push(new TalentTrackRewardPerk(param1));
            _loc3_++;
         }
         _rewardProducts = new Vector.<TalentTrackRewardProduct>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _rewardProducts.push(new TalentTrackRewardProduct(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get talentTrackName() : String
      {
         return _talentTrackName;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get rewardPerks() : Vector.<TalentTrackRewardPerk>
      {
         return _rewardPerks;
      }
      
      public function get rewardProducts() : Vector.<TalentTrackRewardProduct>
      {
         return _rewardProducts;
      }
   }
}

