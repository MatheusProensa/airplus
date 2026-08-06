package com.sulake.habbo.quest.dailytasks.tasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTaskReward;
   import com.sulake.habbo.quest.dailytasks.DailyTasksController;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   
   public class DailyTaskRewardView implements IComponentInterfaceQueue
   {
      private var _reward:DailyTaskReward;
      
      private var UnknownVarFromDailyTaskRewardView_DailyTasksController_1:DailyTasksController;
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean;
      
      public function DailyTaskRewardView(param1:DailyTaskReward, param2:DailyTasksController)
      {
         super();
         _reward = param1;
         UnknownVarFromDailyTaskRewardView_DailyTasksController_1 = param2;
         _window = param2.view.rewardTemplate.clone() as IWindowController_1;
         initializeUI();
      }
      
      private function initializeUI() : void
      {
         rewardAmountBorder.visible = _reward.amount > 1;
         rewardAmountText.caption = "x" + String(reward.amount);
         (rewardDisplayWidget.widget as IProductIconWidget).productInfo = new RewardDisplayWrapper(_reward);
         if(!rewardAmountBorder.visible)
         {
            rewardDisplayWidget.y = rewardDisplayWidget.parent.height / 2 - rewardDisplayWidget.height / 2;
         }
      }
      
      public function get reward() : DailyTaskReward
      {
         return _reward;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window.dispose();
         _window = null;
         UnknownVarFromDailyTaskRewardView_DailyTasksController_1 = null;
         _reward = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get rewardDisplayWidget() : IWidgetWindowController
      {
         return _window.findChildByName("reward_display_widget") as IWidgetWindowController;
      }
      
      public function get rewardAmountBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("reward_amount_border") as UnknownICoreWindowComponents6;
      }
      
      public function get rewardAmountText() : ITextWindow
      {
         return _window.findChildByName("reward_amount_text") as ITextWindow;
      }
   }
}

