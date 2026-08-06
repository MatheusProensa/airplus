package com.sulake.habbo.messenger
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.catalog.habbicons.IHabbiconController;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.friendlist.ConsoleMessageHistoryEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.MiniMailNewMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.MiniMailUnreadCountEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
   import com.sulake.habbo.communication.messages.parser.friendlist.ConsoleMessageHistoryMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.MiniMailUnreadCountMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.friendlist.UnknownIHabboFriendlist1;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.messenger.events.ActiveConversationEvent;
   import com.sulake.habbo.messenger.events.MiniMailMessageEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabbiconController;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class HabboMessenger extends Component implements IHabboMessenger, ILinkEventTracker
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _friendList:IHabboFriendList;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _tracking:IHabboTracking;
      
      private var _unseenMiniMailMessageCount:int = 0;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _help:IHabboHelp;
      
      private var _habbiconController:IHabbiconController;
      
      private var UnknownVarFromHabboMessenger_MainView_1:MainView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _roomInvitesIgnored:Boolean = false;
      
      private var _followingToGroupRoom:Boolean = false;
      
      public function HabboMessenger(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _help = param1;
         }),new ComponentDependency(new IIDHabbiconController(),function(param1:IHabbiconController):void
         {
            _habbiconController = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new MessengerInitEvent(onMessengerInit));
         addMessageEvent(new AccountPreferencesEvent(onAccountPreferences));
         addMessageEvent(new HabboGroupDetailsMessageEvent(onHabboGroupDetails));
         if(getBoolean("client.minimail.embed.enabled"))
         {
            addMessageEvent(new MiniMailNewMessageEvent(onMiniMailMessage));
            addMessageEvent(new MiniMailUnreadCountEvent(onMiniMailUnreadCount));
         }
         context.addLinkEventTracker(this);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         super.dispose();
      }
      
      private function onMiniMailMessage(param1:IMessageEvent) : void
      {
         _unseenMiniMailMessageCount++;
         playMessageReceivedSound();
         events.dispatchEvent(new MiniMailMessageEvent("MMME_new",_unseenMiniMailMessageCount));
      }
      
      private function onMiniMailUnreadCount(param1:IMessageEvent) : void
      {
         _unseenMiniMailMessageCount = (param1.parser as MiniMailUnreadCountMessageParser).unreadMessageCount;
         events.dispatchEvent(new MiniMailMessageEvent("MMME_unread",_unseenMiniMailMessageCount));
      }
      
      private function onAccountPreferences(param1:AccountPreferencesEvent) : void
      {
         _roomInvitesIgnored = param1.getParser().roomInvitesIgnored;
      }
      
      private function onHabboGroupDetails(param1:HabboGroupDetailsMessageEvent) : void
      {
         if(_followingToGroupRoom)
         {
            _followingToGroupRoom = false;
            send(new OpenFlatConnectionMessageComposer(param1.data.roomId));
         }
      }
      
      public function getRoomInvitesIgnored() : Boolean
      {
         return _roomInvitesIgnored;
      }
      
      public function setRoomInvitesIgnored(param1:Boolean) : void
      {
         _roomInvitesIgnored = param1;
      }
      
      private function onMessengerInit(param1:IMessageEvent) : void
      {
         UnknownVarFromHabboMessenger_MainView_1 = new MainView(this);
         addMessageEvent(new NewConsoleMessageEvent(onNewConsoleMessage));
         addMessageEvent(new ConsoleMessageHistoryEvent(onConsoleHistory));
         addMessageEvent(new InstantMessageErrorEvent(onInstantMessageError));
         addMessageEvent(new RoomInviteEvent(onRoomInvite));
      }
      
      public function startConversation(param1:int) : void
      {
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.startConversation(param1);
            UnknownVarFromHabboMessenger_MainView_1.show(true);
         }
      }
      
      public function getUnseenMiniMailMessageCount() : int
      {
         return _unseenMiniMailMessageCount;
      }
      
      public function setFollowingAllowed(param1:int, param2:Boolean) : void
      {
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.setFollowingAllowed(param1,param2);
         }
      }
      
      public function setOnlineStatus(param1:int, param2:Boolean) : void
      {
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.setOnlineStatus(param1,param2);
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function playSendSound() : void
      {
         if(_soundManager != null)
         {
            _soundManager.playSound("HBST_message_sent");
         }
      }
      
      public function isOpen() : Boolean
      {
         return UnknownVarFromHabboMessenger_MainView_1 != null && UnknownVarFromHabboMessenger_MainView_1.isOpen;
      }
      
      public function toggleMessenger() : void
      {
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.toggle();
         }
      }
      
      public function hideTransientSelectors() : void
      {
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.hideTransientSelectors();
         }
      }
      
      public function getText(param1:String) : String
      {
         return _localization.getLocalization(param1,param1);
      }
      
      private function onNewConsoleMessage(param1:NewConsoleMessageEvent) : void
      {
         var _loc2_:NewConsoleMessageMessageParser = param1.getParser();
         Logger.log("Received console msg: " + _loc2_.messageText + ", " + _loc2_.chatId);
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.addConsoleMessage(int(_loc2_.chatId),_loc2_.messageType,_loc2_.messageText,_loc2_.habbiconId,_loc2_.secondsSinceSent,_loc2_.messageId,_loc2_.confirmationId,int(_loc2_.senderId),_loc2_.senderName,_loc2_.senderFigure);
            if(!UnknownVarFromHabboMessenger_MainView_1.isOpen)
            {
               playMessageReceivedSound();
            }
         }
      }
      
      private function onConsoleHistory(param1:ConsoleMessageHistoryEvent) : void
      {
         var _loc2_:ConsoleMessageHistoryMessageParser = param1.getParser();
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.loadMessageHistory(_loc2_.chatId,_loc2_.historyFragment);
         }
      }
      
      private function onRoomInvite(param1:RoomInviteEvent) : void
      {
         var _loc2_:RoomInviteMessageParser = param1.getParser();
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.addRoomInvite(_loc2_.senderId,_loc2_.messageText);
            if(!UnknownVarFromHabboMessenger_MainView_1.isOpen)
            {
               playMessageReceivedSound();
            }
         }
      }
      
      private function playMessageReceivedSound() : void
      {
         if(_soundManager != null)
         {
            _soundManager.playSound("HBST_message_received");
         }
      }
      
      private function onInstantMessageError(param1:IMessageEvent) : void
      {
         var _loc2_:InstantMessageErrorMessageParser = (param1 as InstantMessageErrorEvent).getParser();
         if(UnknownVarFromHabboMessenger_MainView_1 != null)
         {
            UnknownVarFromHabboMessenger_MainView_1.onInstantMessageError(_loc2_.userId,_loc2_.errorCode,_loc2_.message);
         }
      }
      
      public function conversationCountUpdated(param1:int, param2:Boolean) : void
      {
         events.dispatchEvent(new ActiveConversationEvent("ACCE_changed",param1,param2));
      }
      
      public function getXmlWindow(param1:String) : IWindowModel
      {
         var _loc3_:ISoundAsset = assets.getAssetByName(param1 + "_xml");
         var _loc2_:XmlAsset = XmlAsset(_loc3_);
         return _windowManager.buildFromXML(XML(_loc2_.content));
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      internal function getFriend(param1:int, param2:ChatEntry = null) : UnknownIHabboFriendlist1
      {
         var _loc3_:UnknownIHabboFriendlist1 = _friendList.getFriend(param1);
         if(_loc3_ == null && param2 != null)
         {
            return new DummyFriend(param2.senderId,param2.senderName,param2.senderFigure);
         }
         return _loc3_;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get habbiconController() : IHabbiconController
      {
         return _habbiconController;
      }
      
      internal function reportUser(param1:int) : void
      {
         _help.reportUserFromIM(param1);
      }
      
      public function set followingToGroupRoom(param1:Boolean) : void
      {
         _followingToGroupRoom = param1;
      }
      
      public function closeConversation(param1:int) : void
      {
         UnknownVarFromHabboMessenger_MainView_1.hideConversation(param1);
      }
      
      public function get linkPattern() : String
      {
         return "messenger/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:int = int(_loc2_[1]);
         startConversation(_loc3_);
      }
   }
}

