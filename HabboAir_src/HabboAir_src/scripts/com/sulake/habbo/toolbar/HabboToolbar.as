package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.CoreComponentContext;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.campaign.HabboCampaigns;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.friendbar.groupforums.UnseenForumsCountUpdatedEvent;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.inventory.events.HabboUnseenItemsUpdatedEvent;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.messenger.events.MiniMailMessageEvent;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.nux.HabboNuxDialogs;
   import com.sulake.habbo.phonenumber.HabboPhoneNumber;
   import com.sulake.habbo.quest.IHabboQuestEngine;
   import com.sulake.habbo.quest.events.UnseenAchievementsCountUpdateEvent;
   import com.sulake.habbo.quest.events.UnseenDailyTasksCountUpdateEvent;
   import com.sulake.habbo.quest.events.UnseenRewardTrackRewardsCountUpdateEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.extensions.CitizenshipVipDiscountPromoExtension;
   import com.sulake.habbo.toolbar.extensions.CitizenshipVipQuestsPromoExtension;
   import com.sulake.habbo.toolbar.extensions.ClubDiscountPromoExtension;
   import com.sulake.habbo.toolbar.extensions.PurseAreaExtension;
   import com.sulake.habbo.toolbar.extensions.SettingsExtension;
   import com.sulake.habbo.toolbar.extensions.VideoOfferExtension;
   import com.sulake.habbo.toolbar.extensions.purse.indicators.SeasonalCurrencyIndicator;
   import com.sulake.habbo.toolbar.offers.OfferExtension;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDCoreLocalizationManager;
   import com.sulake.iid.IIDHabboCampaigns;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboGroupForumController;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboMessenger;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboNuxDialogs;
   import com.sulake.iid.IIDHabboPhoneNumber;
   import com.sulake.iid.IIDHabboQuestEngine;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class HabboToolbar extends Component implements IHabboToolbar
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var UnknownVarFromHabboToolbar_BottomBarLeft_1:BottomBarLeft;
      
      private var UnknownVarFromHabboToolbar_BottomBackgroundBorder_1:BottomBackgroundBorder;
      
      private var UnknownVarFromHabboToolbar_Boolean_1:Boolean;
      
      private var UnknownVarFromHabboToolbar_PurseAreaExtension_1:PurseAreaExtension;
      
      private var UnknownVarFromHabboToolbar_SettingsExtension_1:SettingsExtension;
      
      private var _connection:IConnection;
      
      private var _catalog:IHabboCatalog;
      
      private var _messenger:IHabboMessenger;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _roomEvents:IHabboUserDefinedRoomEvents;
      
      private var UnknownVarFromHabboToolbar_Vector_1:Vector.<SeasonalCurrencyIndicator>;
      
      private var UnknownVarFromHabboToolbar_ClubDiscountPromoExtension_1:ClubDiscountPromoExtension;
      
      private var UnknownVarFromHabboToolbar_CitizenshipVipQuestsPromoExtension_1:CitizenshipVipQuestsPromoExtension;
      
      private var UnknownVarFromHabboToolbar_CitizenshipVipDiscountPromoExtension_1:CitizenshipVipDiscountPromoExtension;
      
      private var UnknownVarFromHabboToolbar_VideoOfferExtension_1:VideoOfferExtension;
      
      private var _localization:ICoreLocalizationManager;
      
      private var _inventory:IHabboInventory;
      
      private var _extensionView:ExtensionView;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _questEngine:IHabboQuestEngine;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _roomUI:IRoomUI;
      
      private var _offerExtension:OfferExtension;
      
      private var UnknownVarFromHabboToolbar_Timer_1:Timer;
      
      private var UnknownVarFromHabboToolbar_Timer_2:Timer;
      
      private var UnknownVarFromHabboToolbar_Timer_3:Timer;
      
      public function HabboToolbar(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         param1.attachComponent(new HabboPhoneNumber(param1,0,param3),[new IIDHabboPhoneNumber()]);
         param1.attachComponent(new HabboNuxDialogs(param1,0,param3),[new IIDHabboNuxDialogs()]);
         param1.attachComponent(new HabboCampaigns(param1,0,param3),[new IIDHabboCampaigns()]);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         },true),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },true,[{
            "type":"CATALOG_INITIALIZED",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NOT_READY",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NEW_ITEMS_SHOW",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NEW_ITEMS_HIDE",
            "callback":onCatalogEvent
         }]),new ComponentDependency(new IIDCoreLocalizationManager(),function(param1:ICoreLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         },false,[{
            "type":"HUIUE_UNSEEN_ITEMS_CHANGED",
            "callback":onUnseenItemsUpdate
         },{
            "type":"HIHCE_HABBO_CLUB_CHANGED",
            "callback":onClubChanged
         }]),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },true,[{
            "type":"PUE_perks_updated",
            "callback":onPerksUpdated
         }]),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:IHabboQuestEngine):void
         {
            _questEngine = param1;
         },false,[{
            "type":"qe_uacue",
            "callback":onUnseenAchievementsCountUpdate
         },{
            "type":"qe_udtcue",
            "callback":onUnseenDailyTasksCountUpdate
         },{
            "type":"qe_urtrcue",
            "callback":onUnseenRewardTrackRewardsCountUpdate
         }]),new ComponentDependency(new IIDHabboMessenger(),function(param1:IHabboMessenger):void
         {
            _messenger = param1;
         },false,[{
            "type":"MMME_new",
            "callback":onMiniMailUpdate
         },{
            "type":"MMME_unread",
            "callback":onMiniMailUpdate
         },{
            "type":"HUIUE_UNSEEN_ITEMS_CHANGED",
            "callback":onUnseenItemsUpdate
         }]),new ComponentDependency(new IIDHabboGroupForumController(),null,false,[{
            "type":"UNSEEN_FORUMS_COUNT",
            "callback":onUnseenForumsCountUpdate
         }]),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         },false),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _roomEvents = param1;
         },false,[{
            "type":"WIRED_MENU_BUTTON_PREFERENCE_CHANGED",
            "callback":onWiredMenuEvent
         }])]);
      }
      
      override public function dispose() : void
      {
         UnknownVarFromHabboToolbar_Boolean_1 = false;
         _connection = null;
         destroyClientPromoTimer();
         destroyDimmerTimer();
         destroyOwnRoomPromoTimer();
         if(_extensionView)
         {
            _extensionView.dispose();
            _extensionView = null;
         }
         if(UnknownVarFromHabboToolbar_PurseAreaExtension_1)
         {
            UnknownVarFromHabboToolbar_PurseAreaExtension_1.dispose();
            UnknownVarFromHabboToolbar_PurseAreaExtension_1 = null;
         }
         if(UnknownVarFromHabboToolbar_SettingsExtension_1)
         {
            UnknownVarFromHabboToolbar_SettingsExtension_1.dispose();
            UnknownVarFromHabboToolbar_SettingsExtension_1 = null;
         }
         if(UnknownVarFromHabboToolbar_Vector_1 != null)
         {
            for each(var _loc1_ in UnknownVarFromHabboToolbar_Vector_1)
            {
               _loc1_.dispose();
            }
            UnknownVarFromHabboToolbar_Vector_1 = null;
         }
         if(_offerExtension != null)
         {
            _offerExtension.dispose();
            _offerExtension = null;
         }
         if(UnknownVarFromHabboToolbar_ClubDiscountPromoExtension_1)
         {
            UnknownVarFromHabboToolbar_ClubDiscountPromoExtension_1.dispose();
            UnknownVarFromHabboToolbar_ClubDiscountPromoExtension_1 = null;
         }
         if(UnknownVarFromHabboToolbar_CitizenshipVipQuestsPromoExtension_1)
         {
            UnknownVarFromHabboToolbar_CitizenshipVipQuestsPromoExtension_1.dispose();
            UnknownVarFromHabboToolbar_CitizenshipVipQuestsPromoExtension_1 = null;
         }
         if(UnknownVarFromHabboToolbar_CitizenshipVipDiscountPromoExtension_1)
         {
            UnknownVarFromHabboToolbar_CitizenshipVipDiscountPromoExtension_1.dispose();
            UnknownVarFromHabboToolbar_CitizenshipVipDiscountPromoExtension_1 = null;
         }
         if(UnknownVarFromHabboToolbar_VideoOfferExtension_1)
         {
            UnknownVarFromHabboToolbar_VideoOfferExtension_1.dispose();
            UnknownVarFromHabboToolbar_VideoOfferExtension_1 = null;
         }
         if(_messenger != null)
         {
            if(_messenger.events)
            {
               _messenger.events.removeEventListener("MMME_new",onMiniMailUpdate);
               _messenger.events.removeEventListener("MMME_unread",onMiniMailUpdate);
            }
            _messenger = null;
         }
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 != null)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.dispose();
            UnknownVarFromHabboToolbar_BottomBarLeft_1 = null;
         }
         super.dispose();
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
      }
      
      override protected function initComponent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _connection = _communicationManager.connection;
         _communicationManager.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         UnknownVarFromHabboToolbar_BottomBackgroundBorder_1 = new BottomBackgroundBorder(this);
         UnknownVarFromHabboToolbar_BottomBarLeft_1 = new BottomBarLeft(this,_windowManager,assets,events);
         UnknownVarFromHabboToolbar_BottomBarLeft_1.window.visible = false;
         initRoomEnterEffect();
         _extensionView = new ExtensionView(_windowManager,assets,this);
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 == null)
         {
            Logger.log("Error, toolbar view was not available");
            return;
         }
         var _loc3_:String = getProperty("new.user.wing");
         if(_loc3_ != "")
         {
            _loc1_ = getInteger("new.user.promo.delay",10) * 1000;
            if(_loc1_ > 0 && UnknownVarFromHabboToolbar_Timer_2 == null)
            {
               UnknownVarFromHabboToolbar_Timer_2 = new Timer(_loc1_,1);
               UnknownVarFromHabboToolbar_Timer_2.addEventListener("timerComplete",onShowClientPromo);
               UnknownVarFromHabboToolbar_Timer_2.start();
            }
            if(_loc3_ == "social" || _loc3_ == "quest" || _loc3_ == "group" || _loc3_ == "game")
            {
               _loc2_ = getInteger("new.user.promo.room.delay",180) * 1000;
               if(_loc2_ > 0 && UnknownVarFromHabboToolbar_Timer_3 == null)
               {
                  UnknownVarFromHabboToolbar_Timer_3 = new Timer(_loc2_,1);
                  UnknownVarFromHabboToolbar_Timer_3.addEventListener("timerComplete",onShowOwnRoomPromo);
                  UnknownVarFromHabboToolbar_Timer_3.start();
               }
            }
         }
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(_extensionView && !UnknownVarFromHabboToolbar_Boolean_1)
         {
            initPurseAreaExtension();
            initSeasonalCurrencyExtension();
            initVipExtendExtension();
            initCitizenshipVipExtendExtension();
            initCitizenshipVipQuestsExtension();
            initVideoOfferExtension();
            initOfferExtension();
            initSettingsExtension();
            UnknownVarFromHabboToolbar_Boolean_1 = true;
         }
      }
      
      private function onCatalogEvent(param1:CatalogEvent) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.onCatalogEvent(param1);
         }
      }
      
      private function onWiredMenuEvent(param1:WiredMenuEvent) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.onWiredMenuEvent(param1);
         }
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         if(!UnknownVarFromHabboToolbar_VideoOfferExtension_1)
         {
            initVideoOfferExtension();
         }
      }
      
      private function onShowClientPromo(param1:TimerEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         destroyClientPromoTimer();
         var _loc5_:String = getProperty("new.user.wing");
         var _loc4_:int = 0;
         var _loc6_:String = null;
         switch(_loc5_)
         {
            case "social":
               _loc3_ = "new.user.promo.social";
               _loc2_ = "HTIE_ICON_NAVIGATOR";
               _loc6_ = "NAVIGATOR";
               break;
            case "group":
               _loc3_ = "new.user.promo.group";
               _loc2_ = "HTIE_EXT_GROUP";
               _loc4_ = 1;
               break;
            case "quest":
               _loc3_ = "new.user.promo.quest";
               _loc2_ = "HTIE_ICON_PROGRESSION";
               _loc6_ = "QUESTS";
               break;
            case "game":
               _loc3_ = "new.user.promo.game";
               _loc2_ = "HTIE_ICON_GAMES";
               _loc6_ = "GAMES";
               break;
            default:
               return;
         }
         if(getIconLocation(_loc2_) != null)
         {
            _habboHelp.showWelcomeScreen(_loc2_,_loc3_,_loc4_,_loc6_);
         }
      }
      
      private function onShowOwnRoomPromo(param1:TimerEvent) : void
      {
         destroyOwnRoomPromoTimer();
         _habboHelp.showWelcomeScreen("HTIE_ICON_NAVIGATOR","new.user.promo.room",0,"NAVIGATOR_ME_TAB");
      }
      
      private function initRoomEnterEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!isNewIdentity())
         {
            return;
         }
         if(getBoolean("room.enter.effect.enabled"))
         {
            _loc1_ = getInteger("room.enter.effect.delay",4000);
            _loc2_ = getInteger("room.enter.effect.duration",2000);
            RoomEnterEffect.init(_loc1_,_loc2_);
            createAndAttachDimmerWindow(IWindowController_1(UnknownVarFromHabboToolbar_BottomBarLeft_1.window));
            if(UnknownVarFromHabboToolbar_Timer_1 == null)
            {
               UnknownVarFromHabboToolbar_Timer_1 = new Timer(_loc1_ + _loc2_,1);
               UnknownVarFromHabboToolbar_Timer_1.addEventListener("timerComplete",onRemoveDimmer);
               UnknownVarFromHabboToolbar_Timer_1.start();
            }
         }
      }
      
      private function initPurseAreaExtension() : void
      {
         UnknownVarFromHabboToolbar_PurseAreaExtension_1 = new PurseAreaExtension(this,_catalog);
         UnknownVarFromHabboToolbar_PurseAreaExtension_1.getClubArea().onClubChanged();
      }
      
      private function initSettingsExtension() : void
      {
         UnknownVarFromHabboToolbar_SettingsExtension_1 = new SettingsExtension(this);
      }
      
      private function initSeasonalCurrencyExtension() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:SeasonalCurrencyIndicator = null;
         var _loc5_:PurseEvent = null;
         if(!getBoolean("seasonalcurrencyindicator.enabled"))
         {
            return;
         }
         var _loc4_:Vector.<int> = getSeasonalCurrencyTypes();
         UnknownVarFromHabboToolbar_Vector_1 = new Vector.<SeasonalCurrencyIndicator>();
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc1_ = _loc4_[_loc2_];
            _loc3_ = new SeasonalCurrencyIndicator(this,_windowManager,assets,_catalog,_localization,_loc1_,5 + _loc2_);
            _loc5_ = new PurseEvent("catalog_purse_activity_point_balance",_catalog.getPurse().getActivityPointsForType(_loc1_),_loc1_);
            _loc3_.onBalance(_loc5_);
            UnknownVarFromHabboToolbar_Vector_1.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function getSeasonalCurrencyTypes() : Vector.<int>
      {
         var _loc5_:String = null;
         var _loc7_:Number = NaN;
         var _loc6_:int = 0;
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc4_:String = getProperty("seasonalcurrencyindicator.active");
         if(_loc4_ == null || _loc4_ == "")
         {
            return _loc3_;
         }
         var _loc2_:Array = _loc4_.split(",");
         for each(var _loc1_ in _loc2_)
         {
            _loc5_ = _loc1_.replace(/^\s+|\s+$/g,"");
            if(_loc5_ != "")
            {
               _loc7_ = Number(_loc5_);
               if(!isNaN(_loc7_))
               {
                  _loc6_ = _loc7_;
                  if(_loc3_.indexOf(_loc6_) == -1)
                  {
                     _loc3_.push(_loc6_);
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function initVipExtendExtension() : void
      {
         if(getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            UnknownVarFromHabboToolbar_ClubDiscountPromoExtension_1 = new ClubDiscountPromoExtension(this);
         }
      }
      
      private function initCitizenshipVipQuestsExtension() : void
      {
         if(getBoolean("citizenship.vip.quest.promotion.enabled"))
         {
            UnknownVarFromHabboToolbar_CitizenshipVipQuestsPromoExtension_1 = new CitizenshipVipQuestsPromoExtension(this,_windowManager,assets,events,_localization,_connection);
         }
      }
      
      private function initCitizenshipVipExtendExtension() : void
      {
         if(getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            UnknownVarFromHabboToolbar_CitizenshipVipDiscountPromoExtension_1 = new CitizenshipVipDiscountPromoExtension(this);
         }
      }
      
      private function initVideoOfferExtension() : void
      {
         var _loc1_:Boolean = !isNewIdentity() || !getBoolean("new.identity.hide.ui");
         if(_catalog.videoOffers.enabled && getBoolean("toolbar.extension.video.promo.enabled") && _loc1_)
         {
            UnknownVarFromHabboToolbar_VideoOfferExtension_1 = new VideoOfferExtension(this);
         }
      }
      
      private function initOfferExtension() : void
      {
         var _loc1_:Boolean = !isNewIdentity() || !getBoolean("new.identity.hide.ui");
         if(getBoolean("offers.enabled") && _loc1_ && !getBoolean("offers.habboclub.enabled"))
         {
            _offerExtension = new OfferExtension(this,_windowManager,assets,_catalog);
         }
      }
      
      public function toggleSettingVisibility() : void
      {
         if(UnknownVarFromHabboToolbar_SettingsExtension_1 && UnknownVarFromHabboToolbar_SettingsExtension_1.window)
         {
            UnknownVarFromHabboToolbar_SettingsExtension_1.window.visible = !UnknownVarFromHabboToolbar_SettingsExtension_1.window.visible;
         }
         extensionView.refreshItemWindow();
      }
      
      private function onRemoveDimmer(param1:TimerEvent) : void
      {
         destroyDimmerTimer();
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            removeDimmer(UnknownVarFromHabboToolbar_BottomBarLeft_1.window as IWindowController_1);
         }
         if(_extensionView)
         {
            _extensionView.removeDimmers();
         }
      }
      
      public function createAndAttachDimmerWindow(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowModel = null;
         if(RoomEnterEffect.isRunning())
         {
            if(param1 == null)
            {
               return;
            }
            _loc2_ = _windowManager.createWindow("toolbar_dimmer","",30,1,0x80 | 0x0800 | 1,new Rectangle(0,0,param1.width,param1.height),null,0);
            _loc2_.color = 0;
            _loc2_.blend = 0.3;
            param1.addChild(_loc2_);
            param1.invalidate();
         }
      }
      
      public function removeDimmer(param1:IWindowController_1) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindowModel = param1.findChildByName("toolbar_dimmer");
         if(_loc2_ != null)
         {
            param1.removeChild(_loc2_);
            param1.invalidate();
            _windowManager.destroy(_loc2_);
         }
      }
      
      public function toggleWindowVisibility(param1:String) : void
      {
         var _loc4_:HabboToolbarEvent = null;
         var _loc5_:HabboToolbarEvent = null;
         var _loc2_:String = HabboToolbarIconEnum[param1];
         if(_loc2_ == "HTIE_ICON_CAMERA")
         {
            _loc4_ = new HabboToolbarEvent("HTE_ICON_CAMERA");
            _loc4_.iconName = "toolBarCameraIcon";
            events.dispatchEvent(_loc4_);
         }
         else
         {
            _loc5_ = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
            _loc5_.iconId = _loc2_;
            _loc5_.iconName = param1;
            events.dispatchEvent(_loc5_);
         }
         var _loc3_:EventLogMessageComposer = new EventLogMessageComposer("Toolbar",param1,"client.toolbar.clicked");
         if(_connection)
         {
            _connection.send(_loc3_);
         }
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc2_:Rectangle = null;
         if(param1 == "HTIE_EXT_GROUP")
         {
            _loc2_ = _extensionView.getIconLocation(param1);
         }
         else if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            _loc2_ = UnknownVarFromHabboToolbar_BottomBarLeft_1.getIconLocation(param1);
         }
         if(!_loc2_ && UnknownVarFromHabboToolbar_PurseAreaExtension_1)
         {
            _loc2_ = UnknownVarFromHabboToolbar_PurseAreaExtension_1.getIconLocation(param1);
         }
         return _loc2_;
      }
      
      public function getIcon(param1:String) : IWindowModel
      {
         var _loc2_:IWindowModel = null;
         if(param1 == "HTIE_EXT_GROUP")
         {
            _loc2_ = _extensionView.getIcon(param1);
         }
         else if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            _loc2_ = UnknownVarFromHabboToolbar_BottomBarLeft_1.geIcon(param1);
            if(_loc2_ as IStaticBitmapWrapperWindow)
            {
               _loc2_ = _loc2_.parent;
            }
         }
         if(!_loc2_ && UnknownVarFromHabboToolbar_PurseAreaExtension_1)
         {
            _loc2_ = UnknownVarFromHabboToolbar_PurseAreaExtension_1.getIcon(param1);
         }
         return _loc2_;
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.setUnseenItemCount(param1,param2);
         }
      }
      
      public function setToolbarState(param1:String) : void
      {
         switch(param1)
         {
            case "HTE_STATE_HOTEL_VIEW":
            case "HTE_STATE_GAME_CENTER_VIEW":
               showExtensions(true);
               break;
            case "HTE_STATE_ROOM_VIEW":
               showExtensions(true);
               break;
            case "HTE_STATE_HIDDEN":
               showExtensions(false);
         }
         if(_extensionView != null)
         {
            _extensionView.landingView = param1 == "HTE_STATE_HOTEL_VIEW";
         }
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.setToolbarState(param1);
            UnknownVarFromHabboToolbar_BottomBarLeft_1.window.visible = true;
         }
         if(_habboHelp != null)
         {
            _habboHelp.outsideRoom = param1 != "HTE_STATE_ROOM_VIEW";
         }
         var _loc2_:HabboToolbarEvent = new HabboToolbarEvent("HTE_RESIZED");
         events.dispatchEvent(_loc2_);
      }
      
      public function getToolbarState() : String
      {
         return UnknownVarFromHabboToolbar_BottomBarLeft_1.getToolbarState();
      }
      
      private function showExtensions(param1:Boolean) : void
      {
         if(_extensionView)
         {
            _extensionView.visible = param1;
         }
      }
      
      public function setIconBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:BitmapData = null;
         if(param2 != null)
         {
            _loc3_ = param2.clone();
         }
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.setIconBitmap(param1,param2);
         }
      }
      
      public function getRect() : Rectangle
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            return UnknownVarFromHabboToolbar_BottomBarLeft_1.window.rectangle;
         }
         return new Rectangle();
      }
      
      public function get extensionView() : IExtensionView
      {
         return _extensionView;
      }
      
      public function get soundManager() : IHabboSoundManagerFlash10
      {
         return _soundManager;
      }
      
      public function createTransitionToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 && !UnknownVarFromHabboToolbar_BottomBarLeft_1.disposed)
         {
            return UnknownVarFromHabboToolbar_BottomBarLeft_1.animateToIcon(param1,param2,param3,param4);
         }
         param2.dispose();
         return null;
      }
      
      public function isXmasEnabled() : Boolean
      {
         return getBoolean("xmas11.enabled");
      }
      
      public function isValentinesEnabled() : Boolean
      {
         return getBoolean("valentines.enabled");
      }
      
      public function isNewIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function setIconVisibility(param1:String, param2:Boolean) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.iconVisibility(param1,param2);
         }
      }
      
      private function destroyDimmerTimer() : void
      {
         if(UnknownVarFromHabboToolbar_Timer_1)
         {
            UnknownVarFromHabboToolbar_Timer_1.removeEventListener("timerComplete",onRemoveDimmer);
            UnknownVarFromHabboToolbar_Timer_1.stop();
            UnknownVarFromHabboToolbar_Timer_1 = null;
         }
      }
      
      private function destroyClientPromoTimer() : void
      {
         if(UnknownVarFromHabboToolbar_Timer_2)
         {
            UnknownVarFromHabboToolbar_Timer_2.removeEventListener("timerComplete",onShowClientPromo);
            UnknownVarFromHabboToolbar_Timer_2.stop();
            UnknownVarFromHabboToolbar_Timer_2 = null;
         }
      }
      
      private function destroyOwnRoomPromoTimer() : void
      {
         if(UnknownVarFromHabboToolbar_Timer_3)
         {
            UnknownVarFromHabboToolbar_Timer_3.removeEventListener("timerComplete",onShowOwnRoomPromo);
            UnknownVarFromHabboToolbar_Timer_3.stop();
            UnknownVarFromHabboToolbar_Timer_3 = null;
         }
      }
      
      private function onMiniMailUpdate(param1:MiniMailMessageEvent) : void
      {
         if(!_messenger || !UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            return;
         }
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 != null)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenMiniMailMessageCount = _messenger.getUnseenMiniMailMessageCount();
            UnknownVarFromHabboToolbar_BottomBarLeft_1.memenu.unseenMinimailsCount = _messenger.getUnseenMiniMailMessageCount();
            setUnseenItemCount("HTIE_ICON_MEMENU",UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenMeMenuCount);
         }
      }
      
      private function onUnseenAchievementsCountUpdate(param1:UnseenAchievementsCountUpdateEvent) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 != null)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenAchievementCount = param1.count;
            UnknownVarFromHabboToolbar_BottomBarLeft_1.progmenu.unseenAchievementsCount = param1.count;
            setUnseenItemCount("HTIE_ICON_PROGRESSION",UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenProgMenuCount);
         }
      }
      
      private function onUnseenDailyTasksCountUpdate(param1:UnseenDailyTasksCountUpdateEvent) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 != null)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenDailyTasksCount = param1.count;
            UnknownVarFromHabboToolbar_BottomBarLeft_1.progmenu.unseenDailyTaskCount = param1.count;
            setUnseenItemCount("HTIE_ICON_PROGRESSION",UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenProgMenuCount);
         }
      }
      
      private function onUnseenRewardTrackRewardsCountUpdate(param1:UnseenRewardTrackRewardsCountUpdateEvent) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 != null)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenRewardTrackRewardsCount = param1.count;
            UnknownVarFromHabboToolbar_BottomBarLeft_1.progmenu.unseenRewardTrackRewardsCount = param1.count;
            setUnseenItemCount("HTIE_ICON_PROGRESSION",UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenProgMenuCount);
         }
      }
      
      private function onUnseenForumsCountUpdate(param1:UnseenForumsCountUpdatedEvent) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 != null)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenForumsCount = param1.unseenForumsCount;
            UnknownVarFromHabboToolbar_BottomBarLeft_1.memenu.unseenForumsCount = param1.unseenForumsCount;
            setUnseenItemCount("HTIE_ICON_MEMENU",UnknownVarFromHabboToolbar_BottomBarLeft_1.unseenMeMenuCount);
         }
      }
      
      public function set onDuty(param1:Boolean) : void
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1 != null)
         {
            UnknownVarFromHabboToolbar_BottomBarLeft_1.onDuty = param1;
         }
      }
      
      private function onUnseenItemsUpdate(param1:HabboUnseenItemsUpdatedEvent) : void
      {
         setUnseenItemCount("HTIE_ICON_INVENTORY",param1.inventoryCount);
         setUnseenItemCount("HTIE_ICON_GAMES",param1.getCategoryCount(6));
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(UnknownVarFromHabboToolbar_PurseAreaExtension_1 != null)
         {
            UnknownVarFromHabboToolbar_PurseAreaExtension_1.getClubArea().onClubChanged(param1);
         }
         if(UnknownVarFromHabboToolbar_CitizenshipVipDiscountPromoExtension_1 != null)
         {
            UnknownVarFromHabboToolbar_CitizenshipVipDiscountPromoExtension_1.onClubChanged(param1);
         }
         if(UnknownVarFromHabboToolbar_VideoOfferExtension_1 != null)
         {
            UnknownVarFromHabboToolbar_VideoOfferExtension_1.onClubChanged(param1);
         }
         if(UnknownVarFromHabboToolbar_ClubDiscountPromoExtension_1 != null)
         {
            UnknownVarFromHabboToolbar_ClubDiscountPromoExtension_1.onClubChanged(param1);
         }
      }
      
      public function refreshPurseAreaIndicators() : void
      {
         if(UnknownVarFromHabboToolbar_PurseAreaExtension_1 != null)
         {
            UnknownVarFromHabboToolbar_PurseAreaExtension_1.refreshIndicators();
         }
      }
      
      public function get toolBarAreaWidth() : int
      {
         if(UnknownVarFromHabboToolbar_BottomBarLeft_1)
         {
            return UnknownVarFromHabboToolbar_BottomBarLeft_1.getToolbarAreaWidth();
         }
         return 0;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get connection() : IConnection
      {
         return _connection;
      }
      
      public function get navigator() : IHabboNavigator_1
      {
         if(_newNavigator != null)
         {
            return _newNavigator.legacyNavigator;
         }
         return null;
      }
      
      public function get questEngine() : IHabboQuestEngine
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : IHabboFreeFlowChat
      {
         return _freeFlowChat;
      }
      
      public function get roomUI() : IRoomUI
      {
         return _roomUI;
      }
      
      public function get inventory() : IHabboInventory
      {
         return _inventory;
      }
      
      public function get localization() : ICoreLocalizationManager
      {
         return _localization;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get messenger() : IHabboMessenger
      {
         return _messenger;
      }
      
      public function get roomEvents() : IHabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function reboot() : void
      {
         (context as CoreComponentContext).reboot();
      }
   }
}

