package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   import com.sulake.habbo.utils.FriendlyTime;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class ComposeMessageView
   {
      public static const SUBJECT_MIN_LENGTH:int = 10;
      
      public static const SUBJECT_MAX_LENGTH:int = 120;
      
      public static const MESSAGE_MIN_LENGTH:int = 10;
      
      public static const MESSAGE_MAX_LENGTH:int = 4000;
      
      public static const UnknownConstFromComposeMessageView_Int_1:int = 30000;
      
      private var UnknownVarFromComposeMessageView_GroupForumController_1:GroupForumController;
      
      private var UnknownVarFromComposeMessageView_GroupForumView_1:GroupForumView;
      
      private var UnknownVarFromComposeMessageView_Timer_1:Timer;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromComposeMessageView_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromComposeMessageView_ITextFieldWindow_2:ITextFieldWindow;
      
      private var UnknownVarFromComposeMessageView_IWindowModel_1:IWindowModel;
      
      private var _status:IWindowModel;
      
      private var UnknownVarFromComposeMessageView_ForumData_1:ForumData;
      
      private var UnknownVarFromComposeMessageView_ThreadData_1:ThreadData;
      
      private var _hasErrors:Boolean = false;
      
      private var UnknownVarFromComposeMessageView_Boolean_1:Boolean = false;
      
      public function ComposeMessageView(param1:GroupForumView, param2:int, param3:int, param4:ForumData, param5:ThreadData, param6:MessageData)
      {
         super();
         UnknownVarFromComposeMessageView_GroupForumView_1 = param1;
         UnknownVarFromComposeMessageView_GroupForumController_1 = UnknownVarFromComposeMessageView_GroupForumView_1.controller;
         UnknownVarFromComposeMessageView_ForumData_1 = param4;
         UnknownVarFromComposeMessageView_ThreadData_1 = param5;
         _window = IFrameController(UnknownVarFromComposeMessageView_GroupForumController_1.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_compose_message_xml())));
         _window.x = param2;
         var _loc7_:int = int(UnknownVarFromComposeMessageView_GroupForumController_1.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc7_)
         {
            _window.x = _loc7_ - _window.width;
         }
         _window.y = param3;
         initControls(param6);
         if(_status.caption.length == 0)
         {
            _status.caption = UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalization("groupforum.compose.reply_hint");
         }
         UnknownVarFromComposeMessageView_Timer_1 = new Timer(1000,0);
         UnknownVarFromComposeMessageView_Timer_1.addEventListener("timer",onTimerEvent);
         UnknownVarFromComposeMessageView_Timer_1.start();
      }
      
      public function focus(param1:ForumData, param2:ThreadData, param3:MessageData) : void
      {
         if(!UnknownVarFromComposeMessageView_Boolean_1)
         {
            UnknownVarFromComposeMessageView_ForumData_1 = param1;
            if(UnknownVarFromComposeMessageView_ThreadData_1 != null && param2 == null)
            {
               UnknownVarFromComposeMessageView_ITextFieldWindow_1.text = "";
            }
            UnknownVarFromComposeMessageView_ThreadData_1 = param2;
            initControls(param3);
         }
         _window.activate();
      }
      
      private function initControls(param1:MessageData) : void
      {
         var _loc3_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,UnknownVarFromComposeMessageView_ForumData_1);
         _loc3_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc3_.addEventListener("WME_CLICK",onTopAreaClick);
         var _loc5_:IWindowModel = _window.findChildByName("thread_subject_header");
         UnknownVarFromComposeMessageView_ITextFieldWindow_1 = _window.findChildByName("thread_subject") as ITextFieldWindow;
         if(UnknownVarFromComposeMessageView_ThreadData_1)
         {
            _loc5_.caption = UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalization("groupforum.compose.subject_replying_to");
            UnknownVarFromComposeMessageView_ITextFieldWindow_1.text = UnknownVarFromComposeMessageView_ThreadData_1.header;
            UnknownVarFromComposeMessageView_ITextFieldWindow_1.disable();
         }
         else
         {
            _loc5_.caption = UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalization("groupforum.compose.subject");
            UnknownVarFromComposeMessageView_ITextFieldWindow_1.addEventListener("WKE_KEY_UP",onHeaderKeyUpEvent);
            UnknownVarFromComposeMessageView_ITextFieldWindow_1.maxChars = 120;
            UnknownVarFromComposeMessageView_ITextFieldWindow_1.enable();
         }
         UnknownVarFromComposeMessageView_ITextFieldWindow_2 = _window.findChildByName("message_text") as ITextFieldWindow;
         UnknownVarFromComposeMessageView_ITextFieldWindow_2.removeEventListener("WKE_KEY_UP",onMessageKeyUpEvent);
         UnknownVarFromComposeMessageView_ITextFieldWindow_2.addEventListener("WKE_KEY_UP",onMessageKeyUpEvent);
         UnknownVarFromComposeMessageView_ITextFieldWindow_2.maxChars = 4000;
         if(param1 != null)
         {
            addQuote(param1);
         }
         var _loc2_:IWindowModel = _window.findChildByName("cancel_btn");
         _loc2_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc2_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc4_:IWindowModel = _window.findChildByName("header_button_close");
         _loc4_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc4_.addEventListener("WME_CLICK",onCancelButtonClick);
         UnknownVarFromComposeMessageView_IWindowModel_1 = _window.findChildByName("post_btn");
         UnknownVarFromComposeMessageView_IWindowModel_1.removeEventListener("WME_CLICK",onPostButtonClick);
         UnknownVarFromComposeMessageView_IWindowModel_1.addEventListener("WME_CLICK",onPostButtonClick);
         _status = _window.findChildByName("status_text");
         validateInputs();
      }
      
      private function addQuote(param1:MessageData) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:StringBuffer = new StringBuffer();
         _loc4_.add(UnknownVarFromComposeMessageView_ITextFieldWindow_2.text);
         if(_loc4_.length > 0)
         {
            _loc4_.add("\r\r");
         }
         _loc4_.add(UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.compose.reply_template","","author_name",param1.authorName,"creation_time",UnknownVarFromComposeMessageView_GroupForumView_1.getAsDaysHoursMinutes(param1.creationTimeAsSecondsAgo)));
         _loc4_.add("\r");
         var _loc5_:Array = param1.messageText.split("\r");
         var _loc6_:Boolean = false;
         for each(var _loc3_ in _loc5_)
         {
            _loc2_ = MessageListView.UnknownConstFromMessageListView_RegExp_1.exec(_loc3_);
            if(_loc2_ != null)
            {
               if(!_loc6_)
               {
                  _loc6_ = true;
                  _loc4_.add("> ").add(UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalization("groupforum.compose.skipped_quote")).add("\r");
               }
            }
            else
            {
               _loc4_.add("> ").add(_loc3_).add("\r");
               _loc6_ = false;
            }
         }
         _loc4_.add("\r");
         UnknownVarFromComposeMessageView_ITextFieldWindow_2.text = _loc4_.toString();
      }
      
      public function dispose() : void
      {
         UnknownVarFromComposeMessageView_Timer_1.stop();
         UnknownVarFromComposeMessageView_Timer_1.removeEventListener("timer",onTimerEvent);
         UnknownVarFromComposeMessageView_Timer_1 = null;
         UnknownVarFromComposeMessageView_GroupForumController_1.composeMessageView = null;
         _window.dispose();
         _window = null;
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         validateInputs();
      }
      
      private function onHeaderKeyUpEvent(param1:WindowKeyboardEvent) : void
      {
         validateInputs();
      }
      
      private function onMessageKeyUpEvent(param1:WindowKeyboardEvent) : void
      {
         validateInputs();
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromComposeMessageView_GroupForumController_1.context.createLinkEvent("group/" + UnknownVarFromComposeMessageView_ForumData_1.groupId);
      }
      
      private function onPostButtonClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromComposeMessageView_Boolean_1)
         {
            return;
         }
         validateInputs();
         if(_hasErrors)
         {
            return;
         }
         UnknownVarFromComposeMessageView_Boolean_1 = true;
         UnknownVarFromComposeMessageView_ITextFieldWindow_1.disable();
         UnknownVarFromComposeMessageView_ITextFieldWindow_2.disable();
         UnknownVarFromComposeMessageView_IWindowModel_1.disable();
         _status.caption = UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalization("groupforum.compose.posting");
         if(UnknownVarFromComposeMessageView_ThreadData_1)
         {
            UnknownVarFromComposeMessageView_GroupForumController_1.postNewMessage(UnknownVarFromComposeMessageView_ForumData_1.groupId,UnknownVarFromComposeMessageView_ThreadData_1.threadId,UnknownVarFromComposeMessageView_ITextFieldWindow_2.text);
         }
         else
         {
            UnknownVarFromComposeMessageView_GroupForumController_1.postNewThread(UnknownVarFromComposeMessageView_ForumData_1.groupId,UnknownVarFromComposeMessageView_ITextFieldWindow_1.text,UnknownVarFromComposeMessageView_ITextFieldWindow_2.text);
         }
      }
      
      private function onCancelButtonClick(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function validateInputs() : void
      {
         var _loc1_:int = 0;
         _hasErrors = false;
         if(!UnknownVarFromComposeMessageView_ThreadData_1)
         {
            if(UnknownVarFromComposeMessageView_ITextFieldWindow_1.text.length <= 10)
            {
               _hasErrors = true;
               _status.caption = UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalization("groupforum.compose.subject_too_short");
            }
         }
         if(!_hasErrors && UnknownVarFromComposeMessageView_ITextFieldWindow_2.text.length <= 10)
         {
            _hasErrors = true;
            _status.caption = UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalization("groupforum.compose.message_too_short");
         }
         if(!_hasErrors && !UnknownVarFromComposeMessageView_Boolean_1)
         {
            _loc1_ = getTimer() - UnknownVarFromComposeMessageView_GroupForumController_1.lastPostTime;
            if(_loc1_ < 30000)
            {
               _hasErrors = true;
               _status.caption = UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager.getLocalizationWithParams("groupforum.compose.post_cooldown","","time_remaining",FriendlyTime.getFriendlyTime(UnknownVarFromComposeMessageView_GroupForumController_1.localizationManager,(30000 - _loc1_) / 1000 + 1,"",1));
            }
         }
         if(!UnknownVarFromComposeMessageView_Boolean_1 && !_hasErrors)
         {
            UnknownVarFromComposeMessageView_IWindowModel_1.enable();
            _status.caption = "";
         }
         else
         {
            UnknownVarFromComposeMessageView_IWindowModel_1.disable();
         }
      }
   }
}

