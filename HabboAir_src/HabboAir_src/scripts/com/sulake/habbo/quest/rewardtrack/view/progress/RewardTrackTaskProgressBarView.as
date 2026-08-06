package com.sulake.habbo.quest.rewardtrack.view.progress
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTask;
   
   public class RewardTrackTaskProgressBarView extends RewardTrackProgressBarViewBase
   {
      private var UnknownVarFromRewardTrackTaskProgressBarView_Number_1:Number = -1;
      
      public function RewardTrackTaskProgressBarView(param1:IWindowController_1)
      {
         super(param1,true);
      }
      
      public function refreshRatio(param1:Number, param2:Boolean, param3:Boolean = false) : void
      {
         if(param3 && param2)
         {
            UnknownVarFromRewardTrackTaskProgressBarView_Number_1 = param1;
            setRatio(1,true);
            return;
         }
         UnknownVarFromRewardTrackTaskProgressBarView_Number_1 = -1;
         setRatio(param1,param2);
      }
      
      public function refreshTask(param1:RewardTrackTask, param2:Boolean, param3:int = -1) : void
      {
         var _loc4_:Boolean = param3 != -1 && param3 != param1.activeLevelIndex;
         refreshRatio(param1.progressRatioFor(param1.activeLevel),param2,_loc4_);
      }
      
      override public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         super.update(param1);
         if(UnknownVarFromRewardTrackTaskProgressBarView_Number_1 >= 0 && !isUpdating)
         {
            _loc2_ = UnknownVarFromRewardTrackTaskProgressBarView_Number_1;
            UnknownVarFromRewardTrackTaskProgressBarView_Number_1 = -1;
            setRatio(_loc2_,false);
         }
      }
   }
}

