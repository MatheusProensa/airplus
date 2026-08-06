package com.sulake.habbo.quest.dailytasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTaskInfo;
   import com.sulake.habbo.quest.dailytasks.tasks.DailyTaskView;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class UnclaimedTasksView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromUnclaimedTasksView_DailyTasksController_1:DailyTasksController;
      
      private var _window:IFrameController;
      
      private var _taskViews:Vector.<DailyTaskView>;
      
      public function UnclaimedTasksView(param1:DailyTasksController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromUnclaimedTasksView_DailyTasksController_1 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(param1.assets.getAssetByName("dailytasks_unclaimed_xml").content)) as IFrameController;
         _taskViews = new Vector.<DailyTaskView>();
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         show();
         hide();
         tasksList.autoHideScrollBar = false;
      }
      
      public function tasksCleared() : void
      {
         tasksList.removeListItems();
         for each(var _loc1_ in _taskViews)
         {
            _loc1_.dispose();
         }
         _taskViews = new Vector.<DailyTaskView>();
      }
      
      public function taskAdded(param1:DailyTaskInfo) : void
      {
         var _loc2_:DailyTaskView = new DailyTaskView(param1,UnknownVarFromUnclaimedTasksView_DailyTasksController_1);
         _taskViews.push(_loc2_);
         tasksList.addListItem(_loc2_.window);
      }
      
      public function taskUpdated(param1:int) : void
      {
         var _loc2_:DailyTaskView = getTaskViewById(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.updateStatusAndRepeatsUI();
      }
      
      public function getTaskViewById(param1:int) : DailyTaskView
      {
         for each(var _loc2_ in _taskViews)
         {
            if(_loc2_.dailyTask.taskId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         _window.x = Math.max(_window.x,0);
         _window.y = Math.max(_window.y,0);
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         _window.activate();
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function get taskViews() : Vector.<DailyTaskView>
      {
         return _taskViews;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc1_ in _taskViews)
         {
            _loc1_.dispose();
         }
         _taskViews = null;
         hide();
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         _window.dispose();
         _window = null;
         _windowManager = null;
         UnknownVarFromUnclaimedTasksView_DailyTasksController_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get tasksList() : IScrollableListWindow
      {
         return _window.findChildByName("tasks_list") as IScrollableListWindow;
      }
      
      private function get mainContainer() : IItemListWindow
      {
         return _window.findChildByName("main_cont") as IItemListWindow;
      }
   }
}

