package com.sulake.habbo.quest.rewardtrack.view.tasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTask;
   import com.sulake.habbo.quest.rewardtrack.view.progress.RewardTrackTaskProgressBarView;
   import com.sulake.habbo.quest.rewardtrack.view.theme.RewardTrackTheme;
   
   public class RewardTrackTaskRowView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromRewardTrackTaskRowView_RewardTrackController_1:RewardTrackController;
      
      private var UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskListView_1:RewardTrackTaskListView;
      
      private var _task:RewardTrackTask;
      
      private var _theme:RewardTrackTheme;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskProgressBarView_1:RewardTrackTaskProgressBarView;
      
      private var _defaultBorderColor:uint;
      
      private var UnknownVarFromRewardTrackTaskRowView_Int_1:int;
      
      private var _selected:Boolean;
      
      private var UnknownVarFromRewardTrackTaskRowView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function RewardTrackTaskRowView(param1:IWindowController_1, param2:RewardTrackController, param3:RewardTrackTaskListView, param4:RewardTrackTask, param5:RewardTrackTheme)
      {
         super();
         UnknownVarFromRewardTrackTaskRowView_RewardTrackController_1 = param2;
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskListView_1 = param3;
         _task = param4;
         _theme = param5;
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskProgressBarView_1 = new RewardTrackTaskProgressBarView(loadingBar);
         _defaultBorderColor = taskBorder.color;
         _window.addEventListener("WME_CLICK",onClick);
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMouseOut);
         UnknownVarFromRewardTrackTaskRowView_Int_1 = _task.activeLevelIndex;
         initialize();
      }
      
      private function initialize() : void
      {
         taskNameText.text = localize("reward_track." + _task.track.id + ".task." + _task.id + ".name");
         taskDescriptionText.text = localize("reward_track." + _task.track.id + ".task." + _task.id + ".desc");
         taskImage.assetUri = "reward_track_tasks_" + _task.actionType.toLowerCase();
         refresh(false);
      }
      
      public function refresh(param1:Boolean) : void
      {
         var _loc2_:int = UnknownVarFromRewardTrackTaskRowView_Int_1;
         UnknownVarFromRewardTrackTaskRowView_Int_1 = _task.activeLevelIndex;
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskProgressBarView_1.refreshTask(_task,param1,_loc2_);
         progressText.text = _task.progressCount + " / " + _task.activeLevel.requiredCount;
         rewardText.text = String(_task.activeLevel.pointsReward);
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         refreshBorder();
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskProgressBarView_1.update(param1);
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskListView_1.selectTask(_task);
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskRowView_Boolean_1 = true;
         refreshBorder();
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskRowView_Boolean_1 = false;
         refreshBorder();
      }
      
      private function refreshBorder() : void
      {
         if(_selected)
         {
            taskBorder.color = _theme.activeColor;
         }
         else if(UnknownVarFromRewardTrackTaskRowView_Boolean_1)
         {
            taskBorder.color = _theme.lightColor;
         }
         else
         {
            taskBorder.color = _defaultBorderColor;
         }
      }
      
      private function localize(param1:String) : String
      {
         return UnknownVarFromRewardTrackTaskRowView_RewardTrackController_1.localizationManager.getLocalization(param1,param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _window.removeEventListener("WME_CLICK",onClick);
         _window.removeEventListener("WME_OVER",onMouseOver);
         _window.removeEventListener("WME_OUT",onMouseOut);
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskProgressBarView_1.dispose();
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskProgressBarView_1 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromRewardTrackTaskRowView_RewardTrackController_1 = null;
         UnknownVarFromRewardTrackTaskRowView_RewardTrackTaskListView_1 = null;
         _task = null;
         _theme = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get task() : RewardTrackTask
      {
         return _task;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function get taskNameText() : ITextWindow
      {
         return _window.findChildByName("task_name") as ITextWindow;
      }
      
      private function get taskDescriptionText() : ITextWindow
      {
         return _window.findChildByName("task_description") as ITextWindow;
      }
      
      private function get taskBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("task_border") as UnknownICoreWindowComponents6;
      }
      
      private function get progressText() : ITextWindow
      {
         return _window.findChildByName("task_progress_txt") as ITextWindow;
      }
      
      private function get rewardText() : ITextWindow
      {
         return _window.findChildByName("track_reward_txt") as ITextWindow;
      }
      
      private function get taskImage() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("task_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get loadingBar() : IWindowController_1
      {
         return _window.findChildByName("loading_bar") as IWindowController_1;
      }
   }
}

