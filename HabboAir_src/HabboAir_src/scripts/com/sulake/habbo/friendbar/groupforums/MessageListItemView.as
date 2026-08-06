package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class MessageListItemView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromMessageListItemView_GroupForumView_1:GroupForumView;
      
      private var UnknownVarFromMessageListItemView_GroupForumController_1:GroupForumController;
      
      private var _window:IWindowController_1;
      
      private var _headerLineContainer:IWindowController_1;
      
      private var UnknownVarFromMessageListItemView_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromMessageListItemView_ITextWindow_2:ITextWindow;
      
      private var UnknownVarFromMessageListItemView_IWindowController_1_1:IWindowController_1;
      
      private var _messageArea:IWindowController_1;
      
      private var UnknownVarFromMessageListItemView_IWindowController_1_2:IWindowController_1;
      
      private var _avatarWidget:IAvatarImageWidget;
      
      private var _author:ITextWindow;
      
      private var UnknownVarFromMessageListItemView_ITextWindow_3:ITextWindow;
      
      private var UnknownVarFromMessageListItemView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromMessageListItemView_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromMessageListItemView_IRegionWindow_2:IRegionWindow;
      
      private var UnknownVarFromMessageListItemView_IRegionWindow_3:IRegionWindow;
      
      private var UnknownVarFromMessageListItemView_ITextWindow_4:ITextWindow;
      
      private var UnknownVarFromMessageListItemView_Vector_1:Vector.<ITextWindow>;
      
      private var UnknownVarFromMessageListItemView_Vector_2:Vector.<ITextWindow>;
      
      private var UnknownVarFromMessageListItemView_ExtendedForumData_1:ExtendedForumData;
      
      private var UnknownVarFromMessageListItemView_ThreadData_1:ThreadData;
      
      private var UnknownVarFromMessageListItemView_MessageData_1:MessageData;
      
      private var UnknownVarFromMessageListItemView_String_1:String;
      
      private var _hasPendingAvatarLoad:Boolean;
      
      public function MessageListItemView(param1:IWindowController_1, param2:GroupForumView)
      {
         super();
         bind(param2);
         _window = param1.clone() as IWindowController_1;
         _headerLineContainer = _window.findChildByName("texts_container") as IWindowController_1;
         UnknownVarFromMessageListItemView_ITextWindow_1 = _headerLineContainer.findChildByName("date") as ITextWindow;
         UnknownVarFromMessageListItemView_ITextWindow_2 = _headerLineContainer.findChildByName("reply_num") as ITextWindow;
         UnknownVarFromMessageListItemView_IWindowController_1_1 = _window.findChildByName("msg_container") as IWindowController_1;
         _messageArea = _window.findChildByName("message_text_container") as IWindowController_1;
         UnknownVarFromMessageListItemView_IWindowController_1_2 = _window.findChildByName("avatar_image") as IWindowController_1;
         _avatarWidget = IWidgetWindowController(UnknownVarFromMessageListItemView_IWindowController_1_2.findChildByName("avatar_widget")).widget as IAvatarImageWidget;
         _author = UnknownVarFromMessageListItemView_IWindowController_1_2.findChildByName("author") as ITextWindow;
         UnknownVarFromMessageListItemView_ITextWindow_3 = UnknownVarFromMessageListItemView_IWindowController_1_2.findChildByName("author_post_count") as ITextWindow;
         UnknownVarFromMessageListItemView_IRegionWindow_1 = _window.findChildByName("delete_message") as IRegionWindow;
         UnknownVarFromMessageListItemView_IStaticBitmapWrapperWindow_1 = UnknownVarFromMessageListItemView_IRegionWindow_1.getChildByName("icon") as IStaticBitmapWrapperWindow;
         UnknownVarFromMessageListItemView_IRegionWindow_2 = _window.findChildByName("report_message") as IRegionWindow;
         UnknownVarFromMessageListItemView_IRegionWindow_3 = _window.findChildByName("reply_message") as IRegionWindow;
         UnknownVarFromMessageListItemView_ITextWindow_4 = _messageArea.findChildByName("message_text") as ITextWindow;
         _messageArea.removeChild(UnknownVarFromMessageListItemView_ITextWindow_4);
         UnknownVarFromMessageListItemView_Vector_1 = new Vector.<ITextWindow>();
         UnknownVarFromMessageListItemView_Vector_2 = new Vector.<ITextWindow>();
         UnknownVarFromMessageListItemView_IWindowController_1_2.addEventListener("WME_CLICK",onSelectAuthor);
         UnknownVarFromMessageListItemView_IRegionWindow_1.addEventListener("WME_CLICK",onDeleteOrUndelete);
         UnknownVarFromMessageListItemView_IRegionWindow_2.addEventListener("WME_CLICK",onReport);
         UnknownVarFromMessageListItemView_IRegionWindow_3.addEventListener("WME_CLICK",onReply);
      }
      
      public function bind(param1:GroupForumView) : void
      {
         UnknownVarFromMessageListItemView_GroupForumView_1 = param1;
         UnknownVarFromMessageListItemView_GroupForumController_1 = UnknownVarFromMessageListItemView_GroupForumView_1.controller;
      }
      
      public function initialize(param1:ExtendedForumData, param2:ThreadData, param3:MessageData, param4:Boolean = false) : void
      {
         UnknownVarFromMessageListItemView_ExtendedForumData_1 = param1;
         UnknownVarFromMessageListItemView_ThreadData_1 = param2;
         UnknownVarFromMessageListItemView_MessageData_1 = param3;
         _window.name = "message_" + param3.messageId;
         _headerLineContainer.id = param3.messageId;
         UnknownVarFromMessageListItemView_ITextWindow_1.caption = UnknownVarFromMessageListItemView_GroupForumView_1.getAsDaysHoursMinutes(param3.creationTimeAsSecondsAgo);
         UnknownVarFromMessageListItemView_ITextWindow_2.caption = "#" + (param3.messageIndex + 1);
         var _loc5_:int = param4 ? -1 : param3.state;
         updateMessageText(_loc5_);
         var _loc6_:Array = MessageListView.getMessageColorForState(_loc5_);
         UnknownVarFromMessageListItemView_IWindowController_1_1.color = _loc6_[0];
         UnknownVarFromMessageListItemView_IWindowController_1_2.color = _loc6_[1];
         UnknownVarFromMessageListItemView_IWindowController_1_2.id = param3.authorId;
         updateAvatar();
         _author.caption = param3.authorName;
         UnknownVarFromMessageListItemView_ITextWindow_3.caption = param3.authorPostCount + " " + UnknownVarFromMessageListItemView_GroupForumController_1.localizationManager.getLocalization("messageboard.messages","posts");
         handleButtonVisibility(_loc5_);
      }
      
      private function updateMessageText(param1:int) : void
      {
         recycleTextBlocks();
         if(param1 == 20 && !UnknownVarFromMessageListItemView_ExtendedForumData_1.isStaff)
         {
            addPlainTextBlock(MessageListView.getModerationMessage(UnknownVarFromMessageListItemView_GroupForumController_1,UnknownVarFromMessageListItemView_MessageData_1));
         }
         else if(param1 > 1 && !UnknownVarFromMessageListItemView_ExtendedForumData_1.canModerate)
         {
            addPlainTextBlock(MessageListView.getModerationMessage(UnknownVarFromMessageListItemView_GroupForumController_1,UnknownVarFromMessageListItemView_MessageData_1));
         }
         else
         {
            initMessageText(UnknownVarFromMessageListItemView_MessageData_1.messageText);
         }
      }
      
      private function handleButtonVisibility(param1:int) : void
      {
         var _loc3_:Boolean = UnknownVarFromMessageListItemView_ExtendedForumData_1.canModerate;
         var _loc2_:Boolean = UnknownVarFromMessageListItemView_ExtendedForumData_1.isStaff;
         UnknownVarFromMessageListItemView_IRegionWindow_1.visible = true;
         UnknownVarFromMessageListItemView_IRegionWindow_1.enable();
         UnknownVarFromMessageListItemView_IStaticBitmapWrapperWindow_1.assetUri = "forum_forum_hide";
         if(_loc3_)
         {
            switch(param1 - 10)
            {
               case 0:
                  UnknownVarFromMessageListItemView_IStaticBitmapWrapperWindow_1.assetUri = "forum_forum_unhide";
                  break;
               case 10:
                  if(_loc2_)
                  {
                     UnknownVarFromMessageListItemView_IStaticBitmapWrapperWindow_1.assetUri = "forum_forum_unhide";
                     break;
                  }
                  UnknownVarFromMessageListItemView_IRegionWindow_1.visible = false;
                  UnknownVarFromMessageListItemView_IRegionWindow_1.disable();
                  break;
            }
         }
         else
         {
            UnknownVarFromMessageListItemView_IRegionWindow_1.visible = false;
            UnknownVarFromMessageListItemView_IRegionWindow_1.disable();
         }
         UnknownVarFromMessageListItemView_IRegionWindow_2.visible = UnknownVarFromMessageListItemView_ExtendedForumData_1.canReport;
         if(UnknownVarFromMessageListItemView_IRegionWindow_2.visible)
         {
            UnknownVarFromMessageListItemView_IRegionWindow_2.enable();
         }
         else
         {
            UnknownVarFromMessageListItemView_IRegionWindow_2.disable();
         }
         UnknownVarFromMessageListItemView_IRegionWindow_3.visible = UnknownVarFromMessageListItemView_ExtendedForumData_1.canPostMessage;
         if(UnknownVarFromMessageListItemView_IRegionWindow_3.visible)
         {
            UnknownVarFromMessageListItemView_IRegionWindow_3.enable();
         }
         else
         {
            UnknownVarFromMessageListItemView_IRegionWindow_3.disable();
         }
      }
      
      private function addPlainTextBlock(param1:String) : void
      {
         var _loc2_:ITextWindow = claimTextBlock();
         _loc2_.text = param1 == null ? "" : param1;
      }
      
      private function updateAvatar() : void
      {
         UnknownVarFromMessageListItemView_String_1 = UnknownVarFromMessageListItemView_MessageData_1.authorFigure;
         _avatarWidget.figure = UnknownVarFromMessageListItemView_String_1;
      }
      
      private function initMessageText(param1:String) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = undefined;
         var _loc7_:Array = param1.split("\r");
         var _loc2_:StringBuffer = new StringBuffer();
         var _loc5_:* = 0;
         for each(var _loc4_ in _loc7_)
         {
            _loc6_ = 0;
            _loc3_ = MessageListView.UnknownConstFromMessageListView_RegExp_1.exec(_loc4_);
            if(_loc3_ != null)
            {
               _loc6_ = 1;
               _loc4_ = _loc4_.substr(_loc3_[0].length);
            }
            if(_loc6_ != _loc5_)
            {
               addTextBlock(_loc2_,_loc5_);
               _loc5_ = _loc6_;
            }
            else if(_loc2_.length > 0)
            {
               _loc2_.add("\r");
            }
            parseMessageChunk(_loc2_,_loc4_);
         }
         addTextBlock(_loc2_,_loc5_);
      }
      
      private function parseMessageChunk(param1:StringBuffer, param2:String) : void
      {
         var _loc3_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc4_:String = null;
         while(true)
         {
            _loc3_ = MessageListView.LINE_PATTERN.exec(param2);
            if(!_loc3_)
            {
               break;
            }
            if(_loc3_.index > 0)
            {
               param1.addEscaped(param2.substr(0,_loc3_.index));
            }
            _loc5_ = Number(_loc3_[0].length);
            switch(param2.charAt(_loc3_.index))
            {
               case "*":
                  param1.add(" <b>");
                  parseMessageChunk(param1,param2.substr(_loc3_.index + 1,_loc5_ - 2));
                  param1.add("</b> ");
                  break;
               case "_":
                  param1.add(" <i>");
                  parseMessageChunk(param1,param2.substr(_loc3_.index + 1,_loc5_ - 2));
                  param1.add("</i> ");
                  break;
               case "@":
                  if(_loc3_.index == 0 || _loc3_.index > 0 && param2.substr(_loc3_.index - 1,1) == " ")
                  {
                     _loc4_ = param2.substr(_loc3_.index + 1,_loc5_ - 1);
                     param1.add("<u>").addEscaped(_loc4_).add("</u>");
                     break;
                  }
                  param1.add("@");
                  param2 = param2.substr(_loc3_.index + 1);
                  continue;
               default:
                  param1.add(param2.charAt(_loc3_.index + 1));
                  param2 = param2.substr(_loc3_.index + 2);
                  continue;
            }
            param2 = param2.substr(_loc3_.index + _loc5_);
         }
         param1.addEscaped(param2);
      }
      
      private function addTextBlock(param1:StringBuffer, param2:int) : void
      {
         var _loc4_:String = param1.toString();
         var _loc3_:ITextWindow = claimTextBlock();
         _loc3_.htmlText = _loc4_;
         if(param2 > 0)
         {
            _loc3_.x = UnknownVarFromMessageListItemView_ITextWindow_4.x + param2 * 20;
            _loc3_.width = UnknownVarFromMessageListItemView_ITextWindow_4.width - (param2 + 1) * 20;
            _loc3_.color = 4291611852;
            _loc3_.background = true;
         }
         param1.reset();
      }
      
      private function claimTextBlock() : ITextWindow
      {
         var _loc1_:ITextWindow = UnknownVarFromMessageListItemView_Vector_1.length > 0 ? UnknownVarFromMessageListItemView_Vector_1.pop() : ITextWindow(UnknownVarFromMessageListItemView_ITextWindow_4.clone());
         _loc1_.x = UnknownVarFromMessageListItemView_ITextWindow_4.x;
         _loc1_.y = UnknownVarFromMessageListItemView_ITextWindow_4.y;
         _loc1_.width = UnknownVarFromMessageListItemView_ITextWindow_4.width;
         _loc1_.height = UnknownVarFromMessageListItemView_ITextWindow_4.height;
         _loc1_.color = UnknownVarFromMessageListItemView_ITextWindow_4.color;
         _loc1_.background = UnknownVarFromMessageListItemView_ITextWindow_4.background;
         _loc1_.text = "";
         _messageArea.addChild(_loc1_);
         UnknownVarFromMessageListItemView_Vector_2.push(_loc1_);
         return _loc1_;
      }
      
      private function recycleTextBlocks() : void
      {
         for each(var _loc1_ in UnknownVarFromMessageListItemView_Vector_2)
         {
            if(_loc1_.parent != null)
            {
               IWindowController_1(_loc1_.parent).removeChild(_loc1_);
            }
            _loc1_.x = UnknownVarFromMessageListItemView_ITextWindow_4.x;
            _loc1_.y = UnknownVarFromMessageListItemView_ITextWindow_4.y;
            _loc1_.width = UnknownVarFromMessageListItemView_ITextWindow_4.width;
            _loc1_.height = UnknownVarFromMessageListItemView_ITextWindow_4.height;
            _loc1_.color = UnknownVarFromMessageListItemView_ITextWindow_4.color;
            _loc1_.background = UnknownVarFromMessageListItemView_ITextWindow_4.background;
            _loc1_.text = "";
            UnknownVarFromMessageListItemView_Vector_1.push(_loc1_);
         }
         UnknownVarFromMessageListItemView_Vector_2.length = 0;
      }
      
      private function onReport(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMessageListItemView_MessageData_1 != null)
         {
            UnknownVarFromMessageListItemView_GroupForumController_1.reportMessage(UnknownVarFromMessageListItemView_ExtendedForumData_1,UnknownVarFromMessageListItemView_ThreadData_1.threadId,UnknownVarFromMessageListItemView_MessageData_1.messageId);
         }
      }
      
      private function onDeleteOrUndelete(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMessageListItemView_MessageData_1 == null)
         {
            return;
         }
         if(UnknownVarFromMessageListItemView_MessageData_1.state == 10 || UnknownVarFromMessageListItemView_MessageData_1.state == 20 && UnknownVarFromMessageListItemView_ExtendedForumData_1.isStaff)
         {
            UnknownVarFromMessageListItemView_GroupForumController_1.unDeleteMessage(UnknownVarFromMessageListItemView_ExtendedForumData_1,UnknownVarFromMessageListItemView_ThreadData_1.threadId,UnknownVarFromMessageListItemView_MessageData_1.messageId);
         }
         else
         {
            UnknownVarFromMessageListItemView_GroupForumController_1.deleteMessage(UnknownVarFromMessageListItemView_ExtendedForumData_1,UnknownVarFromMessageListItemView_ThreadData_1.threadId,UnknownVarFromMessageListItemView_MessageData_1.messageId);
         }
      }
      
      private function onSelectAuthor(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMessageListItemView_MessageData_1 != null)
         {
            UnknownVarFromMessageListItemView_GroupForumController_1.getUserInfo(UnknownVarFromMessageListItemView_MessageData_1.authorId);
         }
      }
      
      private function onReply(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMessageListItemView_MessageData_1 != null)
         {
            UnknownVarFromMessageListItemView_GroupForumView_1.openComposeMessageView(UnknownVarFromMessageListItemView_ThreadData_1,UnknownVarFromMessageListItemView_MessageData_1);
         }
      }
      
      public function recycle() : void
      {
         recycleTextBlocks();
         UnknownVarFromMessageListItemView_ExtendedForumData_1 = null;
         UnknownVarFromMessageListItemView_ThreadData_1 = null;
         UnknownVarFromMessageListItemView_MessageData_1 = null;
         UnknownVarFromMessageListItemView_String_1 = null;
         _hasPendingAvatarLoad = false;
         _window.name = "";
         _headerLineContainer.id = 0;
         UnknownVarFromMessageListItemView_ITextWindow_1.caption = "";
         UnknownVarFromMessageListItemView_ITextWindow_2.caption = "";
         _author.caption = "";
         UnknownVarFromMessageListItemView_ITextWindow_3.caption = "";
         UnknownVarFromMessageListItemView_IRegionWindow_1.visible = true;
         UnknownVarFromMessageListItemView_IRegionWindow_1.enable();
         UnknownVarFromMessageListItemView_IRegionWindow_2.visible = true;
         UnknownVarFromMessageListItemView_IRegionWindow_2.enable();
         UnknownVarFromMessageListItemView_IRegionWindow_3.visible = true;
         UnknownVarFromMessageListItemView_IRegionWindow_3.enable();
      }
      
      public function get messageId() : int
      {
         return UnknownVarFromMessageListItemView_MessageData_1?.messageId;
      }
      
      public function get hasPendingAvatarLoad() : Boolean
      {
         return _hasPendingAvatarLoad;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         recycleTextBlocks();
         for each(var _loc1_ in UnknownVarFromMessageListItemView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromMessageListItemView_Vector_1 = null;
         UnknownVarFromMessageListItemView_ITextWindow_4.dispose();
         UnknownVarFromMessageListItemView_ITextWindow_4 = null;
         UnknownVarFromMessageListItemView_IWindowController_1_2.removeEventListener("WME_CLICK",onSelectAuthor);
         UnknownVarFromMessageListItemView_IRegionWindow_1.removeEventListener("WME_CLICK",onDeleteOrUndelete);
         UnknownVarFromMessageListItemView_IRegionWindow_2.removeEventListener("WME_CLICK",onReport);
         UnknownVarFromMessageListItemView_IRegionWindow_3.removeEventListener("WME_CLICK",onReply);
         _window.dispose();
         _window = null;
         UnknownVarFromMessageListItemView_Vector_2 = null;
         UnknownVarFromMessageListItemView_IRegionWindow_3 = null;
         UnknownVarFromMessageListItemView_IRegionWindow_2 = null;
         UnknownVarFromMessageListItemView_IStaticBitmapWrapperWindow_1 = null;
         UnknownVarFromMessageListItemView_IRegionWindow_1 = null;
         UnknownVarFromMessageListItemView_ITextWindow_3 = null;
         _author = null;
         _avatarWidget = null;
         UnknownVarFromMessageListItemView_IWindowController_1_2 = null;
         _messageArea = null;
         UnknownVarFromMessageListItemView_IWindowController_1_1 = null;
         UnknownVarFromMessageListItemView_ITextWindow_2 = null;
         UnknownVarFromMessageListItemView_ITextWindow_1 = null;
         _headerLineContainer = null;
         UnknownVarFromMessageListItemView_MessageData_1 = null;
         UnknownVarFromMessageListItemView_ThreadData_1 = null;
         UnknownVarFromMessageListItemView_ExtendedForumData_1 = null;
         UnknownVarFromMessageListItemView_String_1 = null;
         _hasPendingAvatarLoad = false;
         UnknownVarFromMessageListItemView_GroupForumController_1 = null;
         UnknownVarFromMessageListItemView_GroupForumView_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

