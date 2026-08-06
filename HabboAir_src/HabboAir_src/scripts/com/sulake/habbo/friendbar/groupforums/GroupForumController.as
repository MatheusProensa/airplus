package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.groupforums.ForumDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.ForumThreadsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.ForumsListMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.PostMessageMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.PostThreadMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.ThreadMessagesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.UnreadForumsCountMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.UpdateMessageMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.groupforums.UpdateThreadMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.GetForumStatsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.GetForumsListMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.GetMessagesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.GetThreadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.GetThreadsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.GetUnreadForumsCountMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateThreadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.PostMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumReadMarkerMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateThreadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumThreadsMessageParser;
   import com.sulake.habbo.communication.messages.parser.groupforums.GetForumsListMessageParser;
   import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
   import com.sulake.habbo.communication.messages.parser.groupforums.PostMessageMessageParser;
   import com.sulake.habbo.communication.messages.parser.groupforums.PostThreadMessageParser;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadMessagesMessageParser;
   import com.sulake.habbo.communication.messages.parser.groupforums.UpdateMessageMessageParser;
   import com.sulake.habbo.communication.messages.parser.groupforums.UpdateThreadMessageParser;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class GroupForumController extends Component implements UnknownIHabboFriendbarGroupforums1, ILinkEventTracker
   {
      public static const FORUMS_LIST_CODE_ACTIVE:int = 0;
      
      public static const FORUMS_LIST_CODE_POPULAR:int = 1;
      
      public static const FORUMS_LIST_CODE_MY_FORUMS:int = 2;
      
      public static const NO_ID:int = -1;
      
      private var _configurationManager:IComponent_1;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _help:IHabboHelp;
      
      private var _notifications:IHabboNotifications;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _habboTracking:IHabboTracking;
      
      private var UnknownVarFromGroupForumController_GroupForumView_1:GroupForumView;
      
      private var _composeMessageView:ComposeMessageView;
      
      private var _forumSettingsView:ForumSettingsView;
      
      private var _requestedForumsListCode:int = -1;
      
      private var UnknownVarFromGroupForumController_Int_1:int = -1;
      
      private var UnknownVarFromGroupForumController_ExtendedForumData_1:ExtendedForumData;
      
      private var UnknownVarFromGroupForumController_Int_2:int;
      
      private var UnknownVarFromGroupForumController_Int_3:int = 0;
      
      private var UnknownVarFromGroupForumController_ForumsListData_1:ForumsListData;
      
      private var UnknownVarFromGroupForumController_ThreadsListData_1:ThreadsListData;
      
      private var UnknownVarFromGroupForumController_MessagesListData_1:MessagesListData;
      
      private var _lastReadMessageIndexByThread:Dictionary = new Dictionary();
      
      private var _goToThreadId:int = -1;
      
      private var _goToMessageIndex:int;
      
      private var _lastPostTime:int = -30000;
      
      private var _unreadForumsCount:int = 0;
      
      private var UnknownVarFromGroupForumController_Timer_1:Timer;
      
      public function GroupForumController(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      public function get composeMessageView() : ComposeMessageView
      {
         return _composeMessageView;
      }
      
      public function set composeMessageView(param1:ComposeMessageView) : void
      {
         _composeMessageView = param1;
      }
      
      public function get forumSettingsView() : ForumSettingsView
      {
         return _forumSettingsView;
      }
      
      public function set forumSettingsView(param1:ForumSettingsView) : void
      {
         _forumSettingsView = param1;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get lastPostTime() : int
      {
         return _lastPostTime;
      }
      
      public function get unreadForumsCount() : int
      {
         return _unreadForumsCount;
      }
      
      public function get tracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),function(param1:IComponent_1):void
         {
            _configurationManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _help = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _habboTracking = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),null)]);
      }
      
      override protected function initComponent() : void
      {
         _communicationManager.addHabboConnectionMessageEvent(new ForumsListMessageEvent(onForumsList));
         _communicationManager.addHabboConnectionMessageEvent(new ForumThreadsMessageEvent(onThreadList));
         _communicationManager.addHabboConnectionMessageEvent(new ForumDataMessageEvent(onForumData));
         _communicationManager.addHabboConnectionMessageEvent(new UnreadForumsCountMessageEvent(onUnreadForumsCountMessage));
         _communicationManager.addHabboConnectionMessageEvent(new PostMessageMessageEvent(onPostMessageMessage));
         _communicationManager.addHabboConnectionMessageEvent(new PostThreadMessageEvent(onPostThreadMessage));
         _communicationManager.addHabboConnectionMessageEvent(new UpdateThreadMessageEvent(onUpdateThread));
         _communicationManager.addHabboConnectionMessageEvent(new UpdateMessageMessageEvent(onUpdateMessage));
         _communicationManager.addHabboConnectionMessageEvent(new ThreadMessagesMessageEvent(onThreadMessageList));
         context.addLinkEventTracker(this);
         startPollingForUnreadForumsCount();
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromGroupForumController_Timer_1 != null)
         {
            UnknownVarFromGroupForumController_Timer_1.stop();
            UnknownVarFromGroupForumController_Timer_1 = null;
         }
         super.dispose();
      }
      
      private function startPollingForUnreadForumsCount() : void
      {
         var _loc1_:int = _configurationManager.getInteger("groupforum.poll.period",300);
         UnknownVarFromGroupForumController_Timer_1 = new Timer(_loc1_ * 1000,0);
         UnknownVarFromGroupForumController_Timer_1.addEventListener("timer",onUnreadForumsCountUpdateTimerEvent);
         UnknownVarFromGroupForumController_Timer_1.start();
         onUnreadForumsCountUpdateTimerEvent(null);
      }
      
      public function openGroupForum(param1:int) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         initForum(param1);
         requestThreadList(param1,0);
      }
      
      public function get linkPattern() : String
      {
         return "groupforum/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(!_communicationManager)
         {
            return;
         }
         var _loc3_:Array = param1.split("/");
         if(_loc3_.length < 2)
         {
            return;
         }
         if(_loc3_[1] == "list")
         {
            if(_loc3_.length == 3)
            {
               switch(_loc3_[2])
               {
                  case "active":
                     _loc5_ = 0;
                     break;
                  case "popular":
                     _loc5_ = 1;
                     break;
                  case "my":
                     _loc5_ = 2;
                     break;
                  default:
                     return;
               }
               openForumsList(_loc5_);
            }
         }
         else
         {
            _loc6_ = int(_loc3_[1]);
            if(_loc6_ == 0)
            {
               return;
            }
            UnknownVarFromGroupForumController_ForumsListData_1 = null;
            if(_loc3_.length == 2)
            {
               openGroupForum(_loc6_);
            }
            else
            {
               _loc2_ = int(_loc3_[2]);
               _loc4_ = 0;
               if(_loc3_.length > 3)
               {
                  _loc4_ = int(_loc3_[3]);
               }
               initForum(_loc6_);
               _communicationManager.connection.send(new GetThreadMessageComposer(_loc6_,_loc2_));
               goToMessageIndex(_loc6_,_loc2_,_loc4_);
            }
         }
      }
      
      public function openForumsList(param1:int, param2:int = 0) : void
      {
         markForumAsRead();
         _requestedForumsListCode = param1;
         UnknownVarFromGroupForumController_Int_1 = -1;
         _communicationManager.connection.send(new GetForumsListMessageComposer(param1,param2,20));
      }
      
      private function onForumsList(param1:ForumsListMessageEvent) : void
      {
         var _loc3_:GetForumsListMessageParser = param1.getParser();
         var _loc2_:ForumsListData = new ForumsListData(_loc3_);
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 != null && UnknownVarFromGroupForumController_Int_3 > 0)
         {
            _loc2_.updateUnreadMessages(UnknownVarFromGroupForumController_ExtendedForumData_1,UnknownVarFromGroupForumController_Int_3);
         }
         if(_loc2_.listCode == 2)
         {
            updateUnreadForumsCount(_loc2_.unreadForumsCount);
         }
         if(_requestedForumsListCode != _loc2_.listCode)
         {
            return;
         }
         UnknownVarFromGroupForumController_ForumsListData_1 = _loc2_;
         if(!UnknownVarFromGroupForumController_GroupForumView_1)
         {
            UnknownVarFromGroupForumController_GroupForumView_1 = new GroupForumView(this);
         }
         UnknownVarFromGroupForumController_GroupForumView_1.openForumsList(UnknownVarFromGroupForumController_ForumsListData_1);
      }
      
      private function initForum(param1:int) : void
      {
         markForumAsRead();
         _requestedForumsListCode = -1;
         UnknownVarFromGroupForumController_Int_1 = param1;
         UnknownVarFromGroupForumController_Int_3 = 0;
         _communicationManager.connection.send(new GetForumStatsMessageComposer(param1));
      }
      
      private function onForumData(param1:ForumDataMessageEvent) : void
      {
         var _loc2_:Map = null;
         var _loc3_:String = null;
         var _loc4_:ExtendedForumData = param1.getParser().forumData;
         if(UnknownVarFromGroupForumController_Int_1 != _loc4_.groupId)
         {
            return;
         }
         if(!_loc4_.canRead)
         {
            if(UnknownVarFromGroupForumController_GroupForumView_1 != null)
            {
               UnknownVarFromGroupForumController_GroupForumView_1.dispose();
            }
            UnknownVarFromGroupForumController_ExtendedForumData_1 = null;
            UnknownVarFromGroupForumController_Int_1 = 0;
            _loc2_ = new Map();
            _loc3_ = localizationManager.getLocalization("groupforum.view.error.operation_read");
            _loc2_.add("message",localizationManager.getLocalizationWithParams("groupforum.view.error." + _loc4_.readPermissionError,"","operation",_loc3_));
            notifications.showNotification("forums.error.access_denied",_loc2_);
            return;
         }
         UnknownVarFromGroupForumController_ExtendedForumData_1 = _loc4_;
         UnknownVarFromGroupForumController_Int_3 = _loc4_.lastReadMessageId;
      }
      
      public function requestThreadList(param1:int, param2:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new GetThreadsMessageComposer(param1,param2,20));
         }
      }
      
      private function onThreadList(param1:ForumThreadsMessageEvent) : void
      {
         var _loc2_:ForumThreadsMessageParser = param1.getParser();
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 == null || UnknownVarFromGroupForumController_ExtendedForumData_1.groupId != _loc2_.groupId)
         {
            return;
         }
         UnknownVarFromGroupForumController_ThreadsListData_1 = new ThreadsListData(UnknownVarFromGroupForumController_ExtendedForumData_1.totalThreads,_loc2_.startIndex,_loc2_.threads);
         if(!UnknownVarFromGroupForumController_GroupForumView_1)
         {
            UnknownVarFromGroupForumController_GroupForumView_1 = new GroupForumView(this);
         }
         UnknownVarFromGroupForumController_GroupForumView_1.openThreadList(UnknownVarFromGroupForumController_ForumsListData_1,UnknownVarFromGroupForumController_ExtendedForumData_1,UnknownVarFromGroupForumController_ThreadsListData_1);
      }
      
      public function requestThreadMessageList(param1:int, param2:int, param3:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new GetMessagesMessageComposer(param1,param2,param3,20));
         }
      }
      
      private function onThreadMessageList(param1:ThreadMessagesMessageEvent) : void
      {
         var _loc6_:MessageData = null;
         var _loc3_:ThreadMessagesMessageParser = param1.getParser();
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 == null || UnknownVarFromGroupForumController_ExtendedForumData_1.groupId != _loc3_.groupId || UnknownVarFromGroupForumController_ThreadsListData_1 == null)
         {
            return;
         }
         UnknownVarFromGroupForumController_Int_2 = _loc3_.threadId;
         var _loc2_:ThreadData = UnknownVarFromGroupForumController_ThreadsListData_1.threadsById[UnknownVarFromGroupForumController_Int_2];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc3_.startIndex;
         var _loc5_:int = _loc2_.nMessages;
         UnknownVarFromGroupForumController_MessagesListData_1 = new MessagesListData(UnknownVarFromGroupForumController_Int_2,_loc5_,_loc4_,_loc3_.messages);
         if(!UnknownVarFromGroupForumController_GroupForumView_1)
         {
            UnknownVarFromGroupForumController_GroupForumView_1 = new GroupForumView(this);
         }
         UnknownVarFromGroupForumController_GroupForumView_1.openMessagesList(UnknownVarFromGroupForumController_ForumsListData_1,UnknownVarFromGroupForumController_ExtendedForumData_1,UnknownVarFromGroupForumController_ThreadsListData_1,UnknownVarFromGroupForumController_MessagesListData_1);
         if(_loc3_.messages.length > 0)
         {
            _loc6_ = MessageData(_loc3_.messages[_loc3_.messages.length - 1]);
            if(_loc6_)
            {
               updateUnreadMessageCounts(_loc6_.messageId,_loc6_.threadId,_loc6_.messageIndex);
            }
         }
      }
      
      public function updateForumSettings(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new UpdateForumSettingsMessageComposer(param1,param2,param3,param4,param5));
         }
      }
      
      public function postNewThread(param1:int, param2:String, param3:String) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new PostMessageMessageComposer(param1,0,param2,param3));
            _lastPostTime = getTimer();
         }
      }
      
      private function onPostThreadMessage(param1:PostThreadMessageEvent) : void
      {
         var _loc3_:ForumData = null;
         var _loc2_:PostThreadMessageParser = PostThreadMessageParser(param1.getParser());
         if(_composeMessageView)
         {
            _composeMessageView.dispose();
         }
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 != null && UnknownVarFromGroupForumController_ExtendedForumData_1.groupId == _loc2_.groupId)
         {
            updateUnreadMessageCounts(_loc2_.thread.lastMessageId,_loc2_.thread.threadId,_loc2_.thread.nMessages - 1);
         }
         if(UnknownVarFromGroupForumController_ForumsListData_1 != null)
         {
            _loc3_ = UnknownVarFromGroupForumController_ForumsListData_1.getForumData(_loc2_.groupId);
            if(_loc3_ != null)
            {
               _loc3_.addNewThread(_loc2_.thread);
            }
         }
         if(UnknownVarFromGroupForumController_GroupForumView_1 == null)
         {
            return;
         }
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 == null || _loc2_.groupId != UnknownVarFromGroupForumController_ExtendedForumData_1.groupId)
         {
            return;
         }
         requestThreadList(UnknownVarFromGroupForumController_ExtendedForumData_1.groupId,0);
      }
      
      public function postNewMessage(param1:int, param2:int, param3:String) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new PostMessageMessageComposer(param1,param2,"",param3));
            _lastPostTime = getTimer();
         }
      }
      
      private function onPostMessageMessage(param1:PostMessageMessageEvent) : void
      {
         if(_composeMessageView)
         {
            _composeMessageView.dispose();
         }
         if(UnknownVarFromGroupForumController_GroupForumView_1 == null)
         {
            return;
         }
         var _loc2_:PostMessageMessageParser = PostMessageMessageParser(param1.getParser());
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 == null || _loc2_.groupId != UnknownVarFromGroupForumController_ExtendedForumData_1.groupId || _loc2_.threadId != UnknownVarFromGroupForumController_Int_2)
         {
            return;
         }
         var _loc3_:int = _loc2_.message.messageIndex - _loc2_.message.messageIndex % 20;
         requestThreadMessageList(UnknownVarFromGroupForumController_ExtendedForumData_1.groupId,UnknownVarFromGroupForumController_Int_2,_loc3_);
      }
      
      public function deleteThread(param1:ExtendedForumData, param2:int) : void
      {
         var _loc3_:int = 0;
         if(_communicationManager)
         {
            if(param1.canModerate)
            {
               _loc3_ = 10;
            }
            if(param1.isStaff)
            {
               _loc3_ = 20;
            }
            _communicationManager.connection.send(new ModerateThreadMessageComposer(param1.groupId,param2,_loc3_));
         }
      }
      
      public function unDeleteThread(param1:ForumData, param2:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new ModerateThreadMessageComposer(param1.groupId,param2,1));
         }
      }
      
      public function lockThread(param1:ForumData, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new UpdateThreadMessageComposer(param1.groupId,param2,param3,param4));
         }
      }
      
      public function stickThread(param1:ForumData, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new UpdateThreadMessageComposer(param1.groupId,param2,param3,param4));
         }
      }
      
      public function reportThread(param1:ForumData, param2:int) : void
      {
         if(_help)
         {
            _help.reportThread(param1.groupId,param2);
         }
      }
      
      private function onUpdateThread(param1:UpdateThreadMessageEvent) : void
      {
         var _loc2_:UpdateThreadMessageParser = param1.getParser();
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 == null || UnknownVarFromGroupForumController_ExtendedForumData_1.groupId != _loc2_.groupId)
         {
            return;
         }
         var _loc3_:ThreadData = _loc2_.thread;
         if(UnknownVarFromGroupForumController_ThreadsListData_1 && UnknownVarFromGroupForumController_GroupForumView_1)
         {
            if(UnknownVarFromGroupForumController_ThreadsListData_1.updateThread(_loc3_))
            {
               UnknownVarFromGroupForumController_GroupForumView_1.updateThread(_loc3_);
               return;
            }
         }
         UnknownVarFromGroupForumController_ThreadsListData_1 = new ThreadsListData(1,0,[_loc3_]);
      }
      
      public function deleteMessage(param1:ExtendedForumData, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         if(_communicationManager)
         {
            _loc4_ = 10;
            if(param1.isStaff)
            {
               _loc4_ = 20;
            }
            _communicationManager.connection.send(new ModerateMessageMessageComposer(UnknownVarFromGroupForumController_ExtendedForumData_1.groupId,param2,param3,_loc4_));
         }
      }
      
      public function unDeleteMessage(param1:ForumData, param2:int, param3:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new ModerateMessageMessageComposer(param1.groupId,param2,param3,1));
         }
      }
      
      public function reportMessage(param1:ForumData, param2:int, param3:int) : void
      {
         if(_help)
         {
            _help.reportMessage(param1.groupId,param2,param3);
         }
      }
      
      private function onUpdateMessage(param1:UpdateMessageMessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:MessageData = null;
         var _loc3_:UpdateMessageMessageParser = param1.getParser();
         if(UnknownVarFromGroupForumController_ExtendedForumData_1 == null || UnknownVarFromGroupForumController_ExtendedForumData_1.groupId != _loc3_.groupId || UnknownVarFromGroupForumController_Int_2 != _loc3_.threadId)
         {
            return;
         }
         var _loc2_:MessageData = _loc3_.message;
         var _loc4_:Array = UnknownVarFromGroupForumController_MessagesListData_1["messages"];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.messageId == _loc2_.messageId)
            {
               _loc4_[_loc5_] = _loc2_;
               if(UnknownVarFromGroupForumController_GroupForumView_1)
               {
                  UnknownVarFromGroupForumController_GroupForumView_1.updateMessage(_loc2_);
               }
               return;
            }
            _loc5_++;
         }
      }
      
      public function goToMessageIndex(param1:int, param2:int, param3:int) : void
      {
         _goToThreadId = param2;
         var _loc4_:int = Math.floor(param3 / 20);
         _goToMessageIndex = param3 % 20;
         requestThreadMessageList(param1,param2,_loc4_ * 20);
      }
      
      public function getUserInfo(param1:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new GetExtendedProfileMessageComposer(param1));
         }
      }
      
      public function closeMainView() : void
      {
         markForumAsRead();
         UnknownVarFromGroupForumController_GroupForumView_1 = null;
         UnknownVarFromGroupForumController_ExtendedForumData_1 = null;
         _requestedForumsListCode = -1;
         UnknownVarFromGroupForumController_Int_1 = -1;
      }
      
      public function markForumAsRead(param1:Boolean = false) : void
      {
         var _loc2_:UpdateForumReadMarkerMessageComposer = null;
         if(_communicationManager && UnknownVarFromGroupForumController_ExtendedForumData_1)
         {
            if(param1 || UnknownVarFromGroupForumController_Int_3 > UnknownVarFromGroupForumController_ExtendedForumData_1.lastReadMessageId)
            {
               _loc2_ = new UpdateForumReadMarkerMessageComposer();
               if(param1)
               {
                  _loc2_.add(UnknownVarFromGroupForumController_ExtendedForumData_1.groupId,Math.max(UnknownVarFromGroupForumController_ExtendedForumData_1.totalMessages,UnknownVarFromGroupForumController_Int_3),UnknownVarFromGroupForumController_Int_3 == 0);
               }
               else
               {
                  _loc2_.add(UnknownVarFromGroupForumController_ExtendedForumData_1.groupId,UnknownVarFromGroupForumController_Int_3,false);
               }
               _communicationManager.connection.send(_loc2_);
            }
         }
         UnknownVarFromGroupForumController_Int_3 = 0;
         _lastReadMessageIndexByThread = new Dictionary();
      }
      
      public function markForumsAsRead() : void
      {
         var _loc1_:UpdateForumReadMarkerMessageComposer = null;
         if(_communicationManager && UnknownVarFromGroupForumController_ForumsListData_1)
         {
            _loc1_ = new UpdateForumReadMarkerMessageComposer();
            for each(var _loc2_ in UnknownVarFromGroupForumController_ForumsListData_1.forums)
            {
               if(_loc2_.unreadMessages > 0)
               {
                  _loc1_.add(_loc2_.groupId,_loc2_.totalMessages,true);
               }
            }
            if(_loc1_.size > 0)
            {
               _communicationManager.connection.send(_loc1_);
               updateUnreadForumsCount(0);
            }
         }
      }
      
      public function getThreadLastReadMessageIndex(param1:int) : int
      {
         var _loc3_:ThreadData = null;
         var _loc2_:* = _lastReadMessageIndexByThread[param1];
         if(_loc2_ != null)
         {
            return int(_loc2_);
         }
         if(UnknownVarFromGroupForumController_ThreadsListData_1)
         {
            _loc3_ = UnknownVarFromGroupForumController_ThreadsListData_1.threadsById[param1];
            if(_loc3_)
            {
               return _loc3_.nMessages - _loc3_.nUnreadMessages - 1;
            }
         }
         return -1;
      }
      
      public function updateUnreadMessageCounts(param1:int, param2:int, param3:int) : void
      {
         if(param1 > UnknownVarFromGroupForumController_Int_3)
         {
            UnknownVarFromGroupForumController_Int_3 = param1;
            if(UnknownVarFromGroupForumController_ForumsListData_1)
            {
               UnknownVarFromGroupForumController_ForumsListData_1.updateUnreadMessages(UnknownVarFromGroupForumController_ExtendedForumData_1,param1);
               if(UnknownVarFromGroupForumController_ForumsListData_1.listCode == 2)
               {
                  updateUnreadForumsCount(UnknownVarFromGroupForumController_ForumsListData_1.unreadForumsCount);
               }
            }
         }
         _lastReadMessageIndexByThread[param2] = param3;
      }
      
      public function getGoToMessageIndex() : int
      {
         return _goToMessageIndex;
      }
      
      public function getGoToThreadId() : int
      {
         return _goToThreadId;
      }
      
      public function resetGoTo() : void
      {
         _goToThreadId = -1;
         _goToMessageIndex = -1;
      }
      
      public function updateUnreadForumsCount(param1:int) : void
      {
         if(_unreadForumsCount == param1)
         {
            return;
         }
         if(param1 > _unreadForumsCount)
         {
            if(_soundManager != null)
            {
            }
         }
         _unreadForumsCount = param1;
         events.dispatchEvent(new UnseenForumsCountUpdatedEvent("UNSEEN_FORUMS_COUNT",param1));
         if(UnknownVarFromGroupForumController_GroupForumView_1 != null)
         {
            UnknownVarFromGroupForumController_GroupForumView_1.updateUnreadForumsCount(param1);
         }
      }
      
      private function onUnreadForumsCountUpdateTimerEvent(param1:TimerEvent) : void
      {
         if(UnknownVarFromGroupForumController_GroupForumView_1 != null)
         {
            _communicationManager.connection.send(new GetForumsListMessageComposer(2,0,20));
         }
         else
         {
            _communicationManager.connection.send(new GetUnreadForumsCountMessageComposer());
         }
      }
      
      private function onUnreadForumsCountMessage(param1:UnreadForumsCountMessageEvent) : void
      {
         updateUnreadForumsCount(param1.getParser().unreadForumsCount);
      }
   }
}

