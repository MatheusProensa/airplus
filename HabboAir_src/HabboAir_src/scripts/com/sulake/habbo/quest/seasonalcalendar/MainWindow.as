package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.quest.QuestTracker;
   import com.sulake.habbo.quest.events.QuestCompletedEvent;
   import com.sulake.habbo.quest.events.QuestsListEvent;
   import com.sulake.habbo.utils.WindowToggle;
   
   public class MainWindow implements IComponentInterfaceQueue
   {
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromMainWindow_WindowToggle_1:WindowToggle;
      
      private var _calendar:Calendar;
      
      private var _catalogPromo:CatalogPromo;
      
      private var UnknownVarFromMainWindow_RareTeaser_1:RareTeaser;
      
      private var UnknownVarFromMainWindow_Boolean_1:Boolean = false;
      
      private var _currentDay:int;
      
      public function MainWindow(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         _calendar = new Calendar(_questEngine,this);
         _catalogPromo = new CatalogPromo(_questEngine,this);
         UnknownVarFromMainWindow_RareTeaser_1 = new RareTeaser(_questEngine);
         _questEngine.events.addEventListener("qe_quests_seasonal",onSeasonalQuests);
         _questEngine.events.addEventListener("qce_seasonal",onSeasonalQuestCompleted);
      }
      
      public function dispose() : void
      {
         if(_questEngine)
         {
            _questEngine.events.removeEventListener("qe_quests_seasonal",onSeasonalQuests);
            _questEngine.events.removeEventListener("qce_seasonal",onSeasonalQuestCompleted);
            _questEngine = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromMainWindow_WindowToggle_1)
         {
            UnknownVarFromMainWindow_WindowToggle_1.dispose();
            UnknownVarFromMainWindow_WindowToggle_1 = null;
         }
         if(_calendar)
         {
            _calendar.close();
            _calendar.dispose();
            _calendar = null;
         }
         if(_catalogPromo)
         {
            _catalogPromo.dispose();
            _catalogPromo = null;
         }
         if(UnknownVarFromMainWindow_RareTeaser_1)
         {
            UnknownVarFromMainWindow_RareTeaser_1.dispose();
            UnknownVarFromMainWindow_RareTeaser_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function isVisible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function close() : void
      {
         if(_calendar)
         {
            _calendar.close();
         }
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(!_window)
         {
            _questEngine.requestSeasonalQuests();
            return;
         }
         if(!UnknownVarFromMainWindow_WindowToggle_1 || UnknownVarFromMainWindow_WindowToggle_1.disposed)
         {
            UnknownVarFromMainWindow_WindowToggle_1 = new WindowToggle(_window,_window.desktop,_questEngine.requestSeasonalQuests,close);
         }
         UnknownVarFromMainWindow_WindowToggle_1.toggle();
      }
      
      public function getCalendarImageGalleryHost() : String
      {
         var _loc1_:String = _questEngine.getSeasonalCampaignCodePrefix();
         return _questEngine.configuration.getProperty("image.library.url") + _loc1_ + "_quest_calendar/";
      }
      
      public function onQuests(param1:Array, param2:Boolean) : void
      {
         if(!this.isVisible() && !param2)
         {
            return;
         }
         _currentDay = resolveCurrentDay(param1);
         _calendar.onQuests(param1);
         refresh();
         if(param2)
         {
            this._window.visible = true;
            this._window.activate();
         }
      }
      
      private function onSeasonalQuests(param1:QuestsListEvent) : void
      {
         this.onQuests(param1.quests,true);
      }
      
      private function onSeasonalQuestCompleted(param1:QuestCompletedEvent) : void
      {
         var _loc2_:QuestTracker = _questEngine.questController.getTracker(param1.questData.campaignChainCode);
         if(_loc2_ != null)
         {
            _loc2_.forceWindowCloseAfterAnimationsFinished();
         }
         _questEngine.requestSeasonalQuests();
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         _catalogPromo.onActivityPoints(param1,param2);
      }
      
      private function resolveCurrentDay(param1:Array) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            if(_questEngine.isSeasonalQuest(_loc3_))
            {
               _loc2_ = Math.max(_loc2_,_loc3_.sortOrder);
            }
         }
         return _loc2_;
      }
      
      private function refresh() : void
      {
         prepareWindow();
         _calendar.refresh();
         _catalogPromo.refresh();
         UnknownVarFromMainWindow_RareTeaser_1.refresh();
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IFrameController(_questEngine.getXmlWindow("SeasonalCalendar"));
         var _loc1_:String = "quests." + _questEngine.getSeasonalCampaignCodePrefix() + ".title";
         _window.caption = _questEngine.localization.getLocalizationWithParams(_loc1_,_loc1_);
         _window.findChildByTag("close").procedure = onWindowClose;
         _calendar.prepare(_window);
         _catalogPromo.prepare(_window);
         UnknownVarFromMainWindow_RareTeaser_1.prepare(_window);
         _window.center();
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      public function get currentDay() : int
      {
         return _currentDay;
      }
      
      public function get catalogPromo() : CatalogPromo
      {
         return _catalogPromo;
      }
      
      public function update(param1:uint) : void
      {
         if(_questEngine.configuration != null && _questEngine.isFirstLoginOfDay && !UnknownVarFromMainWindow_Boolean_1 && _questEngine.isSeasonalCalendarEnabled())
         {
            _questEngine.requestSeasonalQuests();
            UnknownVarFromMainWindow_Boolean_1 = true;
         }
      }
   }
}

