package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.geom.Point;
   
   public class QuestDetails implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromQuestDetails_Int_1:int = 56;
      
      private static const SPACING:int = 5;
      
      private static const TEXT_HEIGHT_SPACING:int = 5;
      
      private static const UnknownConstFromQuestDetails_Point_1:Point = new Point(8,8);
      
      private static const UnknownConstFromQuestDetails_Array_1:Array = ["PLACE_ITEM","PLACE_FLOOR","PLACE_WALLPAPER","PET_DRINK","PET_EAT"];
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromQuestDetails_Boolean_1:Boolean;
      
      private var UnknownVarFromQuestDetails_QuestMessageData_1:QuestMessageData;
      
      private var _msecsToRefresh:int;
      
      private var UnknownVarFromQuestDetails_Boolean_2:Boolean = false;
      
      public function QuestDetails(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         UnknownVarFromQuestDetails_QuestMessageData_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onQuest(param1:QuestMessageData) : void
      {
         if(UnknownVarFromQuestDetails_Boolean_1)
         {
            UnknownVarFromQuestDetails_Boolean_1 = false;
            openDetails(param1);
         }
         else if(UnknownVarFromQuestDetails_QuestMessageData_1 == null)
         {
            close();
         }
      }
      
      public function onQuestCompleted(param1:QuestMessageData) : void
      {
         if(UnknownVarFromQuestDetails_QuestMessageData_1 == null || UnknownVarFromQuestDetails_QuestMessageData_1.id == param1.id)
         {
            close();
         }
      }
      
      public function onQuestCancelled(param1:String) : void
      {
         if(UnknownVarFromQuestDetails_QuestMessageData_1 == null || UnknownVarFromQuestDetails_QuestMessageData_1.campaignChainCode == param1)
         {
            close();
         }
      }
      
      public function onRoomExit() : void
      {
         close();
      }
      
      private function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      public function showDetails(param1:QuestMessageData) : void
      {
         if(_window && _window.visible && (UnknownVarFromQuestDetails_QuestMessageData_1 != null && param1.id == UnknownVarFromQuestDetails_QuestMessageData_1.id))
         {
            _window.visible = false;
            return;
         }
         openDetails(param1);
      }
      
      public function openDetails(param1:QuestMessageData, param2:Boolean = false) : void
      {
         var _loc5_:IWindowController_1 = null;
         UnknownVarFromQuestDetails_QuestMessageData_1 = param1;
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromQuestDetails_Boolean_2 = param2;
         if(_window == null)
         {
            _window = IFrameController(_questEngine.getXmlWindow("QuestDetails"));
            _window.findChildByTag("close").procedure = onDetailsWindowClose;
            _window.center();
            _loc5_ = _questEngine.questController.questsList.createListEntry(onAcceptQuest,onCancelQuest);
            _loc5_.x = UnknownConstFromQuestDetails_Point_1.x;
            _loc5_.y = UnknownConstFromQuestDetails_Point_1.y;
            _window.content.addChild(_loc5_);
            _window.findChildByName("link_region").procedure = onLinkProc;
         }
         _loc5_ = IWindowController_1(_window.findChildByName("entry_container"));
         _questEngine.questController.questsList.refreshEntryDetails(_loc5_,param1);
         var _loc8_:* = UnknownVarFromQuestDetails_QuestMessageData_1.waitPeriodSeconds > 0;
         var _loc3_:IHTMLTextController = IHTMLTextController(_loc5_.findChildByName("hint_txt"));
         var _loc9_:int = getTextHeight(_loc3_);
         if(!_loc8_)
         {
            _loc3_.caption = _questEngine.getQuestHint(param1);
            _loc3_.height = _loc3_.textHeight + 5;
            _loc3_.initializeLinkStyle();
            _loc3_.addEventListener("WE_LINK",onClickHtmlLink);
         }
         _loc3_.visible = !_loc8_;
         var _loc4_:int = getTextHeight(_loc3_) - _loc9_;
         var _loc7_:int = setupLink("link_region",_loc3_.y + _loc3_.height + 5);
         var _loc6_:IWindowController_1 = IWindowController_1(_loc5_.findChildByName("quest_container"));
         _loc6_.height = _loc6_.height + (_loc4_ + _loc7_);
         _questEngine.questController.questsList.setEntryHeight(_loc5_);
         _window.height = _loc5_.height + 56;
         _window.visible = true;
         _window.activate();
      }
      
      private function onClickHtmlLink(param1:WindowEvent) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            HabboWebTools.openWebPageAndMinimizeClient(_loc2_.link);
         }
      }
      
      private function setupLink(param1:String, param2:int) : int
      {
         var _loc3_:Boolean = hasCatalogLink();
         var _loc8_:Boolean = !_loc3_ && hasNavigatorLink();
         var _loc5_:Boolean = !_loc3_ && !_loc8_ && hasRoomLink();
         var _loc6_:Boolean = _loc3_ || _loc8_ || _loc5_;
         var _loc7_:IRegionWindow = IRegionWindow(_window.findChildByName(param1));
         _loc7_.y = param2;
         var _loc4_:int = 0;
         if(_loc6_ && !_loc7_.visible)
         {
            _loc4_ = 5 + _loc7_.height;
         }
         if(!_loc6_ && Boolean(_loc7_.visible))
         {
            _loc4_ = -5 - _loc7_.height;
         }
         _loc7_.visible = _loc6_;
         _loc7_.findChildByName("link_catalog").visible = _loc3_;
         _loc7_.findChildByName("link_navigator").visible = _loc8_;
         _loc7_.findChildByName("link_room").visible = _loc5_;
         return _loc4_;
      }
      
      private function hasCatalogLink() : Boolean
      {
         return UnknownVarFromQuestDetails_QuestMessageData_1.waitPeriodSeconds < 1 && UnknownConstFromQuestDetails_Array_1.indexOf(UnknownVarFromQuestDetails_QuestMessageData_1.type) > -1;
      }
      
      private function hasNavigatorLink() : Boolean
      {
         var _loc2_:Boolean = _questEngine.hasLocalizedValue(UnknownVarFromQuestDetails_QuestMessageData_1.getCampaignLocalizationKey() + ".searchtag");
         var _loc1_:Boolean = _questEngine.hasLocalizedValue(UnknownVarFromQuestDetails_QuestMessageData_1.getCampaignLocalizationKey() + ".searchtag");
         return UnknownVarFromQuestDetails_QuestMessageData_1.waitPeriodSeconds < 1 && (_loc2_ || _loc1_);
      }
      
      private function hasRoomLink() : Boolean
      {
         return UnknownVarFromQuestDetails_QuestMessageData_1.waitPeriodSeconds < 1 && _questEngine.isSeasonalQuest(UnknownVarFromQuestDetails_QuestMessageData_1) && _questEngine.hasQuestRoomsIds();
      }
      
      private function getTextHeight(param1:ITextWindow) : int
      {
         return !!param1.visible ? param1.height : 0;
      }
      
      private function onDetailsWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _window.visible = false;
         }
      }
      
      public function set openForNextQuest(param1:Boolean) : void
      {
         UnknownVarFromQuestDetails_Boolean_1 = param1;
      }
      
      private function onLinkProc(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(hasCatalogLink())
            {
               _questEngine.openCatalog(UnknownVarFromQuestDetails_QuestMessageData_1);
            }
            else if(hasNavigatorLink())
            {
               _questEngine.openNavigator(UnknownVarFromQuestDetails_QuestMessageData_1);
            }
            else
            {
               _questEngine.goToQuestRooms();
            }
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
         var _loc2_:Boolean = _questEngine.questController.questsList.refreshDelay(_window,UnknownVarFromQuestDetails_QuestMessageData_1);
         if(_loc2_)
         {
            openDetails(UnknownVarFromQuestDetails_QuestMessageData_1,UnknownVarFromQuestDetails_Boolean_2);
         }
      }
      
      private function onAcceptQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(_questEngine.currentlyInRoom)
            {
               _questEngine.send(new AcceptQuestMessageComposer(UnknownVarFromQuestDetails_QuestMessageData_1.id));
            }
            else
            {
               _questEngine.send(new ActivateQuestMessageComposer(UnknownVarFromQuestDetails_QuestMessageData_1.id));
            }
            _window.visible = false;
            _questEngine.questController.seasonalCalendarWindow.close();
            if(UnknownVarFromQuestDetails_Boolean_2 && _questEngine.isSeasonalQuest(UnknownVarFromQuestDetails_QuestMessageData_1))
            {
               _questEngine.goToQuestRooms();
            }
         }
      }
      
      private function onCancelQuest(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(UnknownVarFromQuestDetails_QuestMessageData_1 == null)
            {
               return;
            }
            _questEngine.send(new RejectQuestMessageComposer(UnknownVarFromQuestDetails_QuestMessageData_1.id));
         }
      }
   }
}

