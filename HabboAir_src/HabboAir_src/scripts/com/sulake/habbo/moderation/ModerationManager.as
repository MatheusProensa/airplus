package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.friendbar.IHabboFriendBar;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendBar;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDNewModerationTool;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class ModerationManager extends Component implements IHabboModeration
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _tracking:IHabboTracking;
      
      private var _friendBar:IHabboFriendBar;
      
      private var _messageHandler:ModerationMessageHandler;
      
      private var _issueManager:IssueManager;
      
      private var _startPanel:StartPanelCtrl;
      
      private var _windowTracker:WindowTracker;
      
      private var _initMsg:ModeratorInitData;
      
      private var _currentFlatId:int;
      
      public function ModerationManager(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _startPanel = new StartPanelCtrl(this);
         _windowTracker = new WindowTracker();
         param1.attachComponent(new NewModerationTool(param1,param2,param3),[new IIDNewModerationTool()]);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            IssueCategoryNames.setLocalizationManager(param1);
         }),new ComponentDependency(new IIDHabboFriendBar(),function(param1:IHabboFriendBar):void
         {
            _friendBar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(HabboComponentFlags.isRoomViewerMode(flags))
         {
            return;
         }
         _messageHandler = new ModerationMessageHandler(this);
         _issueManager = new IssueManager(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_startPanel != null)
         {
            _startPanel.dispose();
            _startPanel = null;
         }
         super.dispose();
      }
      
      public function userSelected(param1:int, param2:String) : void
      {
         Logger.log("USER SELECTED: " + param1 + ", " + param2);
         this._startPanel.userSelected(param1,param2);
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get issueManager() : IssueManager
      {
         return _issueManager;
      }
      
      public function get connection() : IConnection
      {
         return _communication.connection;
      }
      
      public function get startPanel() : StartPanelCtrl
      {
         return _startPanel;
      }
      
      public function get initMsg() : ModeratorInitData
      {
         return _initMsg;
      }
      
      public function get messageHandler() : ModerationMessageHandler
      {
         return _messageHandler;
      }
      
      public function get windowTracker() : WindowTracker
      {
         return _windowTracker;
      }
      
      public function get currentFlatId() : int
      {
         return _currentFlatId;
      }
      
      public function get soundManager() : IHabboSoundManagerFlash10
      {
         return _soundManager;
      }
      
      public function set initMsg(param1:ModeratorInitData) : void
      {
         _initMsg = param1;
      }
      
      public function set currentFlatId(param1:int) : void
      {
         _currentFlatId = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return _sessionDataManager.hasSecurity(5);
      }
      
      public function getXmlWindow(param1:String, param2:String = "_xml", param3:int = 1) : IWindowModel
      {
         var _loc6_:ISoundAsset = null;
         var _loc4_:XmlAsset = null;
         var _loc5_:IWindowModel = null;
         try
         {
            _loc6_ = assets.getAssetByName(param1 + param2);
            _loc4_ = XmlAsset(_loc6_);
            _loc5_ = _windowManager.buildFromXML(XML(_loc4_.content),param3);
         }
         catch(e:Error)
         {
         }
         return _loc5_;
      }
      
      public function openHkPage(param1:String, param2:String) : void
      {
         var _loc4_:String = getProperty(param1);
         var _loc5_:String = _loc4_ + param2;
         var _loc3_:String = "housekeeping";
         HabboWebTools.navigateToURL(_loc5_,_loc3_);
      }
      
      public function goToRoom(param1:int) : void
      {
         _navigator.goToPrivateRoom(param1);
      }
      
      public function openThread(param1:int, param2:int) : void
      {
         context.createLinkEvent("groupforum/" + param1 + "/" + param2);
      }
      
      public function openThreadMessage(param1:int, param2:int, param3:int) : void
      {
         context.createLinkEvent("groupforum/" + param1 + "/" + param2 + "/" + param3);
      }
      
      internal function logEvent(param1:String, param2:String) : void
      {
         if(_tracking != null)
         {
            _tracking.trackEventLog("Moderation",param2,param1);
         }
      }
      
      internal function trackGoogle(param1:String, param2:int = -1) : void
      {
         if(_tracking != null)
         {
            _tracking.trackGoogle("moderationManager",param1,param2);
         }
      }
      
      public function set cfhTopics(param1:Vector.<CallForHelpCategoryData>) : void
      {
         _issueManager.setCfhTopics(param1);
      }
   }
}

