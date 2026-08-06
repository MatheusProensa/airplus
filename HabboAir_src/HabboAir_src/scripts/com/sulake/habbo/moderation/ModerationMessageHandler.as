package com.sulake.habbo.moderation
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionMessageParser;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.*;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userclassification.UserClassificationMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
   import com.sulake.habbo.communication.messages.parser.moderation.*;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.communication.messages.parser.userclassification.UserClassificationMessageParser;
   import com.sulake.habbo.userclassification.UserClassificationData;
   import flash.utils.Dictionary;
   
   public class ModerationMessageHandler
   {
      private var _moderationManager:ModerationManager;
      
      private var _userInfoListeners:Array = [];
      
      private var _roomVisitsListeners:Array = [];
      
      private var UnknownVarFromModerationMessageHandler_Array_1:Array = [];
      
      private var _chatlogListeners:Array = [];
      
      private var _roomInfoListeners:Array = [];
      
      private var _roomEnterListeners:Array = [];
      
      public function ModerationMessageHandler(param1:ModerationManager)
      {
         super();
         _moderationManager = param1;
         var _loc2_:IConnection = param1.connection;
         _loc2_.addMessageEvent(new IssueDeletedMessageEvent(onIssueDeleted));
         _loc2_.addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         _loc2_.addMessageEvent(new ModeratorToolPreferencesEvent(onModeratorToolPreferences));
         _loc2_.addMessageEvent(new RoomChatlogEvent(onRoomChatlog));
         _loc2_.addMessageEvent(new UserClassificationMessageEvent(onRoomUserClassification));
         _loc2_.addMessageEvent(new IssueInfoMessageEvent(onIssueInfo));
         _loc2_.addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         _loc2_.addMessageEvent(new CfhChatlogEvent(onCfhChatlog));
         _loc2_.addMessageEvent(new ModeratorInitMessageEvent(onModeratorInit));
         _loc2_.addMessageEvent(new ModeratorUserInfoEvent(onUserInfo));
         _loc2_.addMessageEvent(new ModeratorActionResultMessageEvent(onModeratorActionResult));
         _loc2_.addMessageEvent(new IssuePickFailedMessageEvent(onIssuePickFailed));
         _loc2_.addMessageEvent(new ModeratorRoomInfoEvent(onRoomInfo));
         _loc2_.addMessageEvent(new CfhTopicsInitMessageEvent(onCfhTopics));
         _loc2_.addMessageEvent(new RoomVisitsEvent(onRoomVisits));
         _loc2_.addMessageEvent(new CfhSanctionMessageEvent(onSanctions));
         _loc2_.addMessageEvent(new UserChatlogEvent(onUserChatlog));
      }
      
      private function onIssueInfo(param1:IssueInfoMessageEvent) : void
      {
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc2_:IssueInfoMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IssueMessageData = _loc2_.issueData;
         _moderationManager.issueManager.playSound(_loc3_);
         _moderationManager.issueManager.updateIssue(_loc3_);
      }
      
      private function onModeratorInit(param1:ModeratorInitMessageEvent) : void
      {
         var _loc4_:* = null;
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc3_:ModeratorInitMessageParser = param1.getParser();
         if(_loc3_ == null || _loc3_.data == null)
         {
            return;
         }
         var _loc2_:ModeratorInitData = _loc3_.data;
         var _loc6_:Array = _loc2_.issues;
         var _loc5_:Array = _loc2_.messageTemplates;
         for each(_loc4_ in _loc6_)
         {
            _moderationManager.issueManager.updateIssue(_loc4_);
         }
         _moderationManager.issueManager.updateIssueBrowser();
         _moderationManager.initMsg = _loc2_;
         _moderationManager.startPanel.show();
      }
      
      private function onModeratorToolPreferences(param1:ModeratorToolPreferencesEvent) : void
      {
         var _loc2_:ModeratorToolPreferencesMessageParser = null;
         if(_moderationManager && _moderationManager.issueManager)
         {
            _loc2_ = param1.getParser();
            _moderationManager.issueManager.setToolPreferences(_loc2_.windowX,_loc2_.windowY,_loc2_.windowHeight,_loc2_.windowWidth);
         }
      }
      
      private function onIssuePickFailed(param1:IssuePickFailedMessageEvent) : void
      {
         var alert:Boolean;
         var issues:Array;
         var retryEnabled:Boolean;
         var retryCount:int;
         var pickedAlready:Boolean;
         var event:IssuePickFailedMessageEvent = param1;
         var parser:IssuePickFailedMessageParser = event.getParser();
         if(parser == null)
         {
            return;
         }
         alert = true;
         issues = parser.issues;
         retryEnabled = parser.retryEnabled;
         retryCount = parser.retryCount;
         pickedAlready = _moderationManager.issueManager.issuePickFailed(issues);
         if(pickedAlready)
         {
            if(retryEnabled)
            {
               if(retryCount < 10)
               {
                  alert = false;
                  _moderationManager.issueManager.autoPick("pick failed retry",retryEnabled,retryCount);
               }
            }
         }
         if(alert)
         {
            _moderationManager.windowManager.alert("Error","Issue picking failed",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
         }
      }
      
      private function onIssueDeleted(param1:IssueDeletedMessageEvent) : void
      {
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc2_:IssueDeletedMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         _moderationManager.issueManager.removeIssue(_loc2_.issueId);
      }
      
      private function onUserInfo(param1:ModeratorUserInfoEvent) : void
      {
         var _loc3_:ModeratorUserInfoMessageParser = param1.getParser();
         Logger.log("GOT USER INFO: " + _loc3_.data.userId + ", " + _loc3_.data.cautionCount);
         for each(var _loc2_ in _userInfoListeners)
         {
            _loc2_.onUserInfo(_loc3_.data);
         }
      }
      
      private function onRoomInfo(param1:ModeratorRoomInfoEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:ModeratorRoomInfoMessageParser = param1.getParser();
         for each(_loc2_ in _roomInfoListeners)
         {
            _loc2_.onRoomInfo(_loc3_.data);
         }
      }
      
      private function onCfhChatlog(param1:CfhChatlogEvent) : void
      {
         var _loc3_:CfhChatlogMessageParser = param1.getParser();
         var _loc2_:Array = [];
         _loc2_.push(_loc3_.data.chatRecord);
         var _loc4_:Dictionary = new Dictionary();
         _loc4_[_loc3_.data.callerUserId] = 0;
         _loc4_[_loc3_.data.reportedUserId] = 1;
         onChatlog("Call For Help Evidence #" + _loc3_.data.chatRecordId,3,_loc3_.data.callId,_loc2_,_loc4_);
      }
      
      private function onRoomChatlog(param1:RoomChatlogEvent) : void
      {
         var _loc3_:RoomChatlogMessageParser = param1.getParser();
         var _loc2_:Array = [];
         _loc2_.push(_loc3_.data);
         var _loc4_:Dictionary = new Dictionary();
         onChatlog("Room Chatlog: " + _loc3_.data.roomName,4,_loc3_.data.roomId,_loc2_,_loc4_);
      }
      
      private function onUserChatlog(param1:UserChatlogEvent) : void
      {
         var _loc2_:UserChatlogMessageParser = param1.getParser();
         var _loc3_:Dictionary = new Dictionary();
         _loc3_[_loc2_.data.userId] = 0;
         onChatlog("User Chatlog: " + _loc2_.data.userName,5,_loc2_.data.userId,_loc2_.data.rooms,_loc3_);
      }
      
      private function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary) : void
      {
         var _loc6_:Array = _chatlogListeners.concat();
         for each(var _loc7_ in _loc6_)
         {
            _loc7_.onChatlog(param1,param2,param3,param4,param5);
         }
      }
      
      private function onRoomVisits(param1:RoomVisitsEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:RoomVisitsMessageParser = param1.getParser();
         var _loc3_:Array = _roomVisitsListeners.concat();
         for each(_loc2_ in _loc3_)
         {
            _loc2_.onRoomVisits(_loc4_.data);
         }
      }
      
      private function onRoomUserClassification(param1:UserClassificationMessageEvent) : void
      {
         var _loc9_:* = null;
         var _loc5_:UserClassificationMessageParser = (param1 as UserClassificationMessageEvent).getParser();
         var _loc10_:Map = _loc5_.classifiedUsernameMap;
         var _loc3_:Map = _loc5_.classifiedUserTypeMap;
         var _loc6_:int = 1;
         var _loc7_:Array = [];
         for each(var _loc8_ in _loc10_.getKeys())
         {
            _loc7_.push(new UserClassificationData(_loc8_,_loc10_[_loc8_],_loc3_[_loc8_]));
         }
         var _loc2_:UserClassificationCtrl = new UserClassificationCtrl(_moderationManager,_loc6_);
         _loc2_.show();
         var _loc4_:Array = UnknownVarFromModerationMessageHandler_Array_1.concat();
         for each(_loc9_ in _loc4_)
         {
            _loc9_.onUserClassification(_loc6_,_loc7_);
         }
      }
      
      private function onSanctions(param1:CfhSanctionMessageEvent) : void
      {
         var _loc2_:CfhSanctionMessageParser = param1.getParser();
         Logger.log("Got sanction data..." + [_loc2_.issueId,_loc2_.accountId,_loc2_.sanctionType]);
         _moderationManager.issueManager.updateSanctionData(_loc2_.issueId,_loc2_.accountId,_loc2_.sanctionType);
      }
      
      private function onCfhTopics(param1:CfhTopicsInitMessageEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:CfhTopicsInitMessageParser = param1.getParser();
         _loc2_ = _loc3_.callForHelpCategories;
         _moderationManager.cfhTopics = _loc2_;
      }
      
      private function onRoomEnter(param1:RoomEntryInfoMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:RoomEntryInfoMessageParser = param1.getParser();
         this._moderationManager.currentFlatId = _loc3_.guestRoomId;
         this._moderationManager.startPanel.guestRoomEntered(_loc3_);
         for each(_loc2_ in _roomEnterListeners)
         {
            _loc2_.onRoomChange();
         }
      }
      
      private function onRoomExit(param1:CloseConnectionMessageEvent) : void
      {
         var _loc2_:* = null;
         this._moderationManager.currentFlatId = 0;
         this._moderationManager.startPanel.roomExited();
         for each(_loc2_ in _roomEnterListeners)
         {
            _loc2_.onRoomChange();
         }
      }
      
      private function onModeratorActionResult(param1:ModeratorActionResultMessageEvent) : void
      {
         var _loc2_:ModeratorActionResultMessageParser = param1.getParser();
         Logger.log("GOT MOD ACTION RESULT: " + _loc2_.userId + ", " + _loc2_.success);
         if(_loc2_.success)
         {
            _moderationManager.connection.send(new GetModeratorUserInfoMessageComposer(_loc2_.userId));
         }
         else
         {
            _moderationManager.windowManager.alert("Alert","Moderation action failed. If you tried to ban a user, please check if the user is already banned.",0,onAlertClose);
         }
      }
      
      public function addUserInfoListener(param1:IUserInfoCtrl) : void
      {
         _userInfoListeners.push(param1);
      }
      
      public function removeUserInfoListener(param1:IUserInfoCtrl) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _userInfoListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _userInfoListeners = _loc3_;
      }
      
      public function addRoomInfoListener(param1:RoomToolCtrl) : void
      {
         _roomInfoListeners.push(param1);
      }
      
      public function removeRoomInfoListener(param1:RoomToolCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomInfoListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomInfoListeners = _loc3_;
      }
      
      public function addRoomEnterListener(param1:RoomToolCtrl) : void
      {
         _roomEnterListeners.push(param1);
      }
      
      public function removeRoomEnterListener(param1:RoomToolCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomEnterListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomEnterListeners = _loc3_;
      }
      
      public function addRoomVisitsListener(param1:RoomVisitsCtrl) : void
      {
         _roomVisitsListeners.push(param1);
      }
      
      public function removeRoomVisitsListener(param1:RoomVisitsCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomVisitsListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomVisitsListeners = _loc3_;
      }
      
      public function addChatlogListener(param1:IChatlogCtrl) : void
      {
         _chatlogListeners.push(param1);
      }
      
      public function removeChatlogListener(param1:IChatlogCtrl) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _chatlogListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _chatlogListeners = _loc3_;
      }
      
      public function addUserClassificationListener(param1:UserClassificationCtrl) : void
      {
         UnknownVarFromModerationMessageHandler_Array_1.push(param1);
      }
      
      public function removeUserClassificationListener(param1:UserClassificationCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in UnknownVarFromModerationMessageHandler_Array_1)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomVisitsListeners = _loc3_;
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
   }
}

