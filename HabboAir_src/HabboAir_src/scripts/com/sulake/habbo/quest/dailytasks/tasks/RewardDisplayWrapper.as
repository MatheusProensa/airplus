package com.sulake.habbo.quest.dailytasks.tasks
{
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTaskReward;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class RewardDisplayWrapper implements IProductDisplayInfo
   {
      private var UnknownVarFromRewardDisplayWrapper_DailyTaskReward_1:DailyTaskReward;
      
      public function RewardDisplayWrapper(param1:DailyTaskReward)
      {
         super();
         UnknownVarFromRewardDisplayWrapper_DailyTaskReward_1 = param1;
      }
      
      public function get productTypeId() : int
      {
         return UnknownVarFromRewardDisplayWrapper_DailyTaskReward_1.productItemTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return UnknownVarFromRewardDisplayWrapper_DailyTaskReward_1.rewardTypeId;
      }
      
      public function get extraData() : String
      {
         return "";
      }
      
      public function get petFigureString() : String
      {
         return UnknownVarFromRewardDisplayWrapper_DailyTaskReward_1.extraParams;
      }
      
      public function get botFigureString() : String
      {
         return UnknownVarFromRewardDisplayWrapper_DailyTaskReward_1.extraParams;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return new Vector.<int>();
      }
   }
}

