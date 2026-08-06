package com.sulake.habbo.quest.rewardtrack.view.tasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTask;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTaskLevel;
   import com.sulake.habbo.quest.rewardtrack.view.progress.RewardTrackTaskProgressBarView;
   import com.sulake.habbo.quest.rewardtrack.view.theme.RewardTrackTheme;
   
   public class RewardTrackTaskLevelView implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromRewardTrackTaskLevelView_Vector_1:Vector.<RewardTrackTaskLevelView> = new Vector.<RewardTrackTaskLevelView>(0);
      
      private var UnknownVarFromRewardTrackTaskLevelView_RewardTrackController_1:RewardTrackController;
      
      private var UnknownVarFromRewardTrackTaskLevelView_RewardTrackTask_1:RewardTrackTask;
      
      private var UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskLevel_1:RewardTrackTaskLevel;
      
      private var _theme:RewardTrackTheme;
      
      private var _index:int;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskProgressBarView_1:RewardTrackTaskProgressBarView;
      
      private var _defaultBorderColor:uint;
      
      private var _disposed:Boolean;
      
      public function RewardTrackTaskLevelView(param1:IWindowController_1)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskProgressBarView_1 = new RewardTrackTaskProgressBarView(loadingBar);
         _defaultBorderColor = levelBorder.color;
      }
      
      public static function create(param1:IWindowController_1, param2:RewardTrackController, param3:RewardTrackTask, param4:RewardTrackTaskLevel, param5:int, param6:RewardTrackTheme) : RewardTrackTaskLevelView
      {
         var _loc7_:RewardTrackTaskLevelView = UnknownConstFromRewardTrackTaskLevelView_Vector_1.length > 0 ? UnknownConstFromRewardTrackTaskLevelView_Vector_1.pop() : new RewardTrackTaskLevelView(param1);
         _loc7_.initialize(param2,param3,param4,param5,param6);
         return _loc7_;
      }
      
      public function initialize(param1:RewardTrackController, param2:RewardTrackTask, param3:RewardTrackTaskLevel, param4:int, param5:RewardTrackTheme) : void
      {
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackController_1 = param1;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTask_1 = param2;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskLevel_1 = param3;
         _index = param4;
         _theme = param5;
         levelNameText.text = UnknownVarFromRewardTrackTaskLevelView_RewardTrackController_1.localizationManager.getLocalizationWithParams("reward_track.levels.level","","level",param4 + 1);
         rewardText.text = String(UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskLevel_1.pointsReward);
         refresh(false);
      }
      
      public function refresh(param1:Boolean) : void
      {
         var _loc2_:Number = UnknownVarFromRewardTrackTaskLevelView_RewardTrackTask_1.progressRatioFor(UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskLevel_1);
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskProgressBarView_1.refreshRatio(_loc2_,param1);
         progressText.text = UnknownVarFromRewardTrackTaskLevelView_RewardTrackTask_1.progressCount + " / " + UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskLevel_1.requiredCount;
         completedIcon.visible = _loc2_ >= 1;
         lockedIcon.visible = false;
         levelBorder.color = _index == UnknownVarFromRewardTrackTaskLevelView_RewardTrackTask_1.activeLevelIndex ? _theme.activeColor : _defaultBorderColor;
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskProgressBarView_1.update(param1);
      }
      
      public function recycle() : void
      {
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackController_1 = null;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTask_1 = null;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskLevel_1 = null;
         _theme = null;
         _index = 0;
         UnknownConstFromRewardTrackTaskLevelView_Vector_1.push(this);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskProgressBarView_1.dispose();
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskProgressBarView_1 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackController_1 = null;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTask_1 = null;
         UnknownVarFromRewardTrackTaskLevelView_RewardTrackTaskLevel_1 = null;
         _theme = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function get levelNameText() : ITextWindow
      {
         return _window.findChildByName("level_name") as ITextWindow;
      }
      
      private function get levelBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("level_border") as UnknownICoreWindowComponents6;
      }
      
      private function get progressText() : ITextWindow
      {
         return _window.findChildByName("level_progress_txt") as ITextWindow;
      }
      
      private function get rewardText() : ITextWindow
      {
         return _window.findChildByName("level_reward_txt") as ITextWindow;
      }
      
      private function get completedIcon() : IWindowModel
      {
         return _window.findChildByName("completed_icon");
      }
      
      private function get lockedIcon() : IWindowModel
      {
         return _window.findChildByName("locked_icon");
      }
      
      private function get loadingBar() : IWindowController_1
      {
         return _window.findChildByName("loading_bar") as IWindowController_1;
      }
   }
}

