package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.quest.seasonalcalendar.MainWindow;
   
   public class QuestController implements IComponentInterfaceQueue, IProfiler_1
   {
      private var _questEngine:HabboQuestEngine;
      
      private var _questsList:QuestsList;
      
      private var _questDetails:QuestDetails;
      
      private var UnknownVarFromQuestController_QuestCompleted_1:QuestCompleted;
      
      private var UnknownVarFromQuestController_NextQuestTimer_1:NextQuestTimer;
      
      private var _seasonalCalendarWindow:MainWindow;
      
      private var _questTrackers:Map;
      
      public function QuestController(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         _questTrackers = new Map();
         _questsList = new QuestsList(_questEngine);
         _questDetails = new QuestDetails(_questEngine);
         UnknownVarFromQuestController_QuestCompleted_1 = new QuestCompleted(_questEngine);
         UnknownVarFromQuestController_NextQuestTimer_1 = new NextQuestTimer(_questEngine);
         _seasonalCalendarWindow = new MainWindow(_questEngine);
      }
      
      public function onToolbarClick() : void
      {
         if(_questEngine.isSeasonalCalendarEnabled())
         {
            _seasonalCalendarWindow.onToolbarClick();
            _questsList.close();
         }
         else
         {
            _questsList.onToolbarClick();
         }
      }
      
      private function getOrCreateTracker(param1:String, param2:Boolean = true) : QuestTracker
      {
         var _loc3_:QuestTracker = _questTrackers.getValue(param1);
         if(_loc3_ == null && param2)
         {
            _loc3_ = new QuestTracker(_questEngine);
            _questTrackers.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      public function getTracker(param1:String) : QuestTracker
      {
         return getOrCreateTracker(param1,false);
      }
      
      private function cleanTrackers(param1:Boolean) : void
      {
         var _loc3_:QuestTracker = null;
         var _loc4_:Array = [];
         for each(var _loc2_ in _questTrackers.getKeys())
         {
            _loc3_ = _questTrackers.getValue(_loc2_);
            if(_loc3_.canBeDisposed || param1)
            {
               _loc3_.dispose();
               _loc4_.push(_loc2_);
            }
         }
         for each(_loc2_ in _loc4_)
         {
            _questTrackers.remove(_loc2_);
         }
      }
      
      public function onQuest(param1:QuestMessageData) : void
      {
         var _loc2_:QuestTracker = getOrCreateTracker(param1.campaignChainCode);
         _loc2_.onQuest(param1);
         if(_loc2_.campaignChainCode == null)
         {
            _questTrackers.remove(param1.campaignChainCode);
         }
         _questDetails.onQuest(param1);
         UnknownVarFromQuestController_QuestCompleted_1.onQuest(param1);
         UnknownVarFromQuestController_NextQuestTimer_1.onQuest(param1);
      }
      
      public function onQuestCompleted(param1:QuestMessageData, param2:Boolean) : void
      {
         var _loc3_:QuestTracker = getOrCreateTracker(param1.campaignChainCode);
         _loc3_.onQuestCompleted(param1,param2);
         _questDetails.onQuestCompleted(param1);
         UnknownVarFromQuestController_QuestCompleted_1.onQuestCompleted(param1,param2);
      }
      
      public function onQuestCancelled(param1:String) : void
      {
         var _loc2_:QuestTracker = getOrCreateTracker(param1,false);
         if(_loc2_ != null)
         {
            _loc2_.onQuestCancelled();
         }
         _questDetails.onQuestCancelled(param1);
         UnknownVarFromQuestController_QuestCompleted_1.onQuestCancelled();
         UnknownVarFromQuestController_NextQuestTimer_1.onQuestCancelled();
      }
      
      public function onRoomEnter() : void
      {
         var _loc1_:String = getDefaultCampaign();
         if(_loc1_ == null || _loc1_ == "")
         {
            return;
         }
         getOrCreateTracker(_loc1_).startDefaultCampaign(_loc1_);
      }
      
      public function onRoomExit() : void
      {
         _questsList.onRoomExit();
         _seasonalCalendarWindow.onRoomExit();
         for each(var _loc1_ in _questTrackers.getValues())
         {
            _loc1_.onRoomExit();
         }
         _questDetails.onRoomExit();
         UnknownVarFromQuestController_NextQuestTimer_1.onRoomExit();
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromQuestController_QuestCompleted_1.update(param1);
         for each(var _loc2_ in _questTrackers.getValues())
         {
            _loc2_.update(param1);
         }
         UnknownVarFromQuestController_NextQuestTimer_1.update(param1);
         _questsList.update(param1);
         _questDetails.update(param1);
         _seasonalCalendarWindow.update(param1);
         cleanTrackers(false);
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         if(_questsList)
         {
            _questsList.dispose();
            _questsList = null;
         }
         if(_questTrackers)
         {
            cleanTrackers(true);
            _questTrackers.dispose();
            _questTrackers = null;
         }
         if(_questDetails)
         {
            _questDetails.dispose();
            _questDetails = null;
         }
         if(UnknownVarFromQuestController_QuestCompleted_1)
         {
            UnknownVarFromQuestController_QuestCompleted_1.dispose();
            UnknownVarFromQuestController_QuestCompleted_1 = null;
         }
         if(UnknownVarFromQuestController_NextQuestTimer_1)
         {
            UnknownVarFromQuestController_NextQuestTimer_1.dispose();
            UnknownVarFromQuestController_NextQuestTimer_1 = null;
         }
         if(_seasonalCalendarWindow)
         {
            _seasonalCalendarWindow.dispose();
            _seasonalCalendarWindow = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function get questsList() : QuestsList
      {
         return _questsList;
      }
      
      public function get questDetails() : QuestDetails
      {
         return _questDetails;
      }
      
      public function get seasonalCalendarWindow() : MainWindow
      {
         return _seasonalCalendarWindow;
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         if(_seasonalCalendarWindow)
         {
            _seasonalCalendarWindow.onActivityPoints(param1,param2);
         }
      }
      
      public function getDefaultCampaign() : String
      {
         var _loc1_:String = _questEngine.getProperty("questing.defaultCampaign");
         return _loc1_ == null ? "" : _loc1_;
      }
   }
}

