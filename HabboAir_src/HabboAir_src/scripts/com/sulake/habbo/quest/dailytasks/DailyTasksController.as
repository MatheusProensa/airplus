package com.sulake.habbo.quest.dailytasks
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.quest.dailytasks.ClaimDailyTaskComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.dailytasks.GetDailyTasksComposer;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTaskInfo;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTasksActiveListMessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTasksActiveListMessageParser;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTasksTaskUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTasksTaskUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTasksTasksAddedMessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.dailytasks.DailyTasksTasksAddedMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.quest.events.UnseenDailyTasksCountUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.utils.getTimer;
   
   public class DailyTasksController extends Component implements ILinkEventTracker, UnknownIHabboQuestDailytasks1, IComponentInterfaceQueue, IProfiler_1
   {
      public static const REQUEST_TASKS_TIMEOUT_MS:int = 10000;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _questEngine:HabboQuestEngine;
      
      private var _view:DailyTasksView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _tasks:Vector.<DailyTaskInfo>;
      
      private var UnknownVarFromDailyTasksController_Vector_1:Vector.<DailyTaskInfo>;
      
      private var _lastRequestTime:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function DailyTasksController(param1:HabboQuestEngine, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _questEngine = param1;
         _tasks = new Vector.<DailyTaskInfo>();
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new DailyTasksActiveListMessageEvent(onActiveDailyTasks));
         _messageEvents.push(new DailyTasksTasksAddedMessageEvent(onTasksAdded));
         _messageEvents.push(new DailyTasksTaskUpdateMessageEvent(onTaskUpdated));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "dailytasks/";
      }
      
      public function linkReceived(param1:String) : void
      {
         if(!isEnabled)
         {
            return;
         }
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showView();
         }
      }
      
      public function toggleView() : void
      {
         if(isShowing())
         {
            hideView();
         }
         else
         {
            showView();
         }
      }
      
      private function showView() : void
      {
         if(!isEnabled)
         {
            return;
         }
         if(!viewExists())
         {
            _view = new DailyTasksView(this,_windowManager);
            _view.initialize();
         }
         _view.show();
      }
      
      private function hideView() : void
      {
         if(!viewExists())
         {
            return;
         }
         _view.hide();
      }
      
      private function isShowing() : Boolean
      {
         return viewExists() && _view.isShowing();
      }
      
      private function viewExists() : Boolean
      {
         return _view != null && !_view.disposed;
      }
      
      public function get isEnabled() : Boolean
      {
         return getBoolean("dailytasks.enabled");
      }
      
      private function clearTasks() : void
      {
         _tasks = new Vector.<DailyTaskInfo>();
         if(viewExists())
         {
            _view.tasksCleared();
         }
      }
      
      private function addTask(param1:DailyTaskInfo) : void
      {
         if(getTaskById(param1.taskId) != null)
         {
            return;
         }
         if(param1.secondsLeft < 0 && param1.status == DailyTaskInfo.UnknownVarFromDailyTaskInfo_Int_2)
         {
            UnknownVarFromDailyTasksController_Vector_1.push(param1);
         }
         _tasks.push(param1);
         if(viewExists())
         {
            _view.taskAdded(param1);
         }
      }
      
      private function updateUnseenTasks() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in _tasks)
         {
            if(_loc1_.status == DailyTaskInfo.UnknownVarFromDailyTaskInfo_Int_2)
            {
               _loc2_ += 1;
            }
         }
         _questEngine.events.dispatchEvent(new UnseenDailyTasksCountUpdateEvent(_loc2_));
      }
      
      private function updateWindowDimensions() : void
      {
         if(viewExists())
         {
            _view.taskAmountChanged();
         }
      }
      
      private function onActiveDailyTasks(param1:DailyTasksActiveListMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:DailyTasksActiveListMessageParser = param1.getParser() as DailyTasksActiveListMessageParser;
         clearTasks();
         for each(_loc2_ in _loc3_.tasks)
         {
            if(!_loc2_.isBonus)
            {
               addTask(_loc2_);
            }
         }
         for each(_loc2_ in _loc3_.tasks)
         {
            if(_loc2_.isBonus)
            {
               addTask(_loc2_);
            }
         }
         updateWindowDimensions();
         updateUnseenTasks();
      }
      
      private function onTasksAdded(param1:DailyTasksTasksAddedMessageEvent) : void
      {
         var _loc3_:DailyTasksTasksAddedMessageParser = param1.getParser() as DailyTasksTasksAddedMessageParser;
         for each(var _loc2_ in _loc3_.tasks)
         {
            addTask(_loc2_);
         }
         if(_loc3_.tasks.length > 0 && _loc3_.tasks[0].isBonus)
         {
            _questEngine.notifications.addItem(_localizationManager.getLocalization("dailytasks.bonus_available"),"info","icon_daily_tasks_png","dailytasks/open");
         }
         updateWindowDimensions();
         updateUnseenTasks();
      }
      
      private function onTaskUpdated(param1:DailyTasksTaskUpdateMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:DailyTasksTaskUpdateMessageParser = param1.getParser() as DailyTasksTaskUpdateMessageParser;
         var _loc2_:DailyTaskInfo = getTaskById(_loc3_.taskId);
         if(_loc2_ == null)
         {
            requestTasks();
         }
         else
         {
            _loc4_ = _loc2_.status;
            _loc2_.repeats = _loc3_.repeats;
            _loc2_.status = _loc3_.status;
            if(viewExists())
            {
               _view.taskUpdated(_loc2_.taskId);
            }
            if(_loc4_ != _loc2_.status)
            {
               if(_loc2_.status == DailyTaskInfo.UnknownVarFromDailyTaskInfo_Int_2)
               {
                  _questEngine.notifications.addItem(_localizationManager.getLocalization("dailytasks.completed.caption"),"info","icon_daily_tasks_png","dailytasks/open");
               }
               else if(_loc2_.status == DailyTaskInfo.UnknownVarFromDailyTaskInfo_Int_3)
               {
                  _questEngine.notifications.addItem(_localizationManager.getLocalization("dailytasks.claimed.caption"),"info","icon_daily_tasks_png","dailytasks/open");
               }
            }
         }
         updateUnseenTasks();
      }
      
      public function getTaskById(param1:Number) : DailyTaskInfo
      {
         for each(var _loc2_ in _tasks)
         {
            if(_loc2_.taskId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get tasks() : Vector.<DailyTaskInfo>
      {
         return _tasks;
      }
      
      public function requestTasks() : void
      {
         if(getTimer() <= _lastRequestTime + 10000)
         {
            return;
         }
         _lastRequestTime = getTimer();
         send(new GetDailyTasksComposer());
      }
      
      public function claimTask(param1:Number) : void
      {
         send(new ClaimDailyTaskComposer(param1));
      }
      
      public function update(param1:uint) : void
      {
         if(viewExists())
         {
            _view.update(param1);
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get questEngine() : HabboQuestEngine
      {
         return _questEngine;
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         _communicationManager = null;
         _windowManager = null;
         _localizationManager = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get view() : DailyTasksView
      {
         return _view;
      }
   }
}

