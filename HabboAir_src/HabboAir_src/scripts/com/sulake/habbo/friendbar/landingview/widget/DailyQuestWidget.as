package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestDailyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.CancelQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetDailyQuestMessageComposer;
   import com.sulake.habbo.communication.messages.parser.quest.QuestDailyMessageParser;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.UnknownIHabboFriendbarLandingviewInterfaces2;
   
   public class DailyQuestWidget implements IComponentInterfaceQueue, ILandingViewWidget, ISlotAwareWidget, UnknownIHabboFriendbarLandingviewInterfaces2
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromDailyQuestWidget_QuestMessageData_1:QuestMessageData;
      
      private var UnknownVarFromDailyQuestWidget_Int_1:int;
      
      private var UnknownVarFromDailyQuestWidget_Int_2:int;
      
      private var _index:int;
      
      private var UnknownVarFromDailyQuestWidget_Int_3:int;
      
      private var UnknownVarFromDailyQuestWidget_Int_4:int;
      
      private var _configurationCode:String;
      
      public function DailyQuestWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public static function moveChildrenToRow(param1:IWindowController_1, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:IWindowModel = null;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc3_);
            _loc5_.x = _loc4_;
            _loc4_ += _loc5_.width + param2;
            _loc3_++;
         }
      }
      
      public function set configurationCode(param1:String) : void
      {
         _configurationCode = param1;
      }
      
      public function set slot(param1:int) : void
      {
         UnknownVarFromDailyQuestWidget_Int_4 = param1;
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
         UnknownVarFromDailyQuestWidget_QuestMessageData_1 = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("daily_quest"));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new QuestDailyMessageEvent(onDailyQuest));
         _container.findChildByName("accept_button").procedure = onAcceptButton;
         _container.findChildByName("go_button").procedure = onGoButton;
         _container.findChildByName("next_quest_region").procedure = onNextQuest;
         _container.findChildByName("cancel_quest_region").procedure = onCancelQuest;
         _container.findChildByName("easy_region").procedure = onEasyRegion;
         _container.findChildByName("hard_region").procedure = onHardRegion;
         var _loc1_:IWindowModel = _container.findChildByName("hdr_line");
         UnknownVarFromDailyQuestWidget_Int_3 = _loc1_.x + _loc1_.width;
         GenericWidget.configureLayout(_landingView,UnknownVarFromDailyQuestWidget_Int_4,_configurationCode,_container);
      }
      
      public function refresh() : void
      {
         _index = 0;
         _landingView.send(new GetDailyQuestMessageComposer(true,0));
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onDailyQuest(param1:IMessageEvent) : void
      {
         var _loc2_:QuestDailyMessageParser = QuestDailyMessageParser(param1.parser);
         UnknownVarFromDailyQuestWidget_QuestMessageData_1 = _loc2_.quest;
         UnknownVarFromDailyQuestWidget_Int_1 = _loc2_.easyQuestCount;
         UnknownVarFromDailyQuestWidget_Int_2 = _loc2_.hardQuestCount;
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         _container.findChildByName("caption_txt").caption = !!UnknownVarFromDailyQuestWidget_QuestMessageData_1 ? getChainSpecificText("chaincaption") : getText("landing.view.quest.currenttask.alldone.caption");
         _container.findChildByName("info_txt").caption = !!UnknownVarFromDailyQuestWidget_QuestMessageData_1 ? getChainSpecificText("chaininfo") : getText("landing.view.quest.currenttask.alldone.info");
         _container.findChildByName("accept_button").visible = UnknownVarFromDailyQuestWidget_QuestMessageData_1 && !UnknownVarFromDailyQuestWidget_QuestMessageData_1.accepted;
         _container.findChildByName("next_quest_region").visible = UnknownVarFromDailyQuestWidget_QuestMessageData_1 && !UnknownVarFromDailyQuestWidget_QuestMessageData_1.accepted && (UnknownVarFromDailyQuestWidget_QuestMessageData_1.easy ? UnknownVarFromDailyQuestWidget_Int_1 : UnknownVarFromDailyQuestWidget_Int_2) > 1;
         _container.findChildByName("next_quest_txt").caption = getText("landing.view.quest.nextquest." + (UnknownVarFromDailyQuestWidget_QuestMessageData_1 && UnknownVarFromDailyQuestWidget_QuestMessageData_1.easy ? "easy" : "hard"));
         _container.findChildByName("title_txt").caption = getText("landing.view.quest.title." + (UnknownVarFromDailyQuestWidget_QuestMessageData_1 && UnknownVarFromDailyQuestWidget_QuestMessageData_1.accepted ? "accepted" : "notaccepted"));
         HabboLandingView.positionAfterAndStretch(_container,"title_txt","hdr_line");
         _container.findChildByName("cancel_quest_region").visible = UnknownVarFromDailyQuestWidget_QuestMessageData_1 && UnknownVarFromDailyQuestWidget_QuestMessageData_1.accepted;
         _container.findChildByName("current_quest_border").visible = UnknownVarFromDailyQuestWidget_QuestMessageData_1 && UnknownVarFromDailyQuestWidget_QuestMessageData_1.accepted;
         if(UnknownVarFromDailyQuestWidget_QuestMessageData_1)
         {
            _landingView.localizationManager.registerParameter("landing.view.quest.currenttask","task",getQuestName());
         }
         var _loc1_:IWindowController_1 = IWindowController_1(_container.findChildByName("difficulty_container"));
         var _loc2_:int = _loc1_.x + _loc1_.width;
         _loc1_.visible = UnknownVarFromDailyQuestWidget_QuestMessageData_1 && !UnknownVarFromDailyQuestWidget_QuestMessageData_1.accepted && UnknownVarFromDailyQuestWidget_Int_1 > 0 && UnknownVarFromDailyQuestWidget_Int_2 > 0;
         setupDifficultyText("easy_region",UnknownVarFromDailyQuestWidget_QuestMessageData_1 && !UnknownVarFromDailyQuestWidget_QuestMessageData_1.easy);
         setupDifficultyText("hard_region",UnknownVarFromDailyQuestWidget_QuestMessageData_1 && UnknownVarFromDailyQuestWidget_QuestMessageData_1.easy);
         moveChildrenToRow(_loc1_,5);
         _loc1_.width = _loc1_.findChildByName("hard_region").x + _loc1_.findChildByName("hard_region").width;
         _loc1_.x = _loc2_ - _loc1_.width;
         var _loc4_:IWindowModel = _container.findChildByName("hdr_line");
         var _loc3_:int = int(!!_loc1_.visible ? _loc1_.x - 5 : UnknownVarFromDailyQuestWidget_Int_3);
         _loc4_.width = _loc3_ - _loc4_.x;
      }
      
      private function setupDifficultyText(param1:String, param2:Boolean) : void
      {
         var _loc4_:IWindowController_1 = IWindowController_1(_container.findChildByName(param1));
         var _loc3_:ITextWindow = ITextWindow(_loc4_.findChildByName("label_txt"));
         _loc3_.width = _loc3_.textWidth;
         _loc3_.underline = param2;
         _loc4_.width = _loc3_.width;
      }
      
      private function getChainSpecificKey(param1:String) : String
      {
         return "quests." + UnknownVarFromDailyQuestWidget_QuestMessageData_1.campaignCode + "." + UnknownVarFromDailyQuestWidget_QuestMessageData_1.chainCode + "." + param1;
      }
      
      private function getChainSpecificText(param1:String) : String
      {
         var _loc2_:String = getChainSpecificKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function getText(param1:String) : String
      {
         return "${" + param1 + "}";
      }
      
      private function onGoButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.goToRoom();
         }
      }
      
      private function onEasyRegion(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            sendGetDailyQuest(true);
         }
      }
      
      private function onHardRegion(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            sendGetDailyQuest(false);
         }
      }
      
      public function getQuestName() : String
      {
         var _loc1_:String = UnknownVarFromDailyQuestWidget_QuestMessageData_1.getQuestLocalizationKey() + ".name";
         return "${" + _loc1_ + "}";
      }
      
      private function onAcceptButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new ActivateQuestMessageComposer(UnknownVarFromDailyQuestWidget_QuestMessageData_1.id));
         }
      }
      
      private function onNextQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _index++;
            sendGetDailyQuest(UnknownVarFromDailyQuestWidget_QuestMessageData_1.easy);
         }
      }
      
      private function onCancelQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new CancelQuestMessageComposer());
         }
      }
      
      private function sendGetDailyQuest(param1:Boolean) : void
      {
         _landingView.send(new GetDailyQuestMessageComposer(param1,_index));
      }
   }
}

