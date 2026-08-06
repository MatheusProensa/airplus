package com.sulake.habbo.quest.dailytasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTaskInfo;
   import com.sulake.habbo.quest.dailytasks.tasks.DailyTaskView;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.utils.getTimer;
   
   public class DailyTasksView implements IComponentInterfaceQueue, IProfiler_1
   {
      public static const UnknownConstFromDailyTasksView_Int_1:int = 500;
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromDailyTasksView_DailyTasksController_1:DailyTasksController;
      
      private var _window:IFrameController;
      
      private var _taskTemplate:UnknownICoreWindowComponents6;
      
      private var _rewardTemplate:IWindowController_1;
      
      private var UnknownVarFromDailyTasksView_Vector_1:Vector.<DailyTaskView>;
      
      private var _lastTitleUpdateTime:int = 0;
      
      private var UnknownVarFromDailyTasksView_UnclaimedTasksView_1:UnclaimedTasksView;
      
      private var _disposed:Boolean = false;
      
      public function DailyTasksView(param1:DailyTasksController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromDailyTasksView_DailyTasksController_1 = param1;
         _windowManager = param2;
         UnknownVarFromDailyTasksView_Vector_1 = new Vector.<DailyTaskView>();
         _window = param2.buildFromXML(XML(UnknownVarFromDailyTasksView_DailyTasksController_1.assets.getAssetByName("daily_tasks_xml").content),1) as IFrameController;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         unclaimedButton.addEventListener("WME_CLICK",onUnclaimedTasksOpen);
         getHCButton.addEventListener("WME_CLICK",onGetHcClicked);
         _taskTemplate = tasksList.removeListItemAt(0) as UnknownICoreWindowComponents6;
         _rewardTemplate = (_taskTemplate.findChildByName("rewards_list") as IItemListWindow).removeListItemAt(0) as IWindowController_1;
         UnknownVarFromDailyTasksView_UnclaimedTasksView_1 = new UnclaimedTasksView(UnknownVarFromDailyTasksView_DailyTasksController_1,param2);
      }
      
      public function initialize() : void
      {
         for each(var _loc1_ in UnknownVarFromDailyTasksView_DailyTasksController_1.tasks)
         {
            taskAdded(_loc1_);
         }
         taskAmountChanged();
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      private function onUnclaimedTasksOpen(param1:WindowMouseEvent) : void
      {
         UnknownVarFromDailyTasksView_UnclaimedTasksView_1.show();
      }
      
      private function onGetHcClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IHabboCatalog = UnknownVarFromDailyTasksView_DailyTasksController_1.questEngine.catalog;
         if(_loc2_)
         {
            _loc2_.openCatalogPage("hc_membership","NORMAL");
         }
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function taskAmountChanged() : void
      {
         var _loc1_:* = UnknownVarFromDailyTasksView_UnclaimedTasksView_1.taskViews.length > 0;
         extraCont.visible = _loc1_;
         var _loc2_:int = _loc1_ ? extraCont.height + mainContainer.spacing : 0;
         tasksList.y = _loc2_;
         tasksList.height = Math.min(Math.max(UnknownVarFromDailyTasksView_Vector_1.length,1),4) * (taskTemplate.height + tasksList.spacing) - tasksList.spacing;
         hcInfoBar.y = _loc2_ + tasksList.height + mainContainer.spacing;
         _window.height = 33 + _loc2_ + tasksList.height + mainContainer.spacing + hcInfoBar.height + mainContainer.spacing;
         _window.width = tasksList.isScrollBarVisible ? _window.limits.maxWidth : int(_window.limits.minWidth);
         extraCont.width = _window.width;
         hcInfoBar.width = _window.width;
         setHcDoubleDuckets();
      }
      
      private function setHcDoubleDuckets() : void
      {
         var _loc1_:Boolean = UnknownVarFromDailyTasksView_DailyTasksController_1.questEngine.sessionDataManager.hasClub;
         if(_loc1_)
         {
            hcDoubleDucketsInfoText.text = UnknownVarFromDailyTasksView_DailyTasksController_1.localizationManager.getLocalization("hc.has.double_duckets.info","You get double duckets as you are an HC member!");
         }
         else
         {
            hcDoubleDucketsInfoText.text = UnknownVarFromDailyTasksView_DailyTasksController_1.localizationManager.getLocalization("hc.get.double_duckets.info","Get HC membership to gain double duckets!");
         }
         getHCButton.visible = !_loc1_;
      }
      
      public function tasksCleared() : void
      {
         tasksList.removeListItems();
         for each(var _loc1_ in UnknownVarFromDailyTasksView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromDailyTasksView_Vector_1 = new Vector.<DailyTaskView>();
         UnknownVarFromDailyTasksView_UnclaimedTasksView_1.tasksCleared();
      }
      
      public function taskAdded(param1:DailyTaskInfo) : void
      {
         if(param1.isExpired)
         {
            UnknownVarFromDailyTasksView_UnclaimedTasksView_1.taskAdded(param1);
            return;
         }
         var _loc2_:DailyTaskView = new DailyTaskView(param1,UnknownVarFromDailyTasksView_DailyTasksController_1);
         UnknownVarFromDailyTasksView_Vector_1.push(_loc2_);
         tasksList.addListItem(_loc2_.window);
      }
      
      public function taskUpdated(param1:int) : void
      {
         var _loc2_:DailyTaskView = getTaskViewById(param1);
         if(_loc2_ == null)
         {
            UnknownVarFromDailyTasksView_UnclaimedTasksView_1.taskUpdated(param1);
            return;
         }
         _loc2_.updateStatusAndRepeatsUI();
      }
      
      public function getTaskViewById(param1:int) : DailyTaskView
      {
         for each(var _loc2_ in UnknownVarFromDailyTasksView_Vector_1)
         {
            if(_loc2_.dailyTask.taskId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc3_ in UnknownVarFromDailyTasksView_Vector_1)
         {
            _loc3_.update(param1);
         }
         var _loc5_:int = 0;
         for each(var _loc2_ in UnknownVarFromDailyTasksView_DailyTasksController_1.tasks)
         {
            if(_loc2_.secondsLeft > _loc5_)
            {
               _loc5_ = _loc2_.secondsLeft;
            }
         }
         var _loc4_:* = getTimer() > _lastTitleUpdateTime + 500;
         if(isShowing() && _loc4_)
         {
            if(_loc5_ > 0)
            {
               _window.caption = UnknownVarFromDailyTasksView_DailyTasksController_1.localizationManager.getLocalization("dailytasks.title") + " - " + UnknownVarFromDailyTasksView_DailyTasksController_1.localizationManager.getLocalizationWithParams("dailytasks.refreshes","Refresh in %time","time",FriendlyTime.getFriendlyTime(UnknownVarFromDailyTasksView_DailyTasksController_1.localizationManager,_loc5_));
            }
            else
            {
               _window.caption = UnknownVarFromDailyTasksView_DailyTasksController_1.localizationManager.getLocalization("dailytasks.title");
            }
            _lastTitleUpdateTime = getTimer();
         }
         if(UnknownVarFromDailyTasksView_DailyTasksController_1.tasks.length == 0 || _loc5_ < -5)
         {
            UnknownVarFromDailyTasksView_DailyTasksController_1.requestTasks();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromDailyTasksView_UnclaimedTasksView_1.dispose();
         UnknownVarFromDailyTasksView_UnclaimedTasksView_1 = null;
         for each(var _loc1_ in UnknownVarFromDailyTasksView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromDailyTasksView_Vector_1 = null;
         _taskTemplate = null;
         _rewardTemplate = null;
         hide();
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         unclaimedButton.removeEventListener("WME_CLICK",onUnclaimedTasksOpen);
         getHCButton.removeEventListener("WME_CLICK",onGetHcClicked);
         _window.dispose();
         _window = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get taskTemplate() : UnknownICoreWindowComponents6
      {
         return _taskTemplate;
      }
      
      public function get rewardTemplate() : IWindowController_1
      {
         return _rewardTemplate;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get unclaimedButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("unclaimed_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get tasksList() : IScrollableListWindow
      {
         return _window.findChildByName("tasks_list") as IScrollableListWindow;
      }
      
      private function get mainContainer() : IItemListWindow
      {
         return _window.findChildByName("main_cont") as IItemListWindow;
      }
      
      private function get extraCont() : IWindowController_1
      {
         return _window.findChildByName("extra_cont") as IWindowController_1;
      }
      
      private function get hcInfoBar() : IWindowController_1
      {
         return _window.findChildByName("hc_info_cont") as IWindowController_1;
      }
      
      private function get hcDoubleDucketsInfoText() : ITextWindow
      {
         return _window.findChildByName("hc_info_text") as ITextWindow;
      }
      
      private function get getHCButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("get_hc_btn") as UnknownICoreWindowComponents4;
      }
   }
}

