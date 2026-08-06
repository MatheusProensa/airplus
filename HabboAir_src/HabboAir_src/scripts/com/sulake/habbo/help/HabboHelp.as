package com.sulake.habbo.help
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
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageParser;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.MyCfhReportStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.MySanctionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpDisabledNotifyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsDeletedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideReportingStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveFriendMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GetCfhMyReportStatus;
   import com.sulake.habbo.communication.messages.outgoing.help.GetGuideReportingStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GetMySanctionStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.GetPendingCallsForHelpMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.talent.GuideAdvertisementReadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.HumanGameObjectData;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsMessageParser;
   import com.sulake.habbo.communication.messages.parser.help.GuideReportingStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.help.cfh.registry.chat.ChatEventHandler;
   import com.sulake.habbo.help.cfh.registry.chat.ChatRegistry;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageEventHandler;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistry;
   import com.sulake.habbo.help.cfh.registry.user.UserRegistry;
   import com.sulake.habbo.help.namechange.NameChangeController;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HabboHelp extends Component implements IHabboHelp, ILinkEventTracker
   {
      public static const REPORT_TYPE_EMERGENCY:int = 1;
      
      public static const REPORT_TYPE_GUIDE:int = 2;
      
      public static const REPORT_TYPE_IM:int = 3;
      
      public static const REPORT_TYPE_ROOM:int = 4;
      
      public static const REPORT_TYPE_BULLY:int = 6;
      
      public static const REPORT_TYPE_THREAD:int = 7;
      
      public static const REPORT_TYPE_MESSAGE:int = 8;
      
      public static const REPORT_TYPE_PHOTO:int = 9;
      
      private var _toolbar:IHabboToolbar;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _tracking:IHabboTracking;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _friendList:IHabboFriendList;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromHabboHelp_ChatEventHandler_1:ChatEventHandler;
      
      private var UnknownVarFromHabboHelp_InstantMessageEventHandler_1:InstantMessageEventHandler;
      
      private var _guideHelpManager:GuideHelpManager;
      
      private var _userRegistry:UserRegistry = new UserRegistry();
      
      private var _chatRegistry:ChatRegistry = new ChatRegistry();
      
      private var _instantMessageRegistry:InstantMessageRegistry = new InstantMessageRegistry();
      
      private var UnknownVarFromHabboHelp_NameChangeController_1:NameChangeController;
      
      private var _callForHelpManager:CallForHelpManager;
      
      private var UnknownVarFromHabboHelp_WelcomeScreenController_1:WelcomeScreenController;
      
      private var UnknownVarFromHabboHelp_HabboWayController_1:HabboWayController;
      
      private var UnknownVarFromHabboHelp_HabboWayQuizController_1:HabboWayQuizController;
      
      private var UnknownVarFromHabboHelp_SafetyBookletController_1:SafetyBookletController;
      
      private var _outsideRoom:Boolean;
      
      private var UnknownVarFromHabboHelp_Int_1:int;
      
      private var _reportMessage:IMessageComposer;
      
      private var UnknownVarFromHabboHelp_Int_2:int = -1;
      
      private var UnknownVarFromHabboHelp_Int_3:int;
      
      private var _callForHelpCategories:Vector.<CallForHelpCategoryData>;
      
      private var UnknownVarFromHabboHelp_TopicsFlowHelpController_1:TopicsFlowHelpController;
      
      private var _sanctionInfo:SanctionInfo;
      
      private var _reportStatus:MyReportStatus;
      
      public function HabboHelp(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get navigator() : IHabboNavigator_1
      {
         return _navigator;
      }
      
      public function get tracking() : IHabboTracking
      {
         return _tracking;
      }
      
      public function get soundManager() : IHabboSoundManagerFlash10
      {
         return _soundManager;
      }
      
      public function get freeFlowChat() : IHabboFreeFlowChat
      {
         return _freeFlowChat;
      }
      
      public function get newUserTourEnabled() : Boolean
      {
         return getBoolean("guide.help.new.user.tour.enabled");
      }
      
      public function get newIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function get citizenshipEnabled() : Boolean
      {
         return getBoolean("talent.track.citizenship.enabled");
      }
      
      public function get safetyQuizDisabled() : Boolean
      {
         return getBoolean("safety_quiz.disabled");
      }
      
      public function requestGuide() : void
      {
         if(getBoolean("guides.enabled"))
         {
            _guideHelpManager.createHelpRequest(0);
         }
      }
      
      public function reportBully(param1:int) : void
      {
         if(_callForHelpManager != null)
         {
            _callForHelpManager.reportBully(param1,UnknownVarFromHabboHelp_Int_3);
         }
      }
      
      public function startPhotoReportingInNewCfhFlow(param1:int, param2:String, param3:String, param4:int) : void
      {
         if(_callForHelpManager != null)
         {
            _callForHelpManager.reportedRoomId = UnknownVarFromHabboHelp_Int_3;
            _callForHelpManager.reportedUserId = param1;
            _callForHelpManager.reportedUserName = param2;
            _callForHelpManager.reportedRoomObjectId = param4;
            _callForHelpManager.reportedExtraDataId = param3;
            UnknownVarFromHabboHelp_TopicsFlowHelpController_1.openReportingContentReasonCategory(9);
         }
      }
      
      public function reportUser(param1:int, param2:int, param3:String) : void
      {
         _callForHelpManager.reportedUserId = param1;
         UnknownVarFromHabboHelp_TopicsFlowHelpController_1.openReportingChatLineSelection();
      }
      
      public function reportUserName(param1:int, param2:String) : void
      {
         _callForHelpManager.reportedUserId = param1;
         _callForHelpManager.reportedUserName = param2;
         _callForHelpManager.reportedRoomId = -1;
         UnknownVarFromHabboHelp_TopicsFlowHelpController_1.openReportingUserName();
      }
      
      public function reportUserFromIM(param1:int) : void
      {
         if(_callForHelpManager != null)
         {
            _callForHelpManager.reportedUserId = param1;
            UnknownVarFromHabboHelp_TopicsFlowHelpController_1.openReportingIMSelection();
         }
      }
      
      public function reportRoom(param1:int, param2:String, param3:String) : void
      {
         if(_callForHelpManager != null)
         {
            _callForHelpManager.reportedRoomId = param1;
            _callForHelpManager.reportedRoomName = param2;
            _callForHelpManager.reportedUserId = -1;
            _callForHelpManager.reportedUserName = "";
            UnknownVarFromHabboHelp_TopicsFlowHelpController_1.openReportingContentReasonCategory(4);
         }
      }
      
      public function reportThread(param1:int, param2:int) : void
      {
         if(_callForHelpManager != null)
         {
            _callForHelpManager.reportedGroupId = param1;
            _callForHelpManager.reportedThreadId = param2;
            UnknownVarFromHabboHelp_TopicsFlowHelpController_1.openReportingContentReasonCategory(7);
         }
      }
      
      public function reportSelfie(param1:String, param2:String, param3:int, param4:int, param5:int) : Boolean
      {
         if(_callForHelpManager != null)
         {
            if(param2.length < getInteger("help.cfh.length.minimum",15))
            {
               windowManager.alert("${generic.alert.title}","${help.cfh.error.msgtooshort}",0,null);
               return false;
            }
            _callForHelpManager.reportSelfie(param1,param2,param3,param4,param5);
            return true;
         }
         return false;
      }
      
      public function reportPhoto(param1:String, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         if(_callForHelpManager != null)
         {
            if(param2 == 0)
            {
               windowManager.alert("${generic.alert.title}","${help.cfh.error.notopic}",0,null);
               return false;
            }
            _callForHelpManager.reportPhoto(param1,param2,param3,param4,param5);
            return true;
         }
         return false;
      }
      
      public function reportMessage(param1:int, param2:int, param3:int) : void
      {
         if(_callForHelpManager != null)
         {
            _callForHelpManager.reportedGroupId = param1;
            _callForHelpManager.reportedThreadId = param2;
            _callForHelpManager.reportedMessageId = param3;
            UnknownVarFromHabboHelp_TopicsFlowHelpController_1.openReportingContentReasonCategory(8);
         }
      }
      
      public function startNameChange() : void
      {
         if(UnknownVarFromHabboHelp_NameChangeController_1 != null)
         {
            UnknownVarFromHabboHelp_NameChangeController_1.showView();
         }
      }
      
      public function startEmergencyRequest() : void
      {
         if(_callForHelpManager != null)
         {
            _callForHelpManager.openEmergencyHelpRequest();
         }
      }
      
      public function showWelcomeScreen(param1:String, param2:String, param3:int, param4:String = null) : void
      {
         if(UnknownVarFromHabboHelp_WelcomeScreenController_1 == null || UnknownVarFromHabboHelp_WelcomeScreenController_1.disposed)
         {
            UnknownVarFromHabboHelp_WelcomeScreenController_1 = new WelcomeScreenController(this);
         }
         UnknownVarFromHabboHelp_WelcomeScreenController_1.showWelcomeScreen(param1,param2,param3,param4);
      }
      
      public function showHabboWay() : void
      {
         if(!UnknownVarFromHabboHelp_HabboWayController_1)
         {
            UnknownVarFromHabboHelp_HabboWayController_1 = new HabboWayController(this);
         }
         UnknownVarFromHabboHelp_HabboWayController_1.showHabboWay();
      }
      
      public function closeHabboWay() : void
      {
         if(UnknownVarFromHabboHelp_HabboWayController_1 != null)
         {
            UnknownVarFromHabboHelp_HabboWayController_1.closeWindow();
         }
      }
      
      public function showSafetyBooklet() : void
      {
         if(!UnknownVarFromHabboHelp_SafetyBookletController_1)
         {
            UnknownVarFromHabboHelp_SafetyBookletController_1 = new SafetyBookletController(this);
         }
         UnknownVarFromHabboHelp_SafetyBookletController_1.openSafetyBooklet();
      }
      
      public function closeSafetyBooklet() : void
      {
         if(UnknownVarFromHabboHelp_SafetyBookletController_1 != null)
         {
            UnknownVarFromHabboHelp_SafetyBookletController_1.closeWindow();
         }
      }
      
      public function showHabboWayQuiz() : void
      {
         if(UnknownVarFromHabboHelp_HabboWayQuizController_1 == null || UnknownVarFromHabboHelp_HabboWayQuizController_1.disposed)
         {
            UnknownVarFromHabboHelp_HabboWayQuizController_1 = new HabboWayQuizController(this);
         }
         UnknownVarFromHabboHelp_HabboWayQuizController_1.showHabboWayQuiz();
      }
      
      public function showSafetyQuiz() : void
      {
         if(UnknownVarFromHabboHelp_HabboWayQuizController_1 == null || UnknownVarFromHabboHelp_HabboWayQuizController_1.disposed)
         {
            UnknownVarFromHabboHelp_HabboWayQuizController_1 = new HabboWayQuizController(this);
         }
         UnknownVarFromHabboHelp_HabboWayQuizController_1.showSafetyQuiz();
      }
      
      public function showTourPopup() : void
      {
         _guideHelpManager.openTourPopup();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },true,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         },{
            "type":"HTE_GROUP_ROOM_INFO_CLICK",
            "callback":onHabboToolbarEvent
         },{
            "type":"HTE_RESIZED",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },true),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         },false),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         },false),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new MyCfhReportStatusMessageEvent(onMyCfhReportStatusMessageEvent));
         addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
         addMessageEvent(new MySanctionStatusMessageEvent(onMySanctionStatusMessageEvent));
         addMessageEvent(new CallForHelpDisabledNotifyMessageEvent(onCallForHelpDisabledNotify));
         addMessageEvent(new CfhTopicsInitMessageEvent(onCfhTopics));
         addMessageEvent(new CallForHelpPendingCallsDeletedMessageEvent(onPendingCallsForHelpDeleted));
         addMessageEvent(new Game2StageStartingMessageEvent(onGameStageStarting));
         addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         addMessageEvent(new GuideReportingStatusMessageEvent(onGuideReportingStatus));
         addMessageEvent(new UsersMessageEvent(onUsers));
         addMessageEvent(new GetGuestRoomResultEvent(onGuestRoomResult));
         addMessageEvent(new CallForHelpPendingCallsMessageEvent(onPendingCallsForHelp));
         UnknownVarFromHabboHelp_ChatEventHandler_1 = new ChatEventHandler(this);
         _guideHelpManager = new GuideHelpManager(this);
         _callForHelpManager = new CallForHelpManager(this);
         UnknownVarFromHabboHelp_NameChangeController_1 = new NameChangeController(this);
         UnknownVarFromHabboHelp_InstantMessageEventHandler_1 = new InstantMessageEventHandler(this);
         UnknownVarFromHabboHelp_TopicsFlowHelpController_1 = new TopicsFlowHelpController(this);
         _sanctionInfo = new SanctionInfo(this);
         _reportStatus = new MyReportStatus(this);
         context.addLinkEventTracker(this);
         if(getBoolean("show.sanction.info.on.login") && Math.random() < 0.2)
         {
            requestSanctionInfo(true);
         }
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(UnknownVarFromHabboHelp_SafetyBookletController_1 != null)
         {
            UnknownVarFromHabboHelp_SafetyBookletController_1.dispose();
            UnknownVarFromHabboHelp_SafetyBookletController_1 = null;
         }
         if(UnknownVarFromHabboHelp_HabboWayController_1 != null)
         {
            UnknownVarFromHabboHelp_HabboWayController_1.dispose();
            UnknownVarFromHabboHelp_HabboWayController_1 = null;
         }
         if(UnknownVarFromHabboHelp_WelcomeScreenController_1 != null)
         {
            UnknownVarFromHabboHelp_WelcomeScreenController_1.dispose();
            UnknownVarFromHabboHelp_WelcomeScreenController_1 = null;
         }
         if(UnknownVarFromHabboHelp_NameChangeController_1 != null)
         {
            UnknownVarFromHabboHelp_NameChangeController_1.dispose();
            UnknownVarFromHabboHelp_NameChangeController_1 = null;
         }
         if(_guideHelpManager)
         {
            _guideHelpManager.dispose();
            _guideHelpManager = null;
         }
         if(_callForHelpManager)
         {
            _callForHelpManager.dispose();
            _callForHelpManager = null;
         }
         if(UnknownVarFromHabboHelp_HabboWayQuizController_1)
         {
            UnknownVarFromHabboHelp_HabboWayQuizController_1.dispose();
            UnknownVarFromHabboHelp_HabboWayQuizController_1 = null;
         }
         if(UnknownVarFromHabboHelp_TopicsFlowHelpController_1)
         {
            UnknownVarFromHabboHelp_TopicsFlowHelpController_1.dispose();
            UnknownVarFromHabboHelp_TopicsFlowHelpController_1 = null;
         }
         if(_sanctionInfo)
         {
            _sanctionInfo.dispose();
            _sanctionInfo = null;
         }
         super.dispose();
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : IWindowModel
      {
         var _loc5_:ISoundAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:IWindowModel = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      public function getModalXmlWindow(param1:String) : IModalDialog
      {
         var _loc4_:ISoundAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IModalDialog = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1 + "_xml");
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildModalDialogFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc4_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc3_;
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function setReportMessage(param1:IMessageComposer) : void
      {
         _reportMessage = param1;
      }
      
      public function sendMessage(param1:IMessageComposer) : void
      {
         if(_communicationManager != null && param1 != null)
         {
            _communicationManager.connection.send(param1);
         }
      }
      
      public function get ownUserName() : String
      {
         return UnknownVarFromHabboHelp_NameChangeController_1.ownUserName;
      }
      
      public function get ownUserId() : int
      {
         return UnknownVarFromHabboHelp_NameChangeController_1.ownUserId;
      }
      
      public function get outsideRoom() : Boolean
      {
         return _outsideRoom;
      }
      
      public function set outsideRoom(param1:Boolean) : void
      {
         _outsideRoom = param1;
      }
      
      public function queryForPendingCallsForHelp(param1:int) : void
      {
         UnknownVarFromHabboHelp_Int_1 = param1;
         sendMessage(new GetPendingCallsForHelpMessageComposer());
      }
      
      public function queryForGuideReportingStatus(param1:int) : void
      {
         UnknownVarFromHabboHelp_Int_2 = param1;
         sendMessage(new GuideAdvertisementReadMessageComposer());
         sendMessage(new GetGuideReportingStatusMessageComposer());
      }
      
      private function onPendingCallsForHelp(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc2_:CallForHelpPendingCallsMessageParser = CallForHelpPendingCallsMessageEvent(param1).getParser();
         if(_loc2_.callCount == 0 || UnknownVarFromHabboHelp_Int_1 == 9 && _loc2_.callCount < 3)
         {
            proceedWithReporting();
         }
         else
         {
            _loc4_ = "";
            _loc3_ = 0;
            while(_loc3_ < _loc2_.callArray.length && _loc3_ < 10)
            {
               _loc4_ += _loc2_.callArray[_loc3_].message;
               if(_loc3_ < _loc2_.callArray.length - 1 && _loc3_ < 9)
               {
                  _loc4_ += "\n";
               }
               _loc3_++;
            }
            _callForHelpManager.showPendingRequest(_loc4_);
         }
      }
      
      private function onPendingCallsForHelpDeleted(param1:IMessageEvent) : void
      {
         UnknownVarFromHabboHelp_TopicsFlowHelpController_1.submitCallForHelp(false);
      }
      
      private function onGuideReportingStatus(param1:GuideReportingStatusMessageEvent) : void
      {
         var _loc2_:GuideReportingStatusMessageParser = param1.getParser();
         switch(_loc2_.statusCode)
         {
            case 0:
               toggleNewHelpWindow();
               break;
            case 1:
               _guideHelpManager.showPendingTicket(_loc2_.pendingTicket);
               break;
            default:
               _guideHelpManager.showFeedback(_loc2_.localizationCode);
         }
      }
      
      private function proceedWithReporting() : void
      {
         switch(UnknownVarFromHabboHelp_Int_1 - 1)
         {
            case 0:
            case 2:
            case 3:
            case 6:
            case 7:
               _callForHelpManager.showEmergencyHelpRequest(UnknownVarFromHabboHelp_Int_1);
               break;
            case 1:
               _guideHelpManager.openReportWindow();
               break;
            case 8:
               if(_reportMessage != null)
               {
                  sendMessage(_reportMessage);
                  _reportMessage = null;
                  break;
               }
         }
         UnknownVarFromHabboHelp_Int_1 = 0;
      }
      
      private function onCallForHelpDisabledNotify(param1:CallForHelpDisabledNotifyMessageEvent) : void
      {
         _windowManager.simpleAlert("${help.emergency.global_mute.caption}","${help.emergency.global_mute.subtitle}","${help.emergency.global_mute.message}","${help.emergency.global_mute.link}",param1.getParser().infoUrl);
      }
      
      public function get friendList() : IHabboFriendList
      {
         return _friendList;
      }
      
      public function ignoreAndUnfriendReportedUser() : void
      {
         var _loc1_:RemoveFriendMessageComposer = null;
         if(_callForHelpManager.reportedUserId > 0)
         {
            sendMessage(new IgnoreUserMessageComposer(_callForHelpManager.reportedUserId));
            if(_friendList.getFriend(_callForHelpManager.reportedUserId) != null)
            {
               _loc1_ = new RemoveFriendMessageComposer();
               _loc1_.addRemovedFriend(_callForHelpManager.reportedUserId);
               sendMessage(_loc1_);
            }
         }
      }
      
      private function onUsers(param1:IMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:UserMessageData = null;
         var _loc2_:UsersMessageParser = UsersMessageEvent(param1).getParser();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.getUserCount())
         {
            _loc4_ = _loc2_.getUser(_loc3_);
            if(_loc4_.webID != ownUserId && _loc4_.userType == 1)
            {
               _userRegistry.registerUser(_loc4_.webID,_loc4_.name,_loc4_.figure);
            }
            _loc3_++;
         }
      }
      
      private function onGameStageStarting(param1:Game2StageStartingMessageEvent) : void
      {
         var _loc6_:HumanGameObjectData = null;
         var _loc2_:Game2StageStartingMessageParser = param1.getParser();
         var _loc5_:Array = _loc2_.gameObjects.gameObjects;
         var _loc4_:int = _userRegistry.roomId;
         var _loc3_:String = _userRegistry.roomName;
         _userRegistry.registerRoom(-1,"SnowStorm");
         for each(var _loc7_ in _loc5_)
         {
            _loc6_ = _loc7_ as HumanGameObjectData;
            if(_loc6_ != null && _loc6_.userId != ownUserId)
            {
               _userRegistry.registerUser(_loc6_.userId,_loc6_.name,_loc6_.figure);
            }
         }
         _userRegistry.registerRoom(_loc4_,_loc3_);
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         var _loc2_:RoomReadyMessageParser = RoomReadyMessageEvent(param1).getParser();
         _userRegistry.registerRoom(_loc2_.roomId,"");
      }
      
      private function onGuestRoomResult(param1:IMessageEvent) : void
      {
         var _loc2_:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(param1).getParser();
         _userRegistry.registerRoom(_loc2_.data.flatId,_loc2_.data.roomName);
      }
      
      public function get userRegistry() : UserRegistry
      {
         return _userRegistry;
      }
      
      public function get chatRegistry() : ChatRegistry
      {
         return _chatRegistry;
      }
      
      public function get instantMessageRegistry() : InstantMessageRegistry
      {
         return _instantMessageRegistry;
      }
      
      private function onRoomEnter(param1:RoomEntryInfoMessageEvent) : void
      {
         _windowManager.LilithCustomsInstance.OnRoomEnter(param1);
         var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
         UnknownVarFromHabboHelp_Int_3 = _loc2_.guestRoomId;
      }
      
      private function onCfhTopics(param1:CfhTopicsInitMessageEvent) : void
      {
         var _loc2_:CfhTopicsInitMessageParser = param1.getParser();
         _callForHelpCategories = _loc2_.callForHelpCategories;
      }
      
      public function get callForHelpCategories() : Vector.<CallForHelpCategoryData>
      {
         return _callForHelpCategories;
      }
      
      public function get guardiansEnabled() : Boolean
      {
         return getBoolean("guardians.enabled");
      }
      
      public function get linkPattern() : String
      {
         return "help/";
      }
      
      public function get reportedUserId() : int
      {
         return _callForHelpManager.reportedUserId;
      }
      
      public function get reportedUserName() : String
      {
         return _callForHelpManager.reportedUserName;
      }
      
      public function get reportedRoomId() : int
      {
         return _callForHelpManager.reportedRoomId;
      }
      
      public function get reportedExtraDataId() : String
      {
         return _callForHelpManager.reportedExtraDataId;
      }
      
      public function get reportedRoomObjectId() : int
      {
         return _callForHelpManager.reportedRoomObjectId;
      }
      
      public function set reportedUserId(param1:int) : void
      {
         _callForHelpManager.reportedUserId = param1;
      }
      
      public function set reportedRoomId(param1:int) : void
      {
         _callForHelpManager.reportedRoomId = param1;
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(param1 == "help/tour")
         {
            requestGuide();
         }
         if(param1.indexOf("help/report/room/") == 0)
         {
            _loc2_ = param1.split("/");
            if(_loc2_.length >= 5)
            {
               _loc3_ = parseInt(_loc2_[3]);
               _loc4_ = unescape(_loc2_.splice(4).join("/"));
               reportRoom(_loc3_,_loc4_,"");
            }
         }
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(UnknownVarFromHabboHelp_WelcomeScreenController_1 != null)
         {
            UnknownVarFromHabboHelp_WelcomeScreenController_1.onHabboToolbarEvent(param1);
         }
         if(_guideHelpManager != null)
         {
            _guideHelpManager.onHabboToolbarEvent(param1);
         }
      }
      
      public function get callForHelpManager() : CallForHelpManager
      {
         return _callForHelpManager;
      }
      
      public function toggleNewHelpWindow() : void
      {
         UnknownVarFromHabboHelp_TopicsFlowHelpController_1.toggleWindow();
      }
      
      public function requestSanctionInfo(param1:Boolean) : void
      {
         sendMessage(new GetMySanctionStatusMessageComposer());
      }
      
      public function requestReportsStatus() : void
      {
         sendMessage(new GetCfhMyReportStatus());
      }
      
      private function onMySanctionStatusMessageEvent(param1:MySanctionStatusMessageEvent) : void
      {
         _sanctionInfo.openWindow(param1);
      }
      
      private function onMyCfhReportStatusMessageEvent(param1:MyCfhReportStatusMessageEvent) : void
      {
         _reportStatus.openWindow(param1);
      }
      
      public function openCfhFaq() : void
      {
         var _loc1_:String = context.configuration.getProperty("cfh.faq.url");
         if(!StringUtil.isEmpty(_loc1_))
         {
            navigateToURL(new URLRequest(_loc1_));
         }
      }
      
      public function get guideHelpManager() : GuideHelpManager
      {
         return _guideHelpManager;
      }
   }
}

