package com.sulake.habbo.quest
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
   import com.sulake.habbo.quest.events.QuestsListEvent;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.WindowToggle;
   import flash.display.BitmapData;
   
   public class QuestsList implements IComponentInterfaceQueue
   {
      private static const COL_SPACING:int = 5;
      
      private static const QUEST_LIST_SPACING:int = 10;
      
      private static const CANCEL_LINK_OFFSET_FROM_RIGHT:int = 10;
      
      private static const COMPLETION_TEXT_OFFSET_FROM_BOTTOM:int = 30;
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromQuestsList_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromQuestsList_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromQuestsList_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromQuestsList_IScrollbarWindow_1:IScrollbarWindow;
      
      private var UnknownVarFromQuestsList_Boolean_1:Boolean = true;
      
      private var UnknownVarFromQuestsList_Boolean_2:Boolean;
      
      private var UnknownVarFromQuestsList_WindowToggle_1:WindowToggle;
      
      private var UnknownVarFromQuestsList_Array_1:Array = [];
      
      private var _msecsToRefresh:int = 1000;
      
      private var UnknownVarFromQuestsList_Boolean_3:Boolean = false;
      
      public function QuestsList(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         _questEngine.events.addEventListener("qu_quests",onQuestsEvent);
      }
      
      public function dispose() : void
      {
         if(_questEngine)
         {
            _questEngine.events.removeEventListener("qu_quests",onQuestsEvent);
            _questEngine = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromQuestsList_WindowToggle_1)
         {
            UnknownVarFromQuestsList_WindowToggle_1.dispose();
            UnknownVarFromQuestsList_WindowToggle_1 = null;
         }
         UnknownVarFromQuestsList_IItemListWindow_1 = null;
         UnknownVarFromQuestsList_IScrollbarWindow_1 = null;
         UnknownVarFromQuestsList_Array_1 = null;
         UnknownVarFromQuestsList_ITextWindow_1 = null;
         UnknownVarFromQuestsList_UnknownICoreWindowComponents4_1 = null;
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
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function setOpenOnQuestsEvent() : void
      {
         UnknownVarFromQuestsList_Boolean_3 = true;
      }
      
      public function onToolbarClick() : void
      {
         setOpenOnQuestsEvent();
         if(!_window)
         {
            _questEngine.requestQuests();
            return;
         }
         if(!UnknownVarFromQuestsList_WindowToggle_1 || UnknownVarFromQuestsList_WindowToggle_1.disposed)
         {
            UnknownVarFromQuestsList_WindowToggle_1 = new WindowToggle(_window,_window.desktop,_questEngine.requestQuests,close);
         }
         UnknownVarFromQuestsList_WindowToggle_1.toggle();
         UnknownVarFromQuestsList_Boolean_1 = false;
      }
      
      private function onQuestsEvent(param1:QuestsListEvent) : void
      {
         var _loc2_:Boolean = UnknownVarFromQuestsList_Boolean_3;
         UnknownVarFromQuestsList_Boolean_3 = false;
         this.onQuests(param1.quests,_loc2_);
      }
      
      private function onQuests(param1:Array, param2:Boolean) : void
      {
         UnknownVarFromQuestsList_Array_1 = [];
         var _loc3_:QuestMessageData = null;
         for each(_loc3_ in param1)
         {
            if(!_questEngine.isSeasonalQuest(_loc3_))
            {
               UnknownVarFromQuestsList_Array_1.push(_loc3_);
            }
         }
         if(!this.isVisible() && !param2)
         {
            return;
         }
         refresh(false);
         this._window.visible = true;
         this._window.activate();
         UnknownVarFromQuestsList_Boolean_2 = false;
         for each(_loc3_ in param1)
         {
            if(_loc3_.accepted)
            {
               UnknownVarFromQuestsList_Boolean_2 = true;
            }
         }
      }
      
      private function refresh(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         prepareWindow();
         UnknownVarFromQuestsList_IItemListWindow_1.autoArrangeItems = false;
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ < UnknownVarFromQuestsList_Array_1.length)
            {
               refreshEntry(true,_loc3_,UnknownVarFromQuestsList_Array_1[_loc3_],param1);
            }
            else
            {
               _loc2_ = refreshEntry(false,_loc3_,null,param1);
               if(_loc2_)
               {
                  break;
               }
            }
            _loc3_++;
         }
         UnknownVarFromQuestsList_IItemListWindow_1.autoArrangeItems = true;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IFrameController(_questEngine.getXmlWindow("Quests"));
         _window.findChildByTag("close").procedure = onWindowClose;
         UnknownVarFromQuestsList_IItemListWindow_1 = IItemListWindow(_window.findChildByName("quest_list"));
         UnknownVarFromQuestsList_IScrollbarWindow_1 = IScrollbarWindow(_window.findChildByName("scroller"));
         UnknownVarFromQuestsList_ITextWindow_1 = ITextWindow(_window.findChildByName("hc_info_text"));
         UnknownVarFromQuestsList_UnknownICoreWindowComponents4_1 = UnknownICoreWindowComponents4(_window.findChildByName("get_hc_btn"));
         _window.center();
         UnknownVarFromQuestsList_IItemListWindow_1.spacing = 10;
         setupHcDoubleDucketsInfo();
      }
      
      private function setupHcDoubleDucketsInfo() : void
      {
         var _loc1_:Boolean = _questEngine.sessionDataManager.hasClub;
         if(_loc1_)
         {
            UnknownVarFromQuestsList_ITextWindow_1.text = _questEngine.localization.getLocalization("hc.has.double_duckets.info","You get double duckets as you are an HC member!");
         }
         else
         {
            UnknownVarFromQuestsList_ITextWindow_1.text = _questEngine.localization.getLocalization("hc.get.double_duckets.info","Get HC membership to gain double duckets!");
         }
         UnknownVarFromQuestsList_UnknownICoreWindowComponents4_1.visible = !_loc1_;
         UnknownVarFromQuestsList_UnknownICoreWindowComponents4_1.addEventListener("WME_CLICK",onClickGetHc);
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:QuestMessageData, param4:Boolean) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:IWindowController_1 = IWindowController_1(UnknownVarFromQuestsList_IItemListWindow_1.getListItemAt(param2));
         var _loc7_:Boolean = false;
         if(_loc6_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc6_ = createListEntry(onAcceptQuest,onCancelQuest);
            UnknownVarFromQuestsList_IItemListWindow_1.addListItem(_loc6_);
         }
         if(param1)
         {
            if(param4)
            {
               refreshDelay(_loc6_,param3);
            }
            else
            {
               refreshEntryDetails(_loc6_,param3);
            }
            if(param3.isSeasonal)
            {
               _loc5_ = refreshTimeLeft(_loc6_,param3);
               if(!_loc5_ && param3.accepted)
               {
                  _questEngine.send(new RejectQuestMessageComposer(param3.id));
               }
               _loc6_.visible = _loc5_;
            }
            else
            {
               _loc6_.visible = true;
            }
         }
         else
         {
            _loc6_.visible = false;
         }
         return false;
      }
      
      public function createListEntry(param1:Function, param2:Function) : IWindowController_1
      {
         var _loc3_:IWindowController_1 = IWindowController_1(_questEngine.getXmlWindow("QuestEntry"));
         var _loc6_:IWindowController_1 = IWindowController_1(_questEngine.getXmlWindow("Campaign"));
         var _loc9_:IWindowController_1 = IWindowController_1(_questEngine.getXmlWindow("Quest"));
         var _loc5_:IWindowController_1 = IWindowController_1(_questEngine.getXmlWindow("EntryArrows"));
         var _loc8_:IWindowController_1 = IWindowController_1(_questEngine.getXmlWindow("CampaignCompleted"));
         _loc3_.addChild(_loc6_);
         _loc3_.addChild(_loc9_);
         _loc3_.addChild(_loc8_);
         _loc3_.addChild(_loc5_);
         _loc9_.findChildByName("accept_button").procedure = param1;
         _loc9_.findChildByName("cancel_region").procedure = param2;
         _loc3_.findChildByName("hint_txt").visible = false;
         _loc3_.findChildByName("link_region").visible = false;
         var _loc7_:IWindowModel = _loc3_.findChildByName("cancel_region");
         var _loc4_:IWindowModel = _loc3_.findChildByName("cancel_txt");
         _loc7_.width = _loc4_.width;
         _loc7_.x = _loc9_.width - _loc7_.width - 10;
         _loc9_.x = _loc6_.x + _loc6_.width + 5;
         _loc3_.width = _loc9_.x + _loc9_.width;
         _loc8_.x = _loc9_.x;
         setEntryHeight(_loc3_);
         return _loc3_;
      }
      
      public function setEntryHeight(param1:IWindowController_1) : void
      {
         var _loc5_:IWindowController_1 = IWindowController_1(param1.findChildByName("campaign_container"));
         var _loc6_:IWindowController_1 = IWindowController_1(param1.findChildByName("quest_container"));
         var _loc4_:IWindowController_1 = IWindowController_1(param1.findChildByName("entry_arrows_cont"));
         _loc5_.height = _loc6_.height;
         param1.height = _loc6_.height;
         _loc4_.x = _loc5_.x + _loc5_.width - 2;
         _loc4_.y = Math.floor((_loc5_.height - _loc4_.height) / 2) + 1;
         _loc5_.findChildByName("completion_txt").y = _loc5_.height - 30;
         var _loc2_:int = 2;
         var _loc3_:IWindowModel = _loc5_.findChildByName("bg_bottom");
         _loc3_.height = Math.floor((_loc5_.height - 2 * _loc2_) / 2);
         _loc3_.y = _loc2_ + _loc3_.height;
      }
      
      public function refreshEntryDetails(param1:IWindowController_1, param2:QuestMessageData) : void
      {
         var _loc3_:IWindowModel = param1.findChildByName("campaign_header_txt");
         _loc3_.caption = _questEngine.getCampaignName(param2);
         _loc3_.y = _loc3_.height <= 17 ? 12 : 2;
         param1.findChildByName("completion_txt").caption = param2.completedQuestsInCampaign + "/" + param2.questCountInCampaign;
         _questEngine.setupCampaignImage(param1,param2,true);
         setColor(param1,"bg",param2.accepted,4290944315,4284769380);
         setColor(param1,"bg_top",param2.accepted,4294956936,4290427578);
         setColor(param1,"bg_bottom",param2.accepted,4294952792,4289440683);
         param1.findChildByName("completion_bg_red_bitmap").visible = !param2.completedCampaign && param2.completedQuestsInCampaign < 1;
         param1.findChildByName("completion_bg_blue_bitmap").visible = !param2.completedCampaign && param2.completedQuestsInCampaign > 0;
         param1.findChildByName("completion_bg_green_bitmap").visible = param2.completedCampaign;
         param1.findChildByName("arrow_0").visible = !param2.accepted;
         param1.findChildByName("arrow_1").visible = param2.accepted;
         param1.findChildByName("quest_container").visible = !param2.completedCampaign;
         param1.findChildByName("campaign_completed_container").visible = param2.completedCampaign;
         if(!param2.completedCampaign)
         {
            this.refreshEntryQuestDetails(IWindowController_1(param1.findChildByName("quest_container")),param2);
            refreshDelay(param1,param2);
         }
      }
      
      private function refreshEntryQuestDetails(param1:IWindowController_1, param2:QuestMessageData) : void
      {
         param1.findChildByName("quest_header_txt").caption = _questEngine.getQuestRowTitle(param2);
         param1.findChildByName("desc_txt").caption = _questEngine.getQuestDesc(param2);
         param1.findChildByName("timeleft_txt").visible = param2.isSeasonal;
         param1.findChildByName("hourglass_icon").visible = param2.isSeasonal;
         if(param2.isSeasonal)
         {
            param1.findChildByName("timeleft_txt").caption = FriendlyTime.getFriendlyTime(_questEngine.localization,param2.secondsLeft,".short",3);
            initHourglassIcon(param1);
         }
         param1.findChildByName("cancel_txt").visible = param2.accepted;
         param1.findChildByName("cancel_region").visible = param2.accepted;
         param1.findChildByName("cancel_region").id = param2.id;
         param1.findChildByName("accept_button").visible = !param2.accepted;
         param1.findChildByName("accept_button").id = param2.id;
         setColor(param1,null,param2.accepted,15982264,13158600);
         setColor(param1,"quest_header",param2.accepted,15577658,9276813);
         ITextWindow(param1.findChildByName("quest_header_txt")).textColor = param2.accepted ? 4294967295 : 4281808695;
         ITextWindow(param1.findChildByName("timeleft_txt")).textColor = param2.accepted ? 4294967295 : 4281808695;
         _questEngine.setupQuestImage(param1,param2);
         _questEngine.refreshReward(param2.waitPeriodSeconds < 1,param1,param2.activityPointType,param2.rewardCurrencyAmount);
         param1.findChildByName("delay_desc_txt").visible = param2.waitPeriodSeconds > 0;
         param1.findChildByName("delay_txt").visible = param2.waitPeriodSeconds > 0;
         param1.findChildByName("desc_txt").visible = param2.waitPeriodSeconds < 1;
      }
      
      private function initHourglassIcon(param1:IWindowController_1) : void
      {
         var _loc3_:IBitmapWrapperController = param1.findChildByName("hourglass_icon") as IBitmapWrapperController;
         if(_loc3_.bitmap != null)
         {
            return;
         }
         var _loc5_:ISoundAsset = _questEngine.assets.getAssetByName("icon_hourglass_png");
         var _loc4_:BitmapDataAsset = BitmapDataAsset(_loc5_);
         var _loc2_:BitmapData = BitmapData(_loc4_.content);
         _loc3_.bitmap = _loc2_.clone();
         _loc3_.width = _loc3_.bitmap.width;
         _loc3_.height = _loc3_.bitmap.height;
      }
      
      public function refreshDelay(param1:IWindowController_1, param2:QuestMessageData) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(param1.findChildByName("delay_desc_txt").visible)
         {
            _loc3_ = param2.waitPeriodSeconds;
            if(_loc3_ <= 0)
            {
               this.refreshEntryQuestDetails(param1,param2);
               return true;
            }
            _loc4_ = FriendlyTime.getFriendlyTime(_questEngine.localization,_loc3_);
            param1.findChildByName("delay_txt").caption = _loc4_;
         }
         return false;
      }
      
      public function refreshTimeLeft(param1:IWindowController_1, param2:QuestMessageData) : Boolean
      {
         var _loc3_:int = 0;
         if(param1.findChildByName("timeleft_txt").visible)
         {
            _loc3_ = param2.secondsLeft;
            if(_loc3_ < 0)
            {
               return false;
            }
            param1.findChildByName("timeleft_txt").caption = FriendlyTime.getFriendlyTime(_questEngine.localization,_loc3_,".short",3);
         }
         return true;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:* = false;
         if(param1.type == "WME_CLICK")
         {
            close();
            _loc3_ = _questEngine.getInteger("new.identity",0) > 0;
            if(_loc3_ && UnknownVarFromQuestsList_Boolean_1 && !UnknownVarFromQuestsList_Boolean_2)
            {
               UnknownVarFromQuestsList_Boolean_1 = false;
               _questEngine.habboHelp.showWelcomeScreen("HTIE_ICON_PROGRESSION","quests.rejectnotification",0);
            }
         }
      }
      
      private function onAcceptQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("Accept quest: " + _loc3_);
         _questEngine.send(new AcceptQuestMessageComposer(_loc3_));
      }
      
      private function onCancelQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("Reject quest: " + _loc3_);
         _questEngine.send(new RejectQuestMessageComposer(_loc3_));
      }
      
      private function onClickGetHc(param1:WindowMouseEvent) : void
      {
         if(_questEngine.catalog)
         {
            _questEngine.catalog.openCatalogPage("hc_membership","NORMAL");
         }
      }
      
      private function setColor(param1:IWindowController_1, param2:String, param3:Boolean, param4:uint, param5:uint) : void
      {
         (param2 == null ? param1 : param1.findChildByName(param2)).color = param3 ? param4 : param5;
      }
      
      public function onAlert(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK" || param2.type == "WE_CANCEL")
         {
            param1.dispose();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(_window == null || !_window.visible)
         {
            return;
         }
         _msecsToRefresh -= param1;
         if(_msecsToRefresh > 0)
         {
            return;
         }
         _msecsToRefresh = 1000;
         refresh(true);
      }
   }
}

