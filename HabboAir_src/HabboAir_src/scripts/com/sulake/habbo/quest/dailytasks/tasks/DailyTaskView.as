package com.sulake.habbo.quest.dailytasks.tasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTaskInfo;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTaskReward;
   import com.sulake.habbo.quest.ProgressBar;
   import com.sulake.habbo.quest.dailytasks.DailyTasksController;
   import flash.geom.Point;
   
   public class DailyTaskView implements IComponentInterfaceQueue, IProfiler_1
   {
      private static var UnknownVarFromDailyTaskView_String_1:String = "${image.library.dailytasks.url}";
      
      private static var BACKGROUND_GREEN:uint = 13033652;
      
      private static var UnknownVarFromDailyTaskView_Uint_1:uint = 4960837;
      
      private static var REWARD_GREEN:uint = 10931858;
      
      private static var BACKGROUND_ORANGE:uint = 15916471;
      
      private static var TITLE_ORANGE:uint = 15511865;
      
      private static var REWARD_ORANGE:uint = 15714445;
      
      private static var BACKGROUND_YELLOW:uint = 15725493;
      
      private static var UnknownVarFromDailyTaskView_Uint_2:uint = 14208611;
      
      private static var REWARD_YELLOW:uint = 14804370;
      
      private var _dailyTask:DailyTaskInfo;
      
      private var UnknownVarFromDailyTaskView_DailyTasksController_1:DailyTasksController;
      
      private var _window:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromDailyTaskView_Vector_1:Vector.<DailyTaskRewardView>;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromDailyTaskView_ProgressBar_1:ProgressBar;
      
      private var UnknownVarFromDailyTaskView_Boolean_1:Boolean = false;
      
      public function DailyTaskView(param1:DailyTaskInfo, param2:DailyTasksController)
      {
         var _loc4_:DailyTaskRewardView = null;
         super();
         _dailyTask = param1;
         UnknownVarFromDailyTaskView_DailyTasksController_1 = param2;
         _window = param2.view.taskTemplate.clone() as UnknownICoreWindowComponents6;
         UnknownVarFromDailyTaskView_ProgressBar_1 = new ProgressBar(UnknownVarFromDailyTaskView_DailyTasksController_1.questEngine,progressBarContainer,progressBarContainer.width - 8,"quests.tracker.progress",true,new Point(0,0),true);
         UnknownVarFromDailyTaskView_Vector_1 = new Vector.<DailyTaskRewardView>();
         for each(var _loc3_ in _dailyTask.rewards)
         {
            _loc4_ = new DailyTaskRewardView(_loc3_,UnknownVarFromDailyTaskView_DailyTasksController_1);
            UnknownVarFromDailyTaskView_Vector_1.push(_loc4_);
            rewardsList.addListItem(_loc4_.window);
         }
         claimButton.addEventListener("WME_CLICK",onClaimClicked);
         initializeUI();
      }
      
      private function initializeUI() : void
      {
         taskTitleTxt.text = localize(_dailyTask.nameLocalizationKey);
         taskDescTxt.text = localize(_dailyTask.descriptionLocalizationKey);
         infoHoverRegion.toolTipCaption = localize(_dailyTask.hintLocalizationKey);
         if(_dailyTask.isBonus)
         {
            _window.color = BACKGROUND_YELLOW;
            rewardTitleBorder.color = REWARD_YELLOW;
            taskNameBorder.color = UnknownVarFromDailyTaskView_Uint_2;
         }
         taskImageStaticBitmap.assetUri = imageUrl;
         updateStatusAndRepeatsUI();
      }
      
      public function updateStatusAndRepeatsUI(param1:Boolean = true) : void
      {
         if(_dailyTask.status == DailyTaskInfo.UnknownVarFromDailyTaskInfo_Int_2 && Boolean(progressBarContainer.visible) && param1)
         {
            UnknownVarFromDailyTaskView_ProgressBar_1.refresh(_dailyTask.requiredRepeats,_dailyTask.requiredRepeats,_dailyTask.taskId,0);
            UnknownVarFromDailyTaskView_Boolean_1 = true;
            return;
         }
         if(_dailyTask.status == DailyTaskInfo.UnknownVarFromDailyTaskInfo_Int_1)
         {
            if(!dailyTask.isBonus)
            {
               _window.color = BACKGROUND_ORANGE;
               rewardTitleBorder.color = REWARD_ORANGE;
               taskNameBorder.color = TITLE_ORANGE;
            }
            completionContainer.visible = false;
            claimButtonContainer.visible = false;
            progressBarContainer.visible = true;
            UnknownVarFromDailyTaskView_ProgressBar_1.refresh(_dailyTask.repeats,_dailyTask.requiredRepeats,_dailyTask.taskId,0);
         }
         else
         {
            if(!dailyTask.isBonus)
            {
               _window.color = BACKGROUND_GREEN;
               rewardTitleBorder.color = REWARD_GREEN;
               taskNameBorder.color = UnknownVarFromDailyTaskView_Uint_1;
            }
            completionContainer.visible = true;
            claimButtonContainer.visible = true;
            if(_dailyTask.status == DailyTaskInfo.UnknownVarFromDailyTaskInfo_Int_3)
            {
               claimButton.disable();
               claimButtonText.text = localize("dailytasks.claimed");
            }
            else
            {
               claimButton.enable();
               claimButtonText.text = localize("dailytasks.claim");
            }
            progressBarContainer.visible = false;
         }
      }
      
      private function onClaimClicked(param1:WindowMouseEvent) : void
      {
         claimButton.disable();
         UnknownVarFromDailyTaskView_DailyTasksController_1.claimTask(_dailyTask.taskId);
      }
      
      private function get imageUrl() : String
      {
         return UnknownVarFromDailyTaskView_String_1 + _dailyTask.taskCode + dailyTask.imageVersion + ".png";
      }
      
      public function get dailyTask() : DailyTaskInfo
      {
         return _dailyTask;
      }
      
      private function localize(param1:String) : String
      {
         return UnknownVarFromDailyTaskView_DailyTasksController_1.localizationManager.getLocalization(param1,param1);
      }
      
      public function update(param1:uint) : void
      {
         if(progressBarContainer.visible)
         {
            UnknownVarFromDailyTaskView_ProgressBar_1.updateView(param1);
         }
         if(UnknownVarFromDailyTaskView_Boolean_1 && !UnknownVarFromDailyTaskView_ProgressBar_1.isUpdating)
         {
            UnknownVarFromDailyTaskView_Boolean_1 = false;
            updateStatusAndRepeatsUI(false);
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         claimButton.removeEventListener("WME_CLICK",onClaimClicked);
         for each(var _loc1_ in UnknownVarFromDailyTaskView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromDailyTaskView_Vector_1 = null;
         UnknownVarFromDailyTaskView_ProgressBar_1.dispose();
         UnknownVarFromDailyTaskView_ProgressBar_1 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromDailyTaskView_DailyTasksController_1 = null;
         _dailyTask = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : UnknownICoreWindowComponents6
      {
         return _window;
      }
      
      public function get taskNameBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("task_name_cont") as UnknownICoreWindowComponents6;
      }
      
      public function get rewardTitleBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("reward_title_border") as UnknownICoreWindowComponents6;
      }
      
      public function get taskTitleTxt() : ITextWindow
      {
         return _window.findChildByName("task_title_txt") as ITextWindow;
      }
      
      public function get taskDescTxt() : ITextWindow
      {
         return _window.findChildByName("task_desc_txt") as ITextWindow;
      }
      
      public function get infoHoverRegion() : IRegionWindow
      {
         return _window.findChildByName("info_hover_region") as IRegionWindow;
      }
      
      public function get taskImageStaticBitmap() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("task_static_bitmap") as IStaticBitmapWrapperWindow;
      }
      
      public function get completionContainer() : IWindowController_1
      {
         return _window.findChildByName("completion_cont") as IWindowController_1;
      }
      
      public function get rewardsList() : IItemListWindow
      {
         return _window.findChildByName("rewards_list") as IItemListWindow;
      }
      
      public function get claimButtonContainer() : IWindowController_1
      {
         return _window.findChildByName("claim_button_container") as IWindowController_1;
      }
      
      public function get claimButtonText() : ITextWindow
      {
         return _window.findChildByName("claim_txt") as ITextWindow;
      }
      
      public function get claimButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("claim_button") as UnknownICoreWindowComponents4;
      }
      
      public function get progressBarContainer() : IWindowController_1
      {
         return _window.findChildByName("progress_bar_wrapper") as IWindowController_1;
      }
   }
}

