package com.sulake.habbo.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.data.PendingGuideTicket;
   import com.sulake.habbo.help.guidehelp.GuideSessionController;
   import com.sulake.habbo.help.guidehelp.HelpController;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GuideHelpManager implements IComponentInterfaceQueue
   {
      private var _habboHelp:HabboHelp;
      
      private var UnknownVarFromGuideHelpManager_HelpController_1:HelpController;
      
      private var UnknownVarFromGuideHelpManager_GuideSessionController_1:GuideSessionController;
      
      private var UnknownVarFromGuideHelpManager_ChatReviewReporterFeedbackCtrl_1:ChatReviewReporterFeedbackCtrl;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromGuideHelpManager_Boolean_1:Boolean;
      
      private var UnknownVarFromGuideHelpManager_Int_1:int;
      
      private var _panicRoomName:String;
      
      private var UnknownVarFromGuideHelpManager_Timer_1:Timer;
      
      public function GuideHelpManager(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         UnknownVarFromGuideHelpManager_HelpController_1 = new HelpController(this);
         UnknownVarFromGuideHelpManager_GuideSessionController_1 = new GuideSessionController(this);
         UnknownVarFromGuideHelpManager_ChatReviewReporterFeedbackCtrl_1 = new ChatReviewReporterFeedbackCtrl(_habboHelp);
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
      }
      
      public function get habboHelp() : HabboHelp
      {
         return _habboHelp;
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         if(_habboHelp.newUserTourEnabled && _habboHelp.newIdentity && !UnknownVarFromGuideHelpManager_Boolean_1 && !_habboHelp.sessionDataManager.isRealNoob)
         {
            UnknownVarFromGuideHelpManager_Timer_1 = new Timer(getTourPopupDelay(),1);
            UnknownVarFromGuideHelpManager_Timer_1.addEventListener("timer",onTourPopup);
            UnknownVarFromGuideHelpManager_Timer_1.start();
            _habboHelp.tracking.trackEventLog("Help","","tour.new_user.create","",getTourPopupDelay());
            _habboHelp.trackGoogle("newbieTourWindow","timer_popupCreated");
         }
      }
      
      private function onTourPopup(param1:TimerEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         _habboHelp.tracking.trackEventLog("Help","","tour.new_user.show","",getTourPopupDelay());
         _habboHelp.trackGoogle("newbieTourWindow","timer_popupShown");
         openTourPopup();
      }
      
      public function openTourPopup() : void
      {
         UnknownVarFromGuideHelpManager_HelpController_1.openTourPopup();
         UnknownVarFromGuideHelpManager_Boolean_1 = true;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromGuideHelpManager_HelpController_1)
         {
            UnknownVarFromGuideHelpManager_HelpController_1.dispose();
            UnknownVarFromGuideHelpManager_HelpController_1 = null;
         }
         if(UnknownVarFromGuideHelpManager_GuideSessionController_1)
         {
            UnknownVarFromGuideHelpManager_GuideSessionController_1.dispose();
            UnknownVarFromGuideHelpManager_GuideSessionController_1 = null;
         }
         if(UnknownVarFromGuideHelpManager_ChatReviewReporterFeedbackCtrl_1)
         {
            UnknownVarFromGuideHelpManager_ChatReviewReporterFeedbackCtrl_1.dispose();
            UnknownVarFromGuideHelpManager_ChatReviewReporterFeedbackCtrl_1 = null;
         }
         if(UnknownVarFromGuideHelpManager_Timer_1)
         {
            UnknownVarFromGuideHelpManager_Timer_1.reset();
            UnknownVarFromGuideHelpManager_Timer_1 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showGuideTool() : void
      {
         UnknownVarFromGuideHelpManager_GuideSessionController_1.showGuideTool();
      }
      
      public function showPendingTicket(param1:PendingGuideTicket) : void
      {
         UnknownVarFromGuideHelpManager_HelpController_1.showPendingTicket(param1);
      }
      
      public function createHelpRequest(param1:uint) : void
      {
         UnknownVarFromGuideHelpManager_GuideSessionController_1.createHelpRequest(param1);
      }
      
      public function openReportWindow() : void
      {
         UnknownVarFromGuideHelpManager_GuideSessionController_1.openReportWindow();
      }
      
      public function showFeedback(param1:String) : void
      {
         UnknownVarFromGuideHelpManager_ChatReviewReporterFeedbackCtrl_1.show(param1);
      }
      
      private function getTourPopupDelay() : int
      {
         return _habboHelp.getInteger("guide.help.new.user.tour.popup.delay",30) * 1000;
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            switch(param1.iconId)
            {
               case "HTIE_ICON_HELP":
                  _habboHelp.toggleNewHelpWindow();
                  break;
               case "HTIE_ICON_GUIDE":
                  showGuideTool();
            }
         }
      }
   }
}

