package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
   
   public class QuestCompleted implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromQuestCompleted_Int_1:int = 2000;
      
      private static const TEXT_HEIGHT_SPACING:int = 5;
      
      private static const MIN_DESC_HEIGHT:int = 31;
      
      private var _window:IFrameController;
      
      private var _questEngine:HabboQuestEngine;
      
      private var UnknownVarFromQuestCompleted_QuestMessageData_1:QuestMessageData;
      
      private var UnknownVarFromQuestCompleted_Animation_1:Animation;
      
      private var UnknownVarFromQuestCompleted_Int_1:int;
      
      public function QuestCompleted(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         UnknownVarFromQuestCompleted_QuestMessageData_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromQuestCompleted_Animation_1)
         {
            UnknownVarFromQuestCompleted_Animation_1.dispose();
            UnknownVarFromQuestCompleted_Animation_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function onQuest(param1:QuestMessageData) : void
      {
         close();
      }
      
      public function onQuestCancelled() : void
      {
         close();
      }
      
      public function onQuestCompleted(param1:QuestMessageData, param2:Boolean) : void
      {
         if(param2)
         {
            prepare(param1);
            UnknownVarFromQuestCompleted_Int_1 = 2000;
         }
      }
      
      private function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function onNextQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _window.visible = false;
         _questEngine.questController.questDetails.openForNextQuest = _questEngine.getBoolean("questing.showDetailsForNextQuest");
         _questEngine.send(new OpenQuestTrackerMessageComposer());
      }
      
      private function onMoreQuests(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _window.visible = false;
            _questEngine.questController.questsList.setOpenOnQuestsEvent();
            _questEngine.send(new GetQuestsMessageComposer());
         }
      }
      
      public function prepare(param1:QuestMessageData) : void
      {
         UnknownVarFromQuestCompleted_QuestMessageData_1 = param1;
         if(_window == null)
         {
            _window = IFrameController(_questEngine.getXmlWindow("QuestCompletedDialog"));
            _window.findChildByTag("close").procedure = onNextQuest;
            _window.findChildByName("next_quest_button").procedure = onNextQuest;
            _window.findChildByName("more_quests_button").procedure = onMoreQuests;
            _window.findChildByName("catalog_link_region").procedure = onCatalogLink;
            UnknownVarFromQuestCompleted_Animation_1 = _questEngine.getTwinkleAnimation(_window);
         }
         _window.findChildByName("catalog_link_txt").caption = _questEngine.localization.getLocalizationWithParams("quests.completed.cataloglink","","currencyname",_questEngine.catalog.getActivityPointName(UnknownVarFromQuestCompleted_QuestMessageData_1.activityPointType));
         var _loc2_:String = "quests.completed.reward";
         _questEngine.localization.registerParameter(_loc2_,"amount",UnknownVarFromQuestCompleted_QuestMessageData_1.rewardCurrencyAmount.toString());
         _questEngine.localization.registerParameter(_loc2_,"currencyname",_questEngine.catalog.getActivityPointName(UnknownVarFromQuestCompleted_QuestMessageData_1.activityPointType));
         _window.findChildByName("reward_txt").caption = _questEngine.localization.getLocalization(_loc2_,_loc2_);
         _window.findChildByName("reward_txt").visible = UnknownVarFromQuestCompleted_QuestMessageData_1.activityPointType >= 0 && UnknownVarFromQuestCompleted_QuestMessageData_1.rewardCurrencyAmount > 0;
         _window.visible = false;
         _window.findChildByName("congrats_txt").caption = _questEngine.localization.getLocalization(UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign ? "quests.completed.campaign.caption" : "quests.completed.quest.caption");
         _window.findChildByName("more_quests_button").visible = UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign;
         _window.findChildByName("campaign_reward_icon").visible = UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign;
         _window.findChildByName("catalog_link_region").visible = !UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign && UnknownVarFromQuestCompleted_QuestMessageData_1.rewardCurrencyAmount > 0;
         _window.findChildByName("next_quest_button").visible = !UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign;
         _window.findChildByName("reward_icon").visible = !UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign;
         _window.findChildByName("campaign_reward_icon").visible = UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign;
         _window.findChildByName("campaign_pic_bitmap").visible = UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign;
         setWindowTitle(UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign ? "quests.completed.campaign.title" : "quests.completed.quest.title");
         _questEngine.setupCampaignImage(_window,param1,UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign);
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("desc_txt"));
         var _loc3_:int = int(_loc5_.height);
         setDesc(UnknownVarFromQuestCompleted_QuestMessageData_1.getQuestLocalizationKey() + ".completed");
         _loc5_.height = Math.max(31,_loc5_.textHeight + 5);
         var _loc4_:int = _loc5_.height - _loc3_;
         _window.height += _loc4_;
      }
      
      private function setWindowTitle(param1:String) : void
      {
         _questEngine.localization.registerParameter(param1,"category",_questEngine.getCampaignName(UnknownVarFromQuestCompleted_QuestMessageData_1));
         _window.caption = _questEngine.localization.getLocalization(param1,param1);
      }
      
      private function setDesc(param1:String) : void
      {
         _window.findChildByName("desc_txt").caption = _questEngine.localization.getLocalization(param1,param1);
      }
      
      private function onCatalogLink(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.openCatalog(UnknownVarFromQuestCompleted_QuestMessageData_1);
         }
      }
      
      public function update(param1:uint) : void
      {
         if(UnknownVarFromQuestCompleted_Int_1 > 0)
         {
            UnknownVarFromQuestCompleted_Int_1 -= param1;
            if(UnknownVarFromQuestCompleted_Int_1 < 1)
            {
               _window.center();
               _window.visible = true;
               _window.activate();
               if(UnknownVarFromQuestCompleted_QuestMessageData_1.lastQuestInCampaign)
               {
                  UnknownVarFromQuestCompleted_Animation_1.restart();
               }
               else
               {
                  UnknownVarFromQuestCompleted_Animation_1.stop();
               }
            }
         }
         if(UnknownVarFromQuestCompleted_Animation_1 != null)
         {
            UnknownVarFromQuestCompleted_Animation_1.update(param1);
         }
      }
   }
}

