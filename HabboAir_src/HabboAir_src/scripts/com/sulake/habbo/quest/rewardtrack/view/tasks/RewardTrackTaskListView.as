package com.sulake.habbo.quest.rewardtrack.view.tasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTask;
   import com.sulake.habbo.quest.rewardtrack.view.theme.RewardTrackTheme;
   
   public class RewardTrackTaskListView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromRewardTrackTaskListView_RewardTrackController_1:RewardTrackController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRewardTrackTaskListView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1:RewardTrackTaskDetailsView;
      
      private var UnknownVarFromRewardTrackTaskListView_RewardTrack_1:RewardTrack;
      
      private var _theme:RewardTrackTheme;
      
      private var UnknownVarFromRewardTrackTaskListView_Int_1:int = 0;
      
      private var UnknownVarFromRewardTrackTaskListView_Vector_1:Vector.<RewardTrackTaskFilterButtonView>;
      
      private var UnknownVarFromRewardTrackTaskListView_Vector_2:Vector.<RewardTrackTaskRowView>;
      
      private var UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1:RewardTrackTask;
      
      private var UnknownVarFromRewardTrackTaskListView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function RewardTrackTaskListView(param1:RewardTrackController, param2:IWindowController_1, param3:IWindowController_1, param4:RewardTrackTaskDetailsView, param5:RewardTrack, param6:RewardTrackTheme)
      {
         super();
         UnknownVarFromRewardTrackTaskListView_RewardTrackController_1 = param1;
         _window = param2;
         UnknownVarFromRewardTrackTaskListView_IWindowController_1_1 = param3;
         UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1 = param4;
         UnknownVarFromRewardTrackTaskListView_RewardTrack_1 = param5;
         _theme = param6;
         UnknownVarFromRewardTrackTaskListView_Vector_1 = new Vector.<RewardTrackTaskFilterButtonView>();
         UnknownVarFromRewardTrackTaskListView_Vector_2 = new Vector.<RewardTrackTaskRowView>();
         getPremiumButton.addEventListener("WME_CLICK",onGetPremiumClicked);
         initializeFilters();
         initializeTasks();
      }
      
      private function initializeFilters() : void
      {
         var _loc1_:IRegionWindow = tabSelection.removeListItemAt(0) as IRegionWindow;
         var _loc3_:IRegionWindow = tabSelection.removeListItemAt(0) as IRegionWindow;
         var _loc2_:IRegionWindow = tabSelection.removeListItemAt(0) as IRegionWindow;
         UnknownVarFromRewardTrackTaskListView_Vector_1.push(new RewardTrackTaskFilterButtonView(_loc1_,0,"reward_track.tasks.tab.all_tasks",this,_theme));
         UnknownVarFromRewardTrackTaskListView_Vector_1.push(new RewardTrackTaskFilterButtonView(_loc3_,1,"reward_track.tasks.tab.in_progress",this,_theme));
         UnknownVarFromRewardTrackTaskListView_Vector_1.push(new RewardTrackTaskFilterButtonView(_loc2_,2,"reward_track.tasks.tab.completed",this,_theme));
         for each(var _loc4_ in UnknownVarFromRewardTrackTaskListView_Vector_1)
         {
            tabSelection.addListItem(_loc4_.window);
         }
         refreshFilterButtons();
      }
      
      private function initializeTasks() : void
      {
         for each(var _loc1_ in UnknownVarFromRewardTrackTaskListView_RewardTrack_1.tasks)
         {
            UnknownVarFromRewardTrackTaskListView_Vector_2.push(new RewardTrackTaskRowView(UnknownVarFromRewardTrackTaskListView_IWindowController_1_1,UnknownVarFromRewardTrackTaskListView_RewardTrackController_1,this,_loc1_,_theme));
         }
         applyFilter();
         refresh(false);
      }
      
      public function setFilter(param1:int) : void
      {
         if(UnknownVarFromRewardTrackTaskListView_Int_1 == param1)
         {
            return;
         }
         UnknownVarFromRewardTrackTaskListView_Int_1 = param1;
         refreshFilterButtons();
         applyFilter();
      }
      
      public function selectTask(param1:RewardTrackTask) : void
      {
         var _loc3_:RewardTrackTaskRowView = null;
         if(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 != null && UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 != param1)
         {
            _loc3_ = getRowView(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1);
            if(_loc3_ != null)
            {
               _loc3_.setSelected(false);
            }
         }
         UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 = param1;
         var _loc2_:RewardTrackTaskRowView = getRowView(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1);
         if(_loc2_ != null)
         {
            _loc2_.setSelected(true);
         }
         UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1.selectTask(param1,UnknownVarFromRewardTrackTaskListView_Boolean_1);
      }
      
      public function refresh(param1:Boolean) : void
      {
         UnknownVarFromRewardTrackTaskListView_Boolean_1 = param1;
         refreshTasksCompletion();
         refreshPremiumInfo();
         for each(var _loc2_ in UnknownVarFromRewardTrackTaskListView_Vector_2)
         {
            _loc2_.refresh(param1);
         }
         if(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 != null)
         {
            UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1.refresh(param1);
         }
         applyFilter();
      }
      
      public function taskProgressUpdated(param1:RewardTrackTask, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         UnknownVarFromRewardTrackTaskListView_Boolean_1 = param4;
         var _loc5_:RewardTrackTaskRowView = getRowView(param1);
         if(_loc5_ != null)
         {
            _loc5_.refresh(param4);
         }
         if(param3 != param1.isComplete)
         {
            refreshTasksCompletion();
         }
         if(hasFilterMembershipChanged(param1,param2,param3))
         {
            applyFilter();
         }
         if(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 == param1)
         {
            UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1.refresh(param4);
         }
      }
      
      public function premiumUpdated() : void
      {
         refreshPremiumInfo();
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc2_ in UnknownVarFromRewardTrackTaskListView_Vector_2)
         {
            _loc2_.update(param1);
         }
         UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1.update(param1);
      }
      
      private function applyFilter() : void
      {
         tasksList.removeListItems();
         var _loc1_:RewardTrackTask = null;
         for each(var _loc2_ in UnknownVarFromRewardTrackTaskListView_Vector_2)
         {
            if(matchesFilter(_loc2_.task))
            {
               tasksList.addListItem(_loc2_.window);
               if(_loc1_ == null)
               {
                  _loc1_ = _loc2_.task;
               }
            }
         }
         if(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 == null || !matchesFilter(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1))
         {
            if(_loc1_ != null)
            {
               selectTask(_loc1_);
            }
            else
            {
               clearSelectedTask();
               UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1.clear();
            }
         }
      }
      
      private function clearSelectedTask() : void
      {
         var _loc1_:RewardTrackTaskRowView = null;
         if(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 != null)
         {
            _loc1_ = getRowView(UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1);
            if(_loc1_ != null)
            {
               _loc1_.setSelected(false);
            }
         }
         UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 = null;
      }
      
      private function matchesFilter(param1:RewardTrackTask) : Boolean
      {
         if(UnknownVarFromRewardTrackTaskListView_Int_1 == 1)
         {
            return param1.hasProgress && !param1.isComplete;
         }
         if(UnknownVarFromRewardTrackTaskListView_Int_1 == 2)
         {
            return param1.isComplete;
         }
         return true;
      }
      
      private function hasFilterMembershipChanged(param1:RewardTrackTask, param2:Boolean, param3:Boolean) : Boolean
      {
         if(UnknownVarFromRewardTrackTaskListView_Int_1 == 1)
         {
            return param2 != param1.hasProgress || param3 != param1.isComplete;
         }
         if(UnknownVarFromRewardTrackTaskListView_Int_1 == 2)
         {
            return param3 != param1.isComplete;
         }
         return false;
      }
      
      private function getRowView(param1:RewardTrackTask) : RewardTrackTaskRowView
      {
         for each(var _loc2_ in UnknownVarFromRewardTrackTaskListView_Vector_2)
         {
            if(_loc2_.task == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function refreshTasksCompletion() : void
      {
         tasksCompletionText.text = UnknownVarFromRewardTrackTaskListView_RewardTrackController_1.localizationManager.getLocalizationWithParams("reward_track.tasks.progress","","progress",UnknownVarFromRewardTrackTaskListView_RewardTrack_1.completedTaskCount,"total",UnknownVarFromRewardTrackTaskListView_RewardTrack_1.totalTaskCount);
      }
      
      private function refreshPremiumInfo() : void
      {
         rewardInfo.visible = !UnknownVarFromRewardTrackTaskListView_RewardTrack_1.hasPremiumConfig || UnknownVarFromRewardTrackTaskListView_RewardTrack_1.premium;
         rewardInfoNotPremium.visible = UnknownVarFromRewardTrackTaskListView_RewardTrack_1.hasPremiumConfig && !UnknownVarFromRewardTrackTaskListView_RewardTrack_1.premium;
      }
      
      private function refreshFilterButtons() : void
      {
         for each(var _loc1_ in UnknownVarFromRewardTrackTaskListView_Vector_1)
         {
            _loc1_.setActive(_loc1_.window == UnknownVarFromRewardTrackTaskListView_Vector_1[UnknownVarFromRewardTrackTaskListView_Int_1].window);
         }
      }
      
      private function onGetPremiumClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskListView_RewardTrackController_1.openPremiumPurchaseConfirmation(UnknownVarFromRewardTrackTaskListView_RewardTrack_1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         getPremiumButton.removeEventListener("WME_CLICK",onGetPremiumClicked);
         tasksList.removeListItems();
         for each(var _loc1_ in UnknownVarFromRewardTrackTaskListView_Vector_2)
         {
            _loc1_.dispose();
         }
         for each(var _loc2_ in UnknownVarFromRewardTrackTaskListView_Vector_1)
         {
            _loc2_.dispose();
         }
         UnknownVarFromRewardTrackTaskListView_Vector_2 = null;
         UnknownVarFromRewardTrackTaskListView_Vector_1 = null;
         UnknownVarFromRewardTrackTaskListView_RewardTrackController_1 = null;
         _window = null;
         UnknownVarFromRewardTrackTaskListView_IWindowController_1_1 = null;
         UnknownVarFromRewardTrackTaskListView_RewardTrackTaskDetailsView_1 = null;
         UnknownVarFromRewardTrackTaskListView_RewardTrack_1 = null;
         _theme = null;
         UnknownVarFromRewardTrackTaskListView_RewardTrackTask_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get tasksCompletionText() : ITextWindow
      {
         return _window.findChildByName("tasks_completion_txt") as ITextWindow;
      }
      
      private function get tabSelection() : IItemListWindow
      {
         return _window.findChildByName("tab_selection") as IItemListWindow;
      }
      
      private function get tasksList() : IScrollableListWindow
      {
         return _window.findChildByName("tasks") as IScrollableListWindow;
      }
      
      private function get rewardInfo() : IWindowController_1
      {
         return _window.findChildByName("reward_info") as IWindowController_1;
      }
      
      private function get rewardInfoNotPremium() : IWindowController_1
      {
         return _window.findChildByName("reward_info_not_premium") as IWindowController_1;
      }
      
      private function get getPremiumButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("get_premium_btn") as UnknownICoreWindowComponents4;
      }
   }
}

