package com.sulake.habbo.quest.rewardtrack.data
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class RewardTrackRewardDisplayWrapper implements IProductDisplayInfo
   {
      private var UnknownVarFromRewardTrackRewardDisplayWrapper_RewardTrackPrize_1:RewardTrackPrize;
      
      public function RewardTrackRewardDisplayWrapper(param1:RewardTrackPrize)
      {
         super();
         UnknownVarFromRewardTrackRewardDisplayWrapper_RewardTrackPrize_1 = param1;
      }
      
      public function get productTypeId() : int
      {
         return UnknownVarFromRewardTrackRewardDisplayWrapper_RewardTrackPrize_1.productItemTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return UnknownVarFromRewardTrackRewardDisplayWrapper_RewardTrackPrize_1.rewardTypeId;
      }
      
      public function get extraData() : String
      {
         return "";
      }
      
      public function get petFigureString() : String
      {
         return UnknownVarFromRewardTrackRewardDisplayWrapper_RewardTrackPrize_1.extraParams;
      }
      
      public function get botFigureString() : String
      {
         return UnknownVarFromRewardTrackRewardDisplayWrapper_RewardTrackPrize_1.extraParams;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return new Vector.<int>();
      }
   }
}

