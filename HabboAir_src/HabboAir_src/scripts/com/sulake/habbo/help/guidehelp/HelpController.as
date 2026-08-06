package com.sulake.habbo.help.guidehelp
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
   import com.sulake.habbo.communication.messages.parser.help.data.PendingGuideTicket;
   import com.sulake.habbo.help.GuideHelpManager;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IUpdatingTimeStampWidget;
   import flash.utils.getTimer;
   
   public class HelpController implements IComponentInterfaceQueue
   {
      private var _habboHelp:HabboHelp;
      
      private var _guideHelp:GuideHelpManager;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromHelpController_IModalDialog_1:IModalDialog;
      
      private var _tourPopup:IWindowController_1;
      
      private var _tourPopupShowTime:int;
      
      private var UnknownVarFromHelpController_IWindowController_1_1:IWindowController_1;
      
      public function HelpController(param1:GuideHelpManager)
      {
         super();
         _habboHelp = param1.habboHelp;
         _guideHelp = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeWindow();
         closeTourPopup();
         _habboHelp = null;
         _guideHelp = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function openWindow() : void
      {
         if(UnknownVarFromHelpController_IModalDialog_1 == null && !disposed)
         {
            UnknownVarFromHelpController_IModalDialog_1 = _guideHelp.habboHelp.getModalXmlWindow("main_help");
            UnknownVarFromHelpController_IModalDialog_1.rootWindow.procedure = windowEventProcedure;
         }
      }
      
      public function closeWindow() : void
      {
         if(UnknownVarFromHelpController_IModalDialog_1 != null)
         {
            UnknownVarFromHelpController_IModalDialog_1.dispose();
            UnknownVarFromHelpController_IModalDialog_1 = null;
         }
      }
      
      private function windowEventProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:UnknownICoreWindowComponents2 = null;
         if(disposed || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               closeWindow();
               break;
            case "tour_button":
               _guideHelp.createHelpRequest(_habboHelp.newIdentity ? 0 : 2);
               _habboHelp.trackGoogle("helpWindow","click_userTour");
               closeWindow();
               break;
            case "bully_button":
               closeWindow();
               _habboHelp.toggleNewHelpWindow();
               _habboHelp.trackGoogle("helpWindow","click_reportBully");
               break;
            case "instructions_button":
               _guideHelp.createHelpRequest(1);
               _habboHelp.trackGoogle("helpWindow","click_instructions");
               closeWindow();
               break;
            case "self_help_link":
               HabboWebTools.openWebPage(_habboHelp.getProperty("zendesk.url"),"habboMain");
               _habboHelp.trackGoogle("helpWindow","click_selfHelp");
               closeWindow();
               break;
            case "habboway_link":
               if(_habboHelp.getBoolean("habboway.enabled"))
               {
                  _habboHelp.showHabboWay();
               }
               else
               {
                  HabboWebTools.openWebPage(_habboHelp.getProperty("habboway.url"),"habboMain");
               }
               _habboHelp.trackGoogle("helpWindow","click_habboWay");
               closeWindow();
               break;
            case "safetybooklet_link":
               _habboHelp.showSafetyBooklet();
               _habboHelp.trackGoogle("helpWindow","click_showSafetyBooklet");
               closeWindow();
               break;
            case "emergency_button":
               _loc3_ = IWindowController_1(UnknownVarFromHelpController_IModalDialog_1.rootWindow).findChildByName("leave_room") as UnknownICoreWindowComponents2;
               if(_loc3_ != null && Boolean(_loc3_.isSelected))
               {
                  _habboHelp.sendMessage(new QuitMessageComposer());
               }
               closeWindow();
               _habboHelp.startEmergencyRequest();
               _habboHelp.trackGoogle("helpWindow","click_emergency");
         }
      }
      
      public function openTourPopup() : void
      {
         if(_tourPopup == null && !disposed)
         {
            _tourPopupShowTime = getTimer();
            _tourPopup = _guideHelp.habboHelp.getXmlWindow("welcome_tour_popup") as IWindowController_1;
            _tourPopup.center();
            _tourPopup.y *= 0.25;
            _tourPopup.procedure = tourPopupEventProcedure;
         }
      }
      
      private function closeTourPopup() : void
      {
         if(_tourPopup != null)
         {
            _tourPopup.dispose();
            _tourPopup = null;
         }
      }
      
      private function tourPopupEventProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(disposed || param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = (_tourPopupShowTime - getTimer()) / 1000;
         switch(param2.name)
         {
            case "refuse_tour":
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.cancel","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_refuseTour");
               closeTourPopup();
               break;
            case "header_button_close":
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.dismiss","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_closeWindow");
               closeTourPopup();
               break;
            case "take_tour":
               _guideHelp.createHelpRequest(0);
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.accept","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_acceptTour");
               closeTourPopup();
         }
      }
      
      public function showPendingTicket(param1:PendingGuideTicket) : void
      {
         var _loc2_:String = null;
         if(param1.isGuide)
         {
            _loc2_ = "pending_guide_session";
         }
         else
         {
            switch(param1.type)
            {
               case 0:
               case 2:
                  _loc2_ = "pending_tour_request";
                  break;
               case 1:
                  _loc2_ = "pending_instructions_request";
                  break;
               case 3:
                  _loc2_ = "pending_bully_request";
                  break;
               default:
                  return;
            }
         }
         UnknownVarFromHelpController_IWindowController_1_1 = _habboHelp.getXmlWindow(_loc2_) as IWindowController_1;
         UnknownVarFromHelpController_IWindowController_1_1.center();
         UnknownVarFromHelpController_IWindowController_1_1.procedure = onPendingReuqestEvent;
         if(param1.isGuide)
         {
            return;
         }
         switch(param1.type - 1)
         {
            case 0:
               UnknownVarFromHelpController_IWindowController_1_1.findChildByName("description").caption = param1.description;
               IUpdatingTimeStampWidget(IWidgetWindowController(UnknownVarFromHelpController_IWindowController_1_1.findChildByName("timestamp")).widget).timeStamp = new Date().getTime() - param1.secondsAgo * 1000;
               break;
            case 2:
               UnknownVarFromHelpController_IWindowController_1_1.findChildByName("user_name").caption = param1.otherPartyName;
               IAvatarImageWidget(IWidgetWindowController(UnknownVarFromHelpController_IWindowController_1_1.findChildByName("user_avatar")).widget).figure = param1.otherPartyFigure;
               IUpdatingTimeStampWidget(IWidgetWindowController(UnknownVarFromHelpController_IWindowController_1_1.findChildByName("timestamp")).widget).timeStamp = new Date().getTime() - param1.secondsAgo * 1000;
               _habboHelp.localization.registerParameter("guide.pending.bully.room","room",param1.roomName);
         }
      }
      
      private function onPendingReuqestEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "close_button":
                  if(UnknownVarFromHelpController_IWindowController_1_1 != null && !UnknownVarFromHelpController_IWindowController_1_1.disposed)
                  {
                     UnknownVarFromHelpController_IWindowController_1_1.dispose();
                     UnknownVarFromHelpController_IWindowController_1_1 = null;
                  }
            }
         }
      }
   }
}

