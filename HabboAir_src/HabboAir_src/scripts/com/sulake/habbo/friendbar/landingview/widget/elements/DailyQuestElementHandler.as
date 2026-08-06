package com.sulake.habbo.friendbar.landingview.widget.elements
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
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements1;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class DailyQuestElementHandler implements IElementHandler, UnknownIHabboFriendbarLandingviewInterfacesElements1, IComponentInterfaceQueue
   {
      private var _landingView:HabboLandingView;
      
      private var UnknownVarFromDailyQuestElementHandler_GenericWidget_1:GenericWidget;
      
      private var _window:IWindowController_1;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromDailyQuestElementHandler_QuestMessageData_1:QuestMessageData;
      
      private var UnknownVarFromDailyQuestElementHandler_Int_1:int;
      
      private var UnknownVarFromDailyQuestElementHandler_Int_2:int;
      
      private var _index:int;
      
      private var _isFloating:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var _campaignCode:String = "";
      
      private var _chainCode:String = "";
      
      public function DailyQuestElementHandler()
      {
         super();
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
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         UnknownVarFromDailyQuestElementHandler_GenericWidget_1 = param4;
         _landingView = param1;
         _window = param2 as IWindowController_1;
         if(param3.length > 2)
         {
            _isFloating = param3[2] == "true";
         }
         if(param3.length > 3)
         {
            param2.x = int(param3[3]);
         }
         if(param3.length > 4)
         {
            param2.y = int(param3[4]);
         }
         if(param3.length > 5)
         {
            _campaignCode = param3[5];
         }
         if(param3.length > 6)
         {
            _chainCode = param3[6];
         }
         param1.communicationManager.addHabboConnectionMessageEvent(new QuestDailyMessageEvent(onDailyQuest));
         _container = param2 as IWindowController_1;
         _container.findChildByName("accept_button").procedure = onAcceptButton;
         _container.findChildByName("go_button").procedure = onGoButton;
         _container.findChildByName("next_quest_region").procedure = onNextQuest;
         _container.findChildByName("cancel_quest_region").procedure = onCancelQuest;
         _container.findChildByName("easy_region").procedure = onEasyRegion;
         _container.findChildByName("hard_region").procedure = onHardRegion;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _disposed = true;
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return _isFloating;
      }
      
      public function refresh() : void
      {
         _index = 0;
         _landingView.send(new GetDailyQuestMessageComposer(true,0));
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onDailyQuest(param1:IMessageEvent) : void
      {
         var _loc2_:QuestDailyMessageParser = QuestDailyMessageParser(param1.parser);
         UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 = _loc2_.quest;
         UnknownVarFromDailyQuestElementHandler_Int_1 = _loc2_.easyQuestCount;
         UnknownVarFromDailyQuestElementHandler_Int_2 = _loc2_.hardQuestCount;
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         _container.findChildByName("caption_txt").caption = !!UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 ? getChainSpecificText("chaincaption") : getText("landing.view.quest.currenttask.alldone.caption");
         _container.findChildByName("accept_button").visible = UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && !UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.accepted;
         _container.findChildByName("next_quest_region").visible = UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && !UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.accepted && (UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.easy ? UnknownVarFromDailyQuestElementHandler_Int_1 : UnknownVarFromDailyQuestElementHandler_Int_2) > 1;
         _container.findChildByName("next_quest_txt").caption = getText("landing.view.quest.nextquest." + (UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.easy ? "easy" : "hard"));
         _container.findChildByName("cancel_quest_region").visible = UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.accepted;
         _container.findChildByName("current_quest_border").visible = UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.accepted;
         if(UnknownVarFromDailyQuestElementHandler_QuestMessageData_1)
         {
            _landingView.localizationManager.registerParameter("landing.view.quest.currenttask","task",getQuestName());
         }
         var _loc1_:IWindowController_1 = IWindowController_1(_container.findChildByName("difficulty_container"));
         var _loc2_:int = _loc1_.x + _loc1_.width;
         _loc1_.visible = UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && !UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.accepted && UnknownVarFromDailyQuestElementHandler_Int_1 > 0 && UnknownVarFromDailyQuestElementHandler_Int_2 > 0;
         setupDifficultyText("easy_region",UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && !UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.easy);
         setupDifficultyText("hard_region",UnknownVarFromDailyQuestElementHandler_QuestMessageData_1 && UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.easy);
         moveChildrenToRow(_loc1_,5);
         _loc1_.width = _loc1_.findChildByName("hard_region").x + _loc1_.findChildByName("hard_region").width;
         _loc1_.x = _loc2_ - _loc1_.width;
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
         return "quests." + UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.campaignCode + "." + UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.chainCode + "." + param1;
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
         var _loc1_:String = UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.getQuestLocalizationKey() + ".name";
         return "${" + _loc1_ + "}";
      }
      
      private function onAcceptButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new ActivateQuestMessageComposer(UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.id));
         }
      }
      
      private function onNextQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _index++;
            sendGetDailyQuest(UnknownVarFromDailyQuestElementHandler_QuestMessageData_1.easy);
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

