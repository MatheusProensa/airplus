package com.sulake.habbo.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumThreadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromIMMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromPhotoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromSelfieMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewSessionCreateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.DeletePendingCallsForHelpMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageParser;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageParser;
   import com.sulake.habbo.help.cfh.registry.user.UserRegistryItem;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   
   public class CallForHelpManager implements IComponentInterfaceQueue
   {
      private static const FIELD_MAX_CHARS:int = 253;
      
      private static const EMERGENCY_HELP_REQUEST_TITLE:String = "emergency_help_request";
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var _window:IWindowController_1;
      
      private var _chatReportController:ChatReportController;
      
      private var _reportedUserId:int = -1;
      
      private var _reportedUserName:String = "";
      
      private var _reportedRoomId:int = -1;
      
      private var _reportedRoomName:String;
      
      private var UnknownVarFromCallForHelpManager_String_1:String;
      
      private var _reportedGroupId:int = -1;
      
      private var _reportedThreadId:int = -1;
      
      private var _reportedMessageId:int = -1;
      
      private var _reportedExtraDataId:String;
      
      private var _reportedRoomObjectId:int = -1;
      
      private var UnknownVarFromCallForHelpManager_Int_1:int;
      
      private var UnknownVarFromCallForHelpManager_Int_2:int;
      
      private var UnknownVarFromCallForHelpManager_Int_3:int;
      
      private var UnknownVarFromCallForHelpManager_String_2:String;
      
      public function CallForHelpManager(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _chatReportController = new ChatReportController(_habboHelp,onChatReportEvent);
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new CallForHelpReplyMessageEvent(onCallForHelpReply));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new CallForHelpResultMessageEvent(onCallForHelpResult));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new IssueCloseNotificationMessageEvent(onIssueClose));
      }
      
      private static function getCloseReasonKey(param1:int) : String
      {
         if(param1 == 1)
         {
            return "useless";
         }
         if(param1 == 2)
         {
            return "abusive";
         }
         return "resolved";
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            closeWindow();
            if(_chatReportController)
            {
               _chatReportController.dispose();
               _chatReportController = null;
            }
            _habboHelp = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get reportedUserId() : int
      {
         return _reportedUserId;
      }
      
      public function get reportedUserName() : String
      {
         return _reportedUserName;
      }
      
      public function get reportedRoomId() : int
      {
         return _reportedRoomId;
      }
      
      public function get reportedRoomName() : String
      {
         return _reportedRoomName;
      }
      
      public function get reportedExtraDataId() : String
      {
         return _reportedExtraDataId;
      }
      
      public function get reportedRoomObjectId() : int
      {
         return _reportedRoomObjectId;
      }
      
      public function get reportedGroupId() : int
      {
         return _reportedGroupId;
      }
      
      public function get reportedThreadId() : int
      {
         return _reportedThreadId;
      }
      
      public function get reportedMessageId() : int
      {
         return _reportedMessageId;
      }
      
      public function set reportedUserId(param1:int) : void
      {
         _reportedUserId = param1;
      }
      
      public function set reportedUserName(param1:String) : void
      {
         _reportedUserName = param1;
      }
      
      public function set reportedRoomId(param1:int) : void
      {
         _reportedRoomId = param1;
      }
      
      public function set reportedRoomName(param1:String) : void
      {
         _reportedRoomName = param1;
      }
      
      public function set reportedExtraDataId(param1:String) : void
      {
         _reportedExtraDataId = param1;
      }
      
      public function set reportedRoomObjectId(param1:int) : void
      {
         _reportedRoomObjectId = param1;
      }
      
      public function set reportedGroupId(param1:int) : void
      {
         _reportedGroupId = param1;
      }
      
      public function set reportedThreadId(param1:int) : void
      {
         _reportedThreadId = param1;
      }
      
      public function set reportedMessageId(param1:int) : void
      {
         _reportedMessageId = param1;
      }
      
      public function reportBully(param1:int, param2:int) : void
      {
         if(_habboHelp.guardiansEnabled)
         {
            _reportedUserId = param1;
            _reportedRoomId = param2;
            _habboHelp.queryForGuideReportingStatus(3);
         }
         else
         {
            reportUser(param1,1,123);
         }
      }
      
      public function reportUser(param1:int, param2:int, param3:int) : void
      {
         _reportedUserId = param1;
         _reportedRoomId = -1;
         UnknownVarFromCallForHelpManager_Int_2 = param3;
         _habboHelp.queryForPendingCallsForHelp(param2);
      }
      
      public function reportRoom(param1:int, param2:String, param3:String) : void
      {
         _reportedRoomId = param1;
         _reportedRoomName = param2;
         UnknownVarFromCallForHelpManager_String_1 = param3;
         _reportedUserId = -1;
         _habboHelp.queryForPendingCallsForHelp(4);
      }
      
      public function reportThread(param1:int, param2:int) : void
      {
         _reportedGroupId = param1;
         _reportedThreadId = param2;
         _habboHelp.queryForPendingCallsForHelp(7);
      }
      
      public function reportMessage(param1:int, param2:int, param3:int) : void
      {
         _reportedGroupId = param1;
         _reportedThreadId = param2;
         _reportedMessageId = param3;
         _habboHelp.queryForPendingCallsForHelp(8);
      }
      
      public function reportSelfie(param1:String, param2:String, param3:int, param4:int, param5:int) : void
      {
         _habboHelp.sendMessage(new CallForHelpFromSelfieMessageComposer(param1,param3,param4,param2,param5));
      }
      
      public function reportPhoto(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         _habboHelp.setReportMessage(new CallForHelpFromPhotoMessageComposer(param1,param3,param4,param2,param5,"",""));
         _habboHelp.queryForPendingCallsForHelp(9);
      }
      
      public function openEmergencyHelpRequest() : void
      {
         reportUser(0,1,-1);
      }
      
      private function showAbusiveNotice() : void
      {
         closeWindow();
         _window = _habboHelp.getXmlWindow("abusive_notice") as IWindowController_1;
         _window.center();
         _window.findChildByName("header_button_close").visible = false;
         _window.procedure = onAbusiveNoticeEvent;
      }
      
      public function showEmergencyHelpRequest(param1:int) : void
      {
         var _loc3_:ISelectableWindow = null;
         var _loc6_:ISelectableWindow = null;
         closeWindow();
         UnknownVarFromCallForHelpManager_Int_1 = param1;
         if(UnknownVarFromCallForHelpManager_Int_1 == 6)
         {
            _window = _habboHelp.getXmlWindow("bully_report") as IWindowController_1;
            _window.procedure = onBullyReportEvent;
         }
         else
         {
            _window = _habboHelp.getXmlWindow("emergency_help_request") as IWindowController_1;
            _window.procedure = onEmergencyHelpRequestEvent;
            IIlluminaInputWidget(IWidgetWindowController(_window.findChildByName("help_message")).widget).maxChars = 253;
         }
         _window.center();
         var _loc4_:IItemListWindow = _window.findChildByName("user_panel") as IItemListWindow;
         var _loc5_:IItemListWindow = _window.findChildByName("room_panel") as IItemListWindow;
         var _loc2_:ISelectorWindow = ISelectorWindow(_window.findChildByName("topic_selector"));
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getSelectableByName("" + UnknownVarFromCallForHelpManager_Int_2);
            if(_loc3_ != null)
            {
               _loc2_.setSelected(_loc3_);
            }
            _loc6_ = _loc2_.getSelectableByName("123");
            if(_loc6_ != null && _habboHelp.guardiansEnabled)
            {
               _loc6_.visible = false;
            }
         }
         switch(UnknownVarFromCallForHelpManager_Int_1 - 1)
         {
            case 0:
               showPanels(true,false);
               break;
            case 2:
               showPanels(false,false);
               break;
            case 3:
               showPanels(false,true);
               break;
            case 5:
               populateUserList();
               break;
            case 6:
            case 7:
               showPanels(false,false);
         }
      }
      
      private function showChatReportTool() : void
      {
         closeWindow();
         _chatReportController.show(_habboHelp.ownUserId,_reportedUserId,UnknownVarFromCallForHelpManager_Int_1);
      }
      
      private function showPanels(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:IItemListWindow = _window.findChildByName("user_panel") as IItemListWindow;
         var _loc5_:IItemListWindow = _window.findChildByName("room_panel") as IItemListWindow;
         var _loc4_:Boolean = param1 || param2;
         _window.findChildByName("submit_box_wide").visible = _loc4_;
         _window.findChildByName("submit_box_narrow").visible = !_loc4_;
         _window.findChildByName("separator").visible = _loc4_;
         _loc5_.visible = param2;
         _loc3_.visible = param1;
         if(param2)
         {
            _loc5_.getListItemByName("room_name").caption = _reportedRoomName ?? "";
            _loc5_.getListItemByName("room_description").caption = UnknownVarFromCallForHelpManager_String_1 ?? "";
         }
         if(param1)
         {
            populateUserList();
         }
         if(!_loc4_)
         {
            _window.width = 301;
         }
      }
      
      private function populateUserList() : void
      {
         var _loc3_:IWindowController_1 = null;
         var _loc4_:* = false;
         var _loc2_:IItemListWindow = _window.findChildByName("user_list") as IItemListWindow;
         var _loc1_:IWindowController_1 = _loc2_.getListItemAt(0) as IWindowController_1;
         _loc2_.removeListItems();
         var _loc5_:int = 0;
         for each(var _loc6_ in _habboHelp.userRegistry.getRegistry())
         {
            _loc3_ = _loc1_.clone() as IWindowController_1;
            _loc4_ = _loc6_.userId == _reportedUserId;
            _loc3_.name = _loc6_.userId.toString();
            _loc3_.blend = _loc4_ ? 1 : 0;
            _loc3_.procedure = onUserSelectEvent;
            _loc3_.findChildByName("user_name").caption = _loc6_.userName;
            _loc3_.findChildByName("room_name").id = _loc6_.roomId;
            if(_loc4_)
            {
               _reportedRoomId = _loc6_.roomId;
            }
            _loc3_.findChildByName("room_name").caption = _loc6_.roomName != "" ? _habboHelp.localization.getLocalizationWithParams("help.emergency.main.step.two.room.name","","room_name",_loc6_.roomName) : "";
            IAvatarImageWidget(IWidgetWindowController(_loc3_.findChildByName("user_avatar")).widget).figure = _loc6_.figure;
            _loc2_.addListItemAt(_loc3_,_loc5_);
            if(_loc4_)
            {
               _loc5_ = 1;
            }
         }
      }
      
      private function refreshUserList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowController_1 = null;
         var _loc1_:IItemListWindow = _window.findChildByName("user_list") as IItemListWindow;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.numListItems)
         {
            _loc2_ = IWindowController_1(_loc1_.getListItemAt(_loc3_));
            _loc2_.blend = int(_loc2_.name) == _reportedUserId ? 1 : 0;
            _loc3_++;
         }
      }
      
      public function showPendingRequest(param1:String) : void
      {
         closeWindow();
         _window = _habboHelp.getXmlWindow("pending_request") as IWindowController_1;
         _window.findChildByName("request_message").caption = param1;
         _window.center();
         _window.procedure = onPendingReuqestEvent;
      }
      
      private function closeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onAbusiveNoticeEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:* = param2.name;
            if("close_button" === _loc3_)
            {
               closeWindow();
            }
         }
      }
      
      private function onEmergencyHelpRequestEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "submit_button":
                  if(!saveEmergencyHelpRequestData())
                  {
                     return;
                  }
                  basicInfoDone();
                  break;
               case "header_button_close":
                  closeWindow();
            }
         }
      }
      
      private function onBullyReportEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "submit_button":
                  if(_reportedUserId > 0)
                  {
                     _habboHelp.sendMessage(new IgnoreUserMessageComposer(_reportedUserId));
                     _habboHelp.sendMessage(new ChatReviewSessionCreateMessageComposer(_reportedUserId,_reportedRoomId));
                     closeWindow();
                  }
                  else
                  {
                     _habboHelp.windowManager.alert("${generic.alert.title}","${guide.bully.request.usermissing}",0,null);
                  }
                  break;
               case "header_button_close":
                  closeWindow();
            }
         }
      }
      
      private function onChatReportEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "submit_button":
                  if(_chatReportController.collectSelectedEntries(UnknownVarFromCallForHelpManager_Int_1,-1).length == 0)
                  {
                     _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.chatmissing}",0,null);
                     return;
                  }
                  submitCallForHelp();
                  _chatReportController.closeWindow();
                  closeWindow();
                  break;
               case "header_button_close":
                  _chatReportController.closeWindow();
            }
         }
      }
      
      private function onUserSelectEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            selectUserToReport(param2 as IWindowController_1);
         }
      }
      
      private function selectUserToReport(param1:IWindowController_1) : void
      {
         if(_window == null || _window.name != "emergency_help_request" || param1 == null)
         {
            return;
         }
         var _loc2_:int = int(param1.name);
         if(_reportedUserId == _loc2_)
         {
            _reportedUserId = 0;
            _reportedRoomId = -1;
         }
         else
         {
            _reportedUserId = _loc2_;
            _reportedRoomId = param1.findChildByName("room_name").id;
         }
         refreshUserList();
      }
      
      private function basicInfoDone() : void
      {
         var _loc1_:Boolean = isChatSelectionRequired();
         if(UnknownVarFromCallForHelpManager_Int_1 == 3)
         {
            if(!_habboHelp.instantMessageRegistry.hasUserChatted(_reportedUserId))
            {
               _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.nochathistory}",0,null);
            }
         }
         else if(_loc1_ && !_habboHelp.chatRegistry.hasContentWithoutChatFromUser(_habboHelp.ownUserId) && _habboHelp.chatRegistry.hasContentWithoutChatFromUser(_reportedUserId))
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.nochathistory}",0,null);
            return;
         }
         if(_loc1_)
         {
            showChatReportTool();
         }
         else
         {
            submitCallForHelp();
         }
      }
      
      private function isChatSelectionRequired() : Boolean
      {
         if(UnknownVarFromCallForHelpManager_Int_1 == 7 || UnknownVarFromCallForHelpManager_Int_1 == 8 || UnknownVarFromCallForHelpManager_Int_1 == 4)
         {
            return false;
         }
         return _reportedUserId <= 0 || _habboHelp.chatRegistry.getItemsByUser(_reportedUserId).length > 0 || UnknownVarFromCallForHelpManager_Int_1 == 3;
      }
      
      private function saveEmergencyHelpRequestData(param1:Boolean = true) : Boolean
      {
         if(_window == null || _window.name != "emergency_help_request")
         {
            return false;
         }
         UnknownVarFromCallForHelpManager_String_2 = IIlluminaInputWidget(IWidgetWindowController(_window.findChildByName("help_message")).widget).message;
         if(UnknownVarFromCallForHelpManager_String_2 == null || UnknownVarFromCallForHelpManager_String_2 == "")
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.nomsg}",0,null);
            return false;
         }
         if(UnknownVarFromCallForHelpManager_String_2.length < _habboHelp.getInteger("help.cfh.length.minimum",15))
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.msgtooshort}",0,null);
            return false;
         }
         UnknownVarFromCallForHelpManager_Int_3 = 0;
         var _loc2_:ISelectableWindow = ISelectorWindow(_window.findChildByName("topic_selector")).getSelected();
         if(_loc2_ != null)
         {
            UnknownVarFromCallForHelpManager_Int_3 = int(_loc2_.name);
         }
         if(UnknownVarFromCallForHelpManager_Int_3 == 0)
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.notopic}",0,null);
            return false;
         }
         if(UnknownVarFromCallForHelpManager_Int_1 == 8 || UnknownVarFromCallForHelpManager_Int_1 == 7)
         {
            return true;
         }
         if(_reportedUserId <= 0 && (UnknownVarFromCallForHelpManager_Int_1 != 8 && UnknownVarFromCallForHelpManager_Int_1 == 7) || UnknownVarFromCallForHelpManager_Int_1 == 4 && !_habboHelp.getBoolean("room.report.enabled"))
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${guide.bully.request.usermissing}",0,null);
            return false;
         }
         if(_habboHelp.friendList.getFriend(_reportedUserId) != null)
         {
            _habboHelp.windowManager.confirm("${help.cfh.unfriend.confirm.title}","${help.cfh.unfriend.confirm.message}",0x10 | 0x20,onFriendReportConfirmation);
            return false;
         }
         return true;
      }
      
      private function submitCallForHelp() : void
      {
         var _loc1_:int = 0;
         closeWindow();
         switch(UnknownVarFromCallForHelpManager_Int_1 - 1)
         {
            case 0:
            case 3:
               _loc1_ = _chatReportController.reportedRoomId <= 0 ? _reportedRoomId : _chatReportController.reportedRoomId;
               _habboHelp.sendMessage(new CallForHelpMessageComposer(UnknownVarFromCallForHelpManager_String_2,UnknownVarFromCallForHelpManager_Int_3,_reportedUserId,_loc1_,_chatReportController.collectSelectedEntries(UnknownVarFromCallForHelpManager_Int_1,-1),"",""));
               break;
            case 2:
               _habboHelp.sendMessage(new CallForHelpFromIMMessageComposer(UnknownVarFromCallForHelpManager_String_2,UnknownVarFromCallForHelpManager_Int_3,_reportedUserId,_chatReportController.collectSelectedEntries(3,-1),"",""));
               break;
            case 6:
               _habboHelp.sendMessage(new CallForHelpFromForumThreadMessageComposer(_reportedGroupId,_reportedThreadId,UnknownVarFromCallForHelpManager_Int_3,UnknownVarFromCallForHelpManager_String_2,"",""));
               break;
            case 7:
               _habboHelp.sendMessage(new CallForHelpFromForumMessageMessageComposer(_reportedGroupId,_reportedThreadId,_reportedMessageId,UnknownVarFromCallForHelpManager_Int_3,UnknownVarFromCallForHelpManager_String_2,"",""));
         }
         _habboHelp.ignoreAndUnfriendReportedUser();
      }
      
      private function onFriendReportConfirmation(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            basicInfoDone();
         }
         param1.dispose();
      }
      
      private function onPendingReuqestEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "keep_button":
               case "header_button_close":
                  closeWindow();
                  break;
               case "discard_button":
                  deletePendingCallsForHelp();
                  closeWindow();
            }
         }
      }
      
      private function onCallForHelpReply(param1:IMessageEvent) : void
      {
         var _loc2_:CallForHelpReplyMessageParser = CallForHelpReplyMessageEvent(param1).getParser();
         _habboHelp.windowManager.alert("${help.cfh.reply.title}",_loc2_.message,0,null);
      }
      
      private function onCallForHelpResult(param1:IMessageEvent) : void
      {
         var _loc3_:CallForHelpResultMessageParser = CallForHelpResultMessageEvent(param1).getParser();
         var _loc4_:int = _loc3_.resultType;
         var _loc2_:String = _loc3_.messageText;
         if(_loc2_ == "")
         {
            _loc2_ = "${help.cfh.sent.text}";
         }
         _habboHelp.windowManager.alert("${help.cfh.sent.title}",_loc2_,0,null);
      }
      
      private function onIssueClose(param1:IssueCloseNotificationMessageEvent) : void
      {
         var _loc3_:IssueCloseNotificationMessageParser = param1.getParser();
         var _loc2_:String = _loc3_.messageText;
         if(_loc2_ == "")
         {
            _loc2_ = "${help.cfh.closed." + getCloseReasonKey(_loc3_.closeReason) + "}";
         }
         _habboHelp.windowManager.alert("${mod.alert.title}",_loc2_,0,null);
      }
      
      private function deletePendingCallsForHelp() : void
      {
         _habboHelp.sendMessage(new DeletePendingCallsForHelpMessageComposer());
      }
      
      public function get chatReportController() : ChatReportController
      {
         return _chatReportController;
      }
   }
}

