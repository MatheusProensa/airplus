package com.sulake.habbo.quest
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetSeasonalQuestsOnlyMessageComposer;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.quest.dailytasks.DailyTasksController;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDDailyTasks;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRewardTrackController;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class HabboQuestEngine extends Component implements IHabboQuestEngine, IProfiler_1, ILinkEventTracker
   {
      private static const UnknownConstFromHabboQuestEngine_Int_1:int = 5;
      
      private static const TWINKLE_ANIMATION_START_TIME:int = 800;
      
      private static const TWINKLE_ANIMATION_OBJECT_COUNT:int = 15;
      
      private static const DELAY_BETWEEN_TWINKLE_STARTS:int = 300;
      
      private static const UnknownConstFromHabboQuestEngine_Array_1:Array = ["MOVEITEM","ENTEROTHERSROOM","CHANGEFIGURE","FINDLIFEGUARDTOWER","SCRATCHAPET"];
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _configuration:IComponent_1;
      
      private var _incomingMessages:IncomingMessages;
      
      private var _questController:QuestController;
      
      private var _achievementController:AchievementController;
      
      private var _roomCompetitionController:RoomCompetitionController;
      
      private var _toolbar:IHabboToolbar;
      
      private var _catalog:IHabboCatalog;
      
      private var _navigator:IHabboNewNavigator;
      
      private var _notifications:IHabboNotifications;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _tracking:IHabboTracking;
      
      private var _twinkleImages:TwinkleImages;
      
      private var _currentlyInRoom:Boolean = false;
      
      private var _roomEngine:IRoomEngine;
      
      private var UnknownVarFromHabboQuestEngine_Boolean_1:Boolean = false;
      
      private var _wired:IHabboUserDefinedRoomEvents;
      
      private var UnknownVarFromHabboQuestEngine_DailyTasksController_1:DailyTasksController;
      
      private var _rewardTrack:RewardTrackController;
      
      private var _achievementsResolutionController:AchievementsResolutionController;
      
      public function HabboQuestEngine(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _questController = new QuestController(this);
         _achievementController = new AchievementController(this);
         _achievementsResolutionController = new AchievementsResolutionController(this);
         _roomCompetitionController = new RoomCompetitionController(this);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationComponentInit);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboNotifications(),onNotificationsReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboNewNavigator(),onHabboNavigatorReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboTracking(),onTrackingReady);
         queueInterface(new IIDHabboUserDefinedRoomEvents(),onWiredReady);
         param1.addLinkEventTracker(this);
         UnknownVarFromHabboQuestEngine_DailyTasksController_1 = new DailyTasksController(this,param1,0,param3);
         param1.attachComponent(UnknownVarFromHabboQuestEngine_DailyTasksController_1,[new IIDDailyTasks()]);
         _rewardTrack = new RewardTrackController(this,param1,0,param3);
         param1.attachComponent(_rewardTrack,[new IIDRewardTrackController()]);
         registerUpdateReceiver(this,5);
      }
      
      public static function moveChildrenToRow(param1:IWindowController_1, param2:Array, param3:int, param4:int) : void
      {
         var _loc6_:IWindowModel = null;
         for each(var _loc5_ in param2)
         {
            _loc6_ = param1.getChildByName(_loc5_);
            if(_loc6_ != null && _loc6_.visible)
            {
               _loc6_.x = param3;
               param3 += _loc6_.width + param4;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeUpdateReceiver(this);
         context.removeLinkEventTracker(this);
         if(_toolbar)
         {
            _toolbar.release(new IIDHabboToolbar());
            _toolbar = null;
         }
         if(_catalog != null)
         {
            _catalog.release(new IIDHabboCatalog());
            _catalog = null;
         }
         if(_notifications != null)
         {
            _notifications.release(new IIDHabboNotifications());
            _notifications = null;
         }
         if(_wired != null)
         {
            _wired.release(new IIDHabboUserDefinedRoomEvents());
            _wired = null;
         }
         if(_windowManager != null)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         if(_localization != null)
         {
            _localization.release(new IIDHabboLocalizationManager());
            _localization = null;
         }
         if(_configuration != null)
         {
            _configuration.release(new IIDHabboConfigurationManager());
            _configuration = null;
         }
         if(_communication != null)
         {
            _communication.release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         if(_sessionDataManager != null)
         {
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",_achievementController.onBadgeImageReady);
            _sessionDataManager.release(new IIDSessionDataManager());
            _sessionDataManager = null;
         }
         if(_incomingMessages)
         {
            _incomingMessages.dispose();
         }
         if(_habboHelp != null)
         {
            _habboHelp.release(new IIDHabboHelp());
            _habboHelp = null;
         }
         if(_navigator != null)
         {
            _navigator.release(new IIDHabboNewNavigator());
            _navigator = null;
         }
         if(_tracking != null)
         {
            _tracking.release(new IIDHabboTracking());
            _tracking = null;
         }
         if(_twinkleImages)
         {
            _twinkleImages.dispose();
            _twinkleImages = null;
         }
         if(_roomEngine)
         {
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(_achievementsResolutionController)
         {
            _achievementsResolutionController.dispose();
            _achievementsResolutionController = null;
         }
         if(_rewardTrack)
         {
            _rewardTrack.dispose();
            _rewardTrack = null;
         }
         super.dispose();
      }
      
      public function getXmlWindow(param1:String, param2:int = 1) : IWindowModel
      {
         var _loc5_:ISoundAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:IWindowModel = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1);
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
         }
         return _loc4_;
      }
      
      private function onCommunicationComponentInit(param1:IID = null, param2:IUnknown = null) : void
      {
         _communication = IHabboCommunicationManager(param2);
         _incomingMessages = new IncomingMessages(this);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _windowManager = IHabboWindowManagerComponent(param2);
      }
      
      private function onLocalizationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _localization = IHabboLocalizationManager(param2);
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         if(param2 == null)
         {
            return;
         }
         _configuration = param2 as IComponent_1;
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _catalog = param2 as IHabboCatalog;
      }
      
      private function onNotificationsReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _notifications = param2 as IHabboNotifications;
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _sessionDataManager = param2 as ISessionDataManager;
         _sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",_achievementController.onBadgeImageReady);
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _habboHelp = param2 as IHabboHelp;
      }
      
      private function onHabboNavigatorReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _navigator = param2 as IHabboNewNavigator;
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _roomEngine = param2 as IRoomEngine;
      }
      
      private function onTrackingReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _tracking = param2 as IHabboTracking;
      }
      
      private function onWiredReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _wired = param2 as IHabboUserDefinedRoomEvents;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get questController() : QuestController
      {
         return _questController;
      }
      
      public function get roomCompetitionController() : RoomCompetitionController
      {
         return _roomCompetitionController;
      }
      
      public function get achievementController() : AchievementController
      {
         return _achievementController;
      }
      
      public function get achievementsResolutionController() : AchievementsResolutionController
      {
         return _achievementsResolutionController;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get tracking() : IHabboTracking
      {
         return _tracking;
      }
      
      public function get wired() : IHabboUserDefinedRoomEvents
      {
         return _wired;
      }
      
      public function openCatalog(param1:QuestMessageData) : void
      {
         var _loc2_:String = param1.catalogPageName;
         if(_loc2_ != "")
         {
            Logger.log("Questing->Open Catalog: " + _loc2_);
            _catalog.openCatalogPage(_loc2_);
         }
         else
         {
            Logger.log("Questing->Open Catalog: Quest Catalog page name not defined");
            _catalog.openCatalog();
         }
      }
      
      public function openNavigator(param1:QuestMessageData) : void
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = hasLocalizedValue(param1.getQuestLocalizationKey() + ".searchtag");
         if(_loc2_)
         {
            _loc3_ = param1.getQuestLocalizationKey() + ".searchtag";
         }
         else
         {
            _loc3_ = param1.getCampaignLocalizationKey() + ".searchtag";
         }
         var _loc4_:String = _localization.getLocalization(_loc3_);
         Logger.log("Questing->Open Navigator: " + _loc4_);
         _navigator.performTagSearch(_loc4_);
      }
      
      public function hasQuestRoomsIds() : Boolean
      {
         var _loc1_:String = getQuestRoomIds();
         return _loc1_ != null && _loc1_ != "";
      }
      
      private function getQuestRoomIds() : String
      {
         return _localization.getLocalization("quests." + getSeasonalCampaignCodePrefix() + ".roomids");
      }
      
      public function goToQuestRooms() : void
      {
         if(!hasQuestRoomsIds())
         {
            return;
         }
         var _loc4_:String = getQuestRoomIds();
         var _loc2_:Array = _loc4_.split(",");
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc3_:int = Math.max(0,Math.min(_loc2_.length - 1,Math.floor(Math.random() * _loc2_.length)));
         var _loc1_:String = _loc2_[_loc3_];
         var _loc5_:int = int(_loc1_);
         Logger.log("Forwarding to a guest room: " + _loc5_);
         _navigator.goToRoom(_loc5_);
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _toolbar = IHabboToolbar(param2) as IHabboToolbar;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            if(param1.iconId == "HTIE_ICON_ACHIEVEMENTS")
            {
               _achievementController.onToolbarClick();
            }
         }
      }
      
      public function ensureAchievementsInitialized() : void
      {
         if(_achievementController != null)
         {
            _achievementController.ensureAchievementsInitialized();
         }
      }
      
      public function showAchievements() : void
      {
         if(_achievementController != null)
         {
            _achievementController.show();
         }
      }
      
      public function showQuests() : void
      {
         if(_questController != null && !_questController.questsList.isVisible())
         {
            _questController.onToolbarClick();
         }
      }
      
      public function getAchievementLevel(param1:String, param2:String) : int
      {
         if(_achievementController != null)
         {
            return _achievementController.getAchievementLevel(param1,param2);
         }
         return 0;
      }
      
      public function reenableRoomCompetitionWindow() : void
      {
         _roomCompetitionController.dontShowAgain = false;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get rewardTrack() : RewardTrackController
      {
         return _rewardTrack;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         communication.connection.send(param1);
      }
      
      public function getQuestRowTitle(param1:QuestMessageData) : String
      {
         var _loc2_:String = param1.waitPeriodSeconds < 1 ? param1.getQuestLocalizationKey() + ".name" : "quests.list.questdelayed";
         _loc2_ = this._localization.getLocalization(_loc2_,_loc2_);
         if(this._windowManager.LilithCustomsInstance.ShowQuestsIds)
         {
            _loc2_ = "(" + param1.id + ") " + _loc2_;
         }
         return _loc2_;
      }
      
      public function getQuestName(param1:QuestMessageData) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestDesc(param1:QuestMessageData) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".desc";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestHint(param1:QuestMessageData) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".hint";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getCampaignNameByCode(param1:String) : String
      {
         var _loc2_:String = param1 + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getCampaignName(param1:QuestMessageData) : String
      {
         return getCampaignNameByCode(param1.getCampaignLocalizationKey());
      }
      
      public function getAchievementCategoryName(param1:String) : String
      {
         var _loc2_:String = "quests." + param1 + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function setupQuestImage(param1:IWindowController_1, param2:QuestMessageData) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = param1.findChildByName("quest_pic_bitmap") as IStaticBitmapWrapperWindow;
         var _loc4_:String = param2.waitPeriodSeconds > 0 ? "quest_timer_questionmark" : (param2.campaignCode + "_" + param2.localizationCode + param2.imageVersion + (isQuestWithPrompts(param2) ? "_a" : "")).toLowerCase();
         _loc3_.assetUri = "${image.library.questing.url}" + _loc4_ + ".png";
      }
      
      public function setupPromptFrameImage(param1:IWindowController_1, param2:QuestMessageData, param3:String) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = param1.findChildByName("prompt_pic_" + param3) as IStaticBitmapWrapperWindow;
         _loc4_.assetUri = "${image.library.questing.url}" + (param2.campaignCode + "_" + param2.localizationCode + param2.imageVersion + "_" + param3).toLowerCase() + ".png";
      }
      
      public function setupRewardImage(param1:IWindowController_1, param2:int) : void
      {
         var _loc3_:IWindowModel = param1.findChildByName("currency_icon");
         _loc3_.style = ActivityPointTypeEnum.getIconStyleFor(param2,this,true);
      }
      
      public function setupCampaignImage(param1:IWindowController_1, param2:QuestMessageData, param3:Boolean) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = param1.findChildByName("campaign_pic_bitmap") as IStaticBitmapWrapperWindow;
         if(!param3)
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         var _loc5_:String = param2.campaignCode;
         if(isSeasonalQuest(param2))
         {
            _loc5_ = getSeasonalCampaignCodePrefix() + "_campaign_icon";
         }
         _loc4_.assetUri = "${image.library.questing.url}" + _loc5_ + ".png";
      }
      
      public function setupAchievementCategoryImage(param1:IWindowController_1, param2:AchievementCategory, param3:Boolean) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = param1.findChildByName("category_pic_bitmap") as IStaticBitmapWrapperWindow;
         _loc4_.assetUri = "";
         _loc4_.assetUri = "${image.library.questing.url}" + (param3 ? "ach_category_" + param2.code : "achicon_" + param2.code) + ".png";
      }
      
      public function isQuestWithPrompts(param1:QuestMessageData) : Boolean
      {
         return UnknownConstFromHabboQuestEngine_Array_1.indexOf(param1.localizationCode) > -1;
      }
      
      public function refreshReward(param1:Boolean, param2:IWindowController_1, param3:int, param4:int) : void
      {
         param1 = param3 < 0 || param4 < 1 ? false : param1;
         var _loc5_:IWindowModel = param2.findChildByName("reward_caption_txt");
         var _loc6_:IWindowModel = param2.findChildByName("reward_amount_txt");
         var _loc7_:IWindowModel = param2.findChildByName("currency_icon");
         _loc6_.visible = param1;
         _loc5_.visible = param1;
         _loc7_.visible = param1;
         if(!param1)
         {
            return;
         }
         _loc6_.caption = "" + param4;
         moveChildrenToRow(param2,["reward_caption_txt","reward_amount_txt","currency_icon"],_loc5_.x,3);
         this.setupRewardImage(param2,param3);
      }
      
      public function update(param1:uint) : void
      {
         _questController.update(param1);
         _achievementController.update(param1);
         UnknownVarFromHabboQuestEngine_DailyTasksController_1.update(param1);
         _rewardTrack.update(param1);
      }
      
      public function getTwinkleAnimation(param1:IWindowController_1) : Animation
      {
         var _loc3_:int = 0;
         if(_twinkleImages == null)
         {
            _twinkleImages = new TwinkleImages(this);
         }
         var _loc4_:int = 800;
         var _loc2_:Animation = new Animation(IBitmapWrapperController(param1.findChildByName("twinkle_bitmap")));
         _loc3_ = 0;
         while(_loc3_ < 15)
         {
            _loc2_.addObject(new Twinkle(_twinkleImages,_loc4_));
            _loc4_ += 300;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get currentlyInRoom() : Boolean
      {
         return _currentlyInRoom;
      }
      
      public function set currentlyInRoom(param1:Boolean) : void
      {
         _currentlyInRoom = param1;
      }
      
      public function isSeasonalCalendarEnabled() : Boolean
      {
         return _configuration.getBoolean("seasonalQuestCalendar.enabled");
      }
      
      public function isSeasonalQuest(param1:QuestMessageData) : Boolean
      {
         var _loc2_:String = getSeasonalCampaignCodePrefix();
         return _loc2_ != "" && param1.campaignCode.indexOf(_loc2_) == 0;
      }
      
      public function getSeasonalCampaignCodePrefix() : String
      {
         return getProperty("seasonalQuestCalendar.campaignPrefix");
      }
      
      public function setIsFirstLoginOfDay(param1:Boolean) : void
      {
         this.UnknownVarFromHabboQuestEngine_Boolean_1 = param1;
      }
      
      public function get isFirstLoginOfDay() : Boolean
      {
         return this.UnknownVarFromHabboQuestEngine_Boolean_1;
      }
      
      public function get configuration() : IComponent_1
      {
         return _configuration;
      }
      
      public function hasLocalizedValue(param1:String) : Boolean
      {
         return _localization.getLocalization(param1,"") != "";
      }
      
      public function get navigator() : IHabboNewNavigator
      {
         return _navigator;
      }
      
      public function requestSeasonalQuests() : void
      {
         send(new GetSeasonalQuestsOnlyMessageComposer());
      }
      
      public function requestQuests() : void
      {
         send(new GetQuestsMessageComposer());
      }
      
      public function activateQuest(param1:int) : void
      {
         send(new ActivateQuestMessageComposer(param1));
      }
      
      public function get linkPattern() : String
      {
         return "questengine/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "gotorooms":
               goToQuestRooms();
               break;
            case "achievements":
               if(_loc2_.length == 3)
               {
                  _achievementController.show();
                  _achievementController.selectCategoryInternalLink(_loc2_[2]);
               }
               else
               {
                  showAchievements();
               }
               break;
            case "calendar":
               _questController.seasonalCalendarWindow.onToolbarClick();
               break;
            case "quests":
               _questController.onToolbarClick();
               break;
            default:
               Logger.log("QuestEngine unknown link-type received: " + _loc2_[1]);
         }
      }
   }
}

