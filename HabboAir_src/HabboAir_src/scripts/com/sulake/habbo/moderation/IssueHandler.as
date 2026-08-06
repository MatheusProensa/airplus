package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpTopicData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetCfhChatlogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModToolPreferencesComposer;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   import flash.utils.getTimer;
   
   public class IssueHandler implements ITrackedWindow, IIssueHandler, IProfiler_1
   {
      private static const USELESS_REPORTS_TOPIC_ID:int = 27;
      
      private static const AUTO_TOPIC_ID:int = 28;
      
      private static const UnknownConstFromIssueHandler_Int_1:int = 1;
      
      private static const AUTO_TRIGGERED_CATEGORY_ID:int = 3;
      
      private var _moderationManager:ModerationManager;
      
      private var UnknownVarFromIssueHandler_IssueBundle_1:IssueBundle;
      
      private var UnknownVarFromIssueHandler_IssueMessageData_1:IssueMessageData;
      
      private var _window:IFrameController;
      
      private var _cfhCategories:Vector.<CallForHelpCategoryData>;
      
      private var UnknownVarFromIssueHandler_Array_1:Array;
      
      private var _topicDropdown:IDropBaseController_1;
      
      private var _callerUserInfo:UserInfoCtrl;
      
      private var _reportedUserInfo:UserInfoCtrl;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromIssueHandler_Int_1:int;
      
      private var UnknownVarFromIssueHandler_ChatlogCtrl_1:ChatlogCtrl;
      
      private var _chatFrame:IWindowController_1;
      
      private var UnknownVarFromIssueHandler_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromIssueHandler_Int_2:int = 0;
      
      private var UnknownVarFromIssueHandler_Int_3:int;
      
      private var UnknownVarFromIssueHandler_Int_4:int;
      
      private var _lastWindowWidth:int;
      
      private var UnknownVarFromIssueHandler_Int_5:int;
      
      private var UnknownVarFromIssueHandler_Uint_1:uint = getTimer();
      
      private var UnknownVarFromIssueHandler_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromIssueHandler_ITextFieldWindow_1:ITextFieldWindow;
      
      public function IssueHandler(param1:ModerationManager, param2:IssueBundle, param3:Vector.<CallForHelpCategoryData>, param4:int, param5:int, param6:int, param7:int)
      {
         super();
         _moderationManager = param1;
         UnknownVarFromIssueHandler_IssueBundle_1 = param2;
         _cfhCategories = param3;
         UnknownVarFromIssueHandler_Int_3 = param4;
         UnknownVarFromIssueHandler_Int_4 = param5;
         _lastWindowWidth = param6;
         UnknownVarFromIssueHandler_Int_5 = param7;
      }
      
      public function getType() : int
      {
         return 8;
      }
      
      public function getId() : String
      {
         return "" + UnknownVarFromIssueHandler_IssueBundle_1.id;
      }
      
      public function getFrame() : IFrameController
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(this._callerUserInfo != null)
         {
            this._callerUserInfo.dispose();
            this._callerUserInfo = null;
         }
         if(this._reportedUserInfo != null)
         {
            this._reportedUserInfo.dispose();
            this._reportedUserInfo = null;
         }
         if(this.UnknownVarFromIssueHandler_ChatlogCtrl_1 != null)
         {
            this.UnknownVarFromIssueHandler_ChatlogCtrl_1.dispose();
            this.UnknownVarFromIssueHandler_ChatlogCtrl_1 = null;
         }
         if(UnknownVarFromIssueHandler_IWindowController_1_1)
         {
            UnknownVarFromIssueHandler_IWindowController_1_1.dispose();
            UnknownVarFromIssueHandler_IWindowController_1_1 = null;
         }
         if(UnknownVarFromIssueHandler_ITextFieldWindow_1)
         {
            UnknownVarFromIssueHandler_ITextFieldWindow_1.dispose();
            UnknownVarFromIssueHandler_ITextFieldWindow_1 = null;
         }
         _moderationManager.removeUpdateReceiver(this);
         _moderationManager = null;
         UnknownVarFromIssueHandler_IssueBundle_1 = null;
      }
      
      public function show() : void
      {
         var _loc5_:IItemListWindow = null;
         var _loc6_:IWindowModel = null;
         if(_window != null)
         {
            return;
         }
         if(_moderationManager.windowManager == null || _moderationManager.assets == null)
         {
            return;
         }
         _window = _moderationManager.getXmlWindow("issue_handler") as IFrameController;
         if(_window == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = _window.findChildByName("issues_item_list") as IItemListWindow;
         UnknownVarFromIssueHandler_IWindowController_1_1 = _loc3_.getListItemAt(0) as IWindowController_1;
         _loc3_.removeListItems();
         var _loc2_:IItemListWindow = _window.findChildByName("msg_item_list") as IItemListWindow;
         UnknownVarFromIssueHandler_ITextFieldWindow_1 = _loc2_.getListItemAt(0) as ITextFieldWindow;
         _loc2_.removeListItems();
         var _loc7_:IWindowModel = _window.findChildByTag("close");
         if(_loc7_ != null)
         {
            _loc7_.addEventListener("WME_CLICK",onClose);
         }
         _loc7_ = _window.findChildByName("issue_cont");
         if(_loc7_ != null)
         {
            _loc7_.addEventListener("WE_RELOCATED",onWindowRelocatedOrResized);
            _loc7_.addEventListener("WE_RESIZED",onWindowRelocatedOrResized);
            _moderationManager.registerUpdateReceiver(this,1000);
         }
         UnknownVarFromIssueHandler_Uint_1 = getTimer();
         setProc("close_useless",onCloseUseless);
         setProc("close_sanction",onCloseSanction);
         setProc("close_resolved",onCloseResolved);
         setProc("release",onRelease);
         _loc7_ = _window.findChildByName("move_to_player_support");
         if(_loc7_ != null)
         {
            _loc7_.disable();
         }
         _moderationManager.issueManager.requestSanctionData(UnknownVarFromIssueHandler_IssueBundle_1.id,-1);
         initializeTopicDropdown();
         UnknownVarFromIssueHandler_IssueMessageData_1 = UnknownVarFromIssueHandler_IssueBundle_1.getHighestPriorityIssue();
         _callerUserInfo = new UserInfoCtrl(_window,_moderationManager,UnknownVarFromIssueHandler_IssueMessageData_1,this);
         _reportedUserInfo = new UserInfoCtrl(_window,_moderationManager,UnknownVarFromIssueHandler_IssueMessageData_1,this);
         _callerUserInfo.load(IWindowController_1(_window.findChildByName("caller_user_info")),UnknownVarFromIssueHandler_IssueMessageData_1.reporterUserId);
         if(UnknownVarFromIssueHandler_IssueMessageData_1.categoryId == 3 && UnknownVarFromIssueHandler_IssueMessageData_1.reportedCategoryId == 28)
         {
            _topicDropdown.selection = UnknownVarFromIssueHandler_Int_1;
            _moderationManager.issueManager.requestSanctionData(UnknownVarFromIssueHandler_IssueBundle_1.id,1);
         }
         var _loc1_:IWindowController_1 = IWindowController_1(_window.findChildByName("reported_user_info"));
         if(UnknownVarFromIssueHandler_IssueBundle_1.reportedUserId > 0)
         {
            _reportedUserInfo.load(_loc1_,UnknownVarFromIssueHandler_IssueBundle_1.reportedUserId);
         }
         else
         {
            _loc5_ = IItemListWindow(_window.findChildByName("issue_cont"));
            _loc6_ = _window.findChildByName("reported_user_info_caption");
            _loc5_.removeListItem(_loc6_);
            _loc5_.removeListItem(_loc1_);
         }
         var _loc4_:UnknownICoreWindowComponents2 = _window.findChildByName("handle_next_checkbox") as UnknownICoreWindowComponents2;
         if(_loc4_ != null)
         {
            _loc4_.select();
         }
         _chatFrame = IWindowController_1(_window.findChildByName("chat_cont"));
         UnknownVarFromIssueHandler_IItemListWindow_1 = IItemListWindow(_chatFrame.findChildByName("evidence_list"));
         UnknownVarFromIssueHandler_ChatlogCtrl_1 = new ChatlogCtrl(new GetCfhChatlogMessageComposer(UnknownVarFromIssueHandler_IssueMessageData_1.issueId),_moderationManager,3,UnknownVarFromIssueHandler_IssueMessageData_1.issueId,UnknownVarFromIssueHandler_IssueMessageData_1,_chatFrame,UnknownVarFromIssueHandler_IItemListWindow_1,true);
         UnknownVarFromIssueHandler_ChatlogCtrl_1.show();
         Logger.log("HARASSER: " + UnknownVarFromIssueHandler_IssueBundle_1.reportedUserId);
         updateIssueList();
         updateMessages();
      }
      
      private function sendWindowPreferences() : void
      {
         UnknownVarFromIssueHandler_Int_3 = _window.x;
         UnknownVarFromIssueHandler_Int_4 = _window.y;
         _lastWindowWidth = _window.width;
         UnknownVarFromIssueHandler_Int_5 = _window.height;
         _moderationManager.issueManager.setToolPreferences(UnknownVarFromIssueHandler_Int_3,UnknownVarFromIssueHandler_Int_4,_lastWindowWidth,UnknownVarFromIssueHandler_Int_5);
         _moderationManager.connection.send(new ModToolPreferencesComposer(UnknownVarFromIssueHandler_Int_3,UnknownVarFromIssueHandler_Int_4,_lastWindowWidth,UnknownVarFromIssueHandler_Int_5));
      }
      
      private function windowDimensionsChanged() : Boolean
      {
         if(UnknownVarFromIssueHandler_Int_3 != _window.x)
         {
            return true;
         }
         if(UnknownVarFromIssueHandler_Int_4 != _window.y)
         {
            return true;
         }
         if(_lastWindowWidth != _window.width)
         {
            return true;
         }
         if(UnknownVarFromIssueHandler_Int_5 != _window.height)
         {
            return true;
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(windowDimensionsChanged() && _loc2_ - UnknownVarFromIssueHandler_Uint_1 > 5000)
         {
            sendWindowPreferences();
         }
      }
      
      private function onWindowRelocatedOrResized(param1:WindowEvent) : void
      {
         var _loc4_:IItemListWindow = param1.window as IItemListWindow;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:IItemListWindow = _loc4_.getListItemByName("issues_item_list") as IItemListWindow;
         var _loc3_:IItemListWindow = _loc4_.getListItemByName("msg_item_list") as IItemListWindow;
         if(_loc5_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc2_:int = (_loc4_.height - _loc4_.scrollableRegion.height + _loc5_.height + _loc3_.height) * 0.5;
         _loc4_.autoArrangeItems = false;
         _loc5_.height = _loc2_;
         _loc3_.height = _loc2_;
         _loc4_.autoArrangeItems = true;
      }
      
      private function updateIssueList() : void
      {
         var _loc1_:IWindowController_1 = null;
         var _loc10_:IWindowController_1 = null;
         var _loc2_:IWindowModel = null;
         var _loc4_:* = null;
         var _loc13_:String = null;
         if(_window == null)
         {
            return;
         }
         var _loc6_:IItemListWindow = _window.findChildByName("issues_item_list") as IItemListWindow;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc8_:Array = UnknownVarFromIssueHandler_IssueBundle_1.issues;
         var _loc7_:int = 0;
         var _loc12_:int = _loc6_.numListItems;
         var _loc3_:int = int(_loc8_.length);
         if(_loc12_ < _loc3_)
         {
            _loc1_ = UnknownVarFromIssueHandler_IWindowController_1_1.clone() as IWindowController_1;
            _loc6_.addListItem(_loc1_);
            _loc7_ = 1;
            while(_loc7_ < _loc3_ - _loc12_)
            {
               _loc10_ = _loc1_.clone() as IWindowController_1;
               if(_loc10_ == null)
               {
                  return;
               }
               _loc6_.addListItem(_loc10_);
               _loc7_++;
            }
         }
         else if(_loc12_ > _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc12_ - _loc3_)
            {
               _loc2_ = _loc6_.removeListItemAt(0);
               _loc2_.dispose();
               _loc7_++;
            }
         }
         var _loc9_:IssueMessageData = UnknownVarFromIssueHandler_IssueBundle_1.getHighestPriorityIssue();
         var _loc11_:int = int(_loc9_ == null ? 0 : _loc9_.issueId);
         var _loc5_:int = getTimer();
         _loc7_ = 0;
         for each(_loc4_ in _loc8_)
         {
            _loc1_ = _loc6_.getListItemAt(_loc7_) as IWindowController_1;
            if(_loc1_ == null)
            {
               return;
            }
            _loc1_.background = _loc7_++ % 2 == 0;
            _loc1_.id = _loc4_.issueId;
            _loc1_.removeEventListener("WME_CLICK",onIssueClicked);
            _loc1_.addEventListener("WME_CLICK",onIssueClicked);
            setCaption(_loc1_.findChildByName("reporter"),_loc4_.reporterUserName);
            setCaption(_loc1_.findChildByName("type"),IssueCategoryNames.getSourceName(_loc4_.categoryId));
            setCaption(_loc1_.findChildByName("category"),IssueCategoryNames.getCategoryName(_loc4_.reportedCategoryId));
            setCaption(_loc1_.findChildByName("time_open"),_loc4_.getOpenTime(_loc5_));
            _loc13_ = _loc4_.issueId == _loc11_ && _loc3_ > 1 ? "Volter Bold" : "Volter";
            (_loc1_.findChildByName("category") as ITextWindow).fontFace = _loc13_;
         }
      }
      
      private function updateMessages() : void
      {
         var _loc1_:ITextFieldWindow = null;
         var _loc6_:ITextWindow = null;
         var _loc2_:IWindowModel = null;
         var _loc5_:* = null;
         if(_window == null)
         {
            return;
         }
         var _loc4_:IItemListWindow = _window.findChildByName("msg_item_list") as IItemListWindow;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc8_:Array = UnknownVarFromIssueHandler_IssueBundle_1.issues;
         var _loc7_:int = 0;
         var _loc9_:int = _loc4_.numListItems;
         var _loc3_:int = int(_loc8_.length);
         if(_loc9_ < _loc3_)
         {
            _loc1_ = UnknownVarFromIssueHandler_ITextFieldWindow_1.clone() as ITextFieldWindow;
            _loc1_.selectable = true;
            _loc1_.editable = false;
            _loc4_.addListItem(_loc1_);
            _loc7_ = 1;
            while(_loc7_ < _loc3_ - _loc9_)
            {
               _loc6_ = _loc1_.clone() as ITextWindow;
               if(_loc6_ == null)
               {
                  return;
               }
               _loc4_.addListItem(_loc6_);
               _loc7_++;
            }
         }
         else if(_loc9_ > _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc9_ - _loc3_)
            {
               _loc2_ = _loc4_.removeListItemAt(0);
               _loc2_.dispose();
               _loc7_++;
            }
         }
         _loc7_ = 0;
         for each(_loc5_ in _loc8_)
         {
            _loc1_ = _loc4_.getListItemAt(_loc7_) as ITextFieldWindow;
            if(_loc1_ == null)
            {
               return;
            }
            _loc1_.width = _loc4_.width;
            _loc1_.background = _loc7_++ % 2 == 0;
            _loc1_.caption = _loc5_.reporterUserName + ": " + _loc5_.message;
            _loc1_.height = _loc1_.textHeight + 10;
         }
      }
      
      private function setCaption(param1:IWindowModel, param2:String) : void
      {
         if(param1 != null)
         {
            param1.caption = param2;
         }
      }
      
      private function initializeTopicDropdown() : void
      {
         _topicDropdown = _window.findChildByName("cfh_topics") as IDropBaseController_1;
         var _loc1_:* = -1;
         var _loc6_:int = UnknownVarFromIssueHandler_IssueBundle_1.getHighestPriorityIssue().reportedCategoryId;
         if(_loc6_ == 27)
         {
            _topicDropdown.disable();
            return;
         }
         UnknownVarFromIssueHandler_Array_1 = [];
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         for each(var _loc5_ in _cfhCategories)
         {
            for each(var _loc4_ in _loc5_.topics)
            {
               _loc2_[_loc3_] = "${help.cfh.topic." + _loc4_.id + "}";
               UnknownVarFromIssueHandler_Array_1[_loc3_] = _loc4_.id;
               if(_loc4_.id == 1)
               {
                  UnknownVarFromIssueHandler_Int_1 = _loc3_;
               }
               if(_loc4_.id == _loc6_)
               {
                  _loc1_ = _loc3_;
               }
               _loc3_++;
            }
         }
         _topicDropdown.populate(_loc2_);
         if(_loc1_ >= 0)
         {
            _topicDropdown.selection = _loc1_;
         }
         _topicDropdown.addEventListener("WE_SELECTED",refreshSanctionDataForSelectedTopic);
      }
      
      private function refreshSanctionDataForSelectedTopic(param1:WindowEvent) : void
      {
         var _loc3_:int = _topicDropdown.selection;
         var _loc2_:int = int(UnknownVarFromIssueHandler_Array_1[_loc3_]);
         _moderationManager.issueManager.requestSanctionData(UnknownVarFromIssueHandler_IssueBundle_1.id,_loc2_);
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",param2);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         if(_moderationManager != null && _moderationManager.issueManager != null && UnknownVarFromIssueHandler_IssueBundle_1 != null)
         {
            _moderationManager.issueManager.removeHandler(UnknownVarFromIssueHandler_IssueBundle_1.id);
            trackAction("closeWindow");
         }
         this.dispose();
      }
      
      private function onCloseUseless(param1:WindowMouseEvent) : void
      {
         Logger.log("Close useless clicked");
         trackAction("closeUseless");
         _moderationManager.trackGoogle("actionCountUseless",UnknownVarFromIssueHandler_Int_2);
         _moderationManager.issueManager.closeBundle(UnknownVarFromIssueHandler_IssueBundle_1.id,1);
         checkAutoHandling();
         dispose();
      }
      
      private function onCloseResolved(param1:WindowMouseEvent) : void
      {
         Logger.log("Close resolved clicked");
         trackAction("closeResolved");
         _moderationManager.trackGoogle("actionCountResolved",UnknownVarFromIssueHandler_Int_2);
         _moderationManager.issueManager.closeBundle(UnknownVarFromIssueHandler_IssueBundle_1.id,3);
         checkAutoHandling();
         dispose();
      }
      
      private function onCloseSanction(param1:WindowMouseEvent) : void
      {
         Logger.log("Close with default sanction clicked");
         trackAction("closeSanction");
         _moderationManager.trackGoogle("actionCountSanction",UnknownVarFromIssueHandler_Int_2);
         var _loc2_:int = -1;
         var _loc3_:int = _topicDropdown.selection;
         if(_loc3_ >= 0)
         {
            _loc2_ = int(UnknownVarFromIssueHandler_Array_1[_loc3_]);
         }
         if(_loc2_ <= 0 && UnknownVarFromIssueHandler_IssueBundle_1.getHighestPriorityIssue().reportedCategoryId == 28)
         {
            _moderationManager.windowManager.alert("Topic missing","You need to select the topic first.",0,null);
         }
         else
         {
            _moderationManager.issueManager.closeDefaultAction(UnknownVarFromIssueHandler_IssueBundle_1.id,_loc2_);
            checkAutoHandling();
            dispose();
         }
      }
      
      private function onRelease(param1:WindowMouseEvent) : void
      {
         Logger.log("Release clicked");
         trackAction("release");
         _moderationManager.issueManager.releaseBundle(UnknownVarFromIssueHandler_IssueBundle_1.id);
         checkAutoHandling();
         dispose();
      }
      
      private function onIssueClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:int = 0;
         for each(var _loc2_ in UnknownVarFromIssueHandler_IssueBundle_1.issues)
         {
            if(_loc2_.issueId == param1.window.id)
            {
               UnknownVarFromIssueHandler_IssueMessageData_1 = _loc2_;
               _loc3_ = _loc2_.reporterUserId;
               if(_loc3_ != 0)
               {
                  if(_callerUserInfo != null)
                  {
                     _callerUserInfo.dispose();
                  }
                  _callerUserInfo = new UserInfoCtrl(_window,_moderationManager,_loc2_,this);
                  _callerUserInfo.load(IWindowController_1(_window.findChildByName("caller_user_info")),_loc3_);
                  _moderationManager.connection.send(new GetCfhChatlogMessageComposer(_loc2_.issueId));
                  UnknownVarFromIssueHandler_ChatlogCtrl_1.setId(_loc2_.issueId);
                  _moderationManager.messageHandler.addChatlogListener(UnknownVarFromIssueHandler_ChatlogCtrl_1);
               }
               break;
            }
         }
      }
      
      public function updateIssuesAndMessages() : void
      {
         updateIssueList();
         updateMessages();
      }
      
      public function showDefaultSanction(param1:int, param2:String) : void
      {
         if(_window == null || _moderationManager == null || _moderationManager.issueManager == null || UnknownVarFromIssueHandler_IssueBundle_1 == null)
         {
            return;
         }
         if(param1 != UnknownVarFromIssueHandler_IssueBundle_1.reportedUserId)
         {
            return;
         }
         var _loc3_:ITextWindow = _window.findChildByName("sanction_label") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = param2;
         }
      }
      
      private function checkAutoHandling() : void
      {
         if(_window == null || _moderationManager == null || _moderationManager.issueManager == null)
         {
            return;
         }
         var _loc1_:UnknownICoreWindowComponents2 = _window.findChildByName("handle_next_checkbox") as UnknownICoreWindowComponents2;
         if(_loc1_ != null && Boolean(_loc1_.isSelected))
         {
            _moderationManager.issueManager.autoPick("issue handler pick next");
         }
      }
      
      internal function get callerUserInfo() : UserInfoCtrl
      {
         return _callerUserInfo;
      }
      
      internal function get reportedUserInfo() : UserInfoCtrl
      {
         return _reportedUserInfo;
      }
      
      internal function trackAction(param1:String) : void
      {
         if(_moderationManager == null || _moderationManager.disposed)
         {
            return;
         }
         UnknownVarFromIssueHandler_Int_2++;
         _moderationManager.trackGoogle("issueHandler_" + param1);
      }
   }
}

