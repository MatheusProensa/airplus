package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.purse.GetCreditsInfoComposer;
   import com.sulake.habbo.communication.messages.outgoing.nft.GetNftCreditsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nft.GetSilverMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.inventory.badges.Badge;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.inventory.bots.BotsModel;
   import com.sulake.habbo.inventory.collectibles.CollectiblesModel;
   import com.sulake.habbo.inventory.effects.EffectsModel;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.inventory.pets.PetsModel;
   import com.sulake.habbo.inventory.purse.Purse;
   import com.sulake.habbo.inventory.recycler.RecyclerModel;
   import com.sulake.habbo.inventory.trading.ITradingModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.inventory.wired_trading.WiredTradingModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.*;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HabboInventory extends Component implements IHabboInventory, ILinkEventTracker
   {
      private var _communication:IHabboCommunicationManager;
      
      private var _incomingMessages:IncomingMessages;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _view:InventoryMainView;
      
      private var _inventories:Map;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSession:IRoomSession;
      
      private var _initedInventoryCategories:Array;
      
      private var UnknownVarFromHabboInventory_Purse_1:Purse;
      
      private var _avatarRenderer:IAvatarRenderManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _isInitialized:Boolean;
      
      private var _unseenItemTracker:UnseenItemTracker;
      
      private var UnknownVarFromHabboInventory_Boolean_1:Boolean = false;
      
      private var _notifications:IHabboNotifications;
      
      private var _friendList:IHabboFriendList;
      
      private var _currentCategoryId:String;
      
      private var UnknownVarFromHabboInventory_Vector_1:Vector.<int>;
      
      private var _boundFurnitureNames:Vector.<String>;
      
      private var UnknownVarFromHabboInventory_Timer_1:Timer;
      
      public function HabboInventory(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         UnknownVarFromHabboInventory_Purse_1 = new Purse();
         _initedInventoryCategories = [];
         UnknownVarFromHabboInventory_Vector_1 = new Vector.<int>(0);
      }
      
      public function get isVisible() : Boolean
      {
         return _view.isVisible;
      }
      
      public function get isMainViewActive() : Boolean
      {
         return _view.isActive;
      }
      
      public function get isInitialized() : Boolean
      {
         return _isInitialized;
      }
      
      public function get unseenItemTracker() : IUnseenItemTracker
      {
         return _unseenItemTracker;
      }
      
      public function get view() : InventoryMainView
      {
         return _view;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderer = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSE_ENDED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDUE_ALLOW_PETS",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDHabboToolbar(),null,false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":habboToolbarEventHandler
         }]),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         })]);
      }
      
      private function habboToolbarEventHandler(param1:HabboToolbarEvent) : void
      {
         if(_view != null)
         {
            _view.onHabboToolbarEvent(param1);
         }
      }
      
      override protected function initComponent() : void
      {
         if(HabboComponentFlags.isRoomViewerMode(flags))
         {
            return;
         }
         _incomingMessages = new IncomingMessages(this);
         context.addLinkEventTracker(this);
         _unseenItemTracker = new UnseenItemTracker(_communication,events,this);
         _view = new InventoryMainView(this,_windowManager,assets);
         _communication.connection.send(new GetCreditsInfoComposer());
         _communication.connection.send(new GetNftCreditsMessageComposer());
         _communication.connection.send(new GetSilverMessageComposer());
         _communication.connection.send(new ScrGetUserInfoMessageComposer("habbo_club"));
         _communication.connection.send(new GetBadgePointLimitsComposer());
      }
      
      override public function dispose() : void
      {
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:String = null;
         var _loc2_:IInventoryModel = null;
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromHabboInventory_Timer_1 != null)
         {
            UnknownVarFromHabboInventory_Timer_1.stop();
            UnknownVarFromHabboInventory_Timer_1.removeEventListener("timer",onPurseTimer);
            UnknownVarFromHabboInventory_Timer_1 = null;
         }
         if(_inventories)
         {
            _loc4_ = _inventories.getKeys();
            _loc1_ = 0;
            while(_loc1_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc1_];
               _loc2_ = _inventories.getValue(_loc3_) as IInventoryModel;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            _inventories.dispose();
            _inventories = null;
         }
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
         _roomSession = null;
         _friendList = null;
         if(_unseenItemTracker != null)
         {
            _unseenItemTracker.dispose();
            _unseenItemTracker = null;
         }
         if(_incomingMessages != null)
         {
            _incomingMessages.dispose();
            _incomingMessages = null;
         }
         super.dispose();
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function getModel(param1:String) : IInventoryModel
      {
         if(!_isInitialized)
         {
            init();
         }
         return _inventories.getValue(param1);
      }
      
      public function get furniModel() : FurniModel
      {
         return disposed ? null : FurniModel(getModel("furni"));
      }
      
      public function get tradingModel() : TradingModel
      {
         return disposed ? null : TradingModel(getModel("trading"));
      }
      
      public function get wiredTradingModel() : WiredTradingModel
      {
         return disposed ? null : WiredTradingModel(getModel("wired_trading"));
      }
      
      public function get effectsModel() : EffectsModel
      {
         return disposed ? null : EffectsModel(getModel("effects"));
      }
      
      public function get badgesModel() : BadgesModel
      {
         return disposed ? null : BadgesModel(getModel("badges"));
      }
      
      public function get recyclerModel() : RecyclerModel
      {
         return disposed ? null : RecyclerModel(getModel("recycler"));
      }
      
      public function get petsModel() : PetsModel
      {
         return disposed ? null : PetsModel(getModel("pets"));
      }
      
      public function get botsModel() : BotsModel
      {
         return disposed ? null : BotsModel(getModel("bots"));
      }
      
      public function get collectiblesModel() : CollectiblesModel
      {
         return disposed ? null : CollectiblesModel(getModel("collectibles"));
      }
      
      public function get marketplaceModel() : MarketplaceModel
      {
         return disposed ? null : MarketplaceModel(getModel("marketplace"));
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get roomSession() : IRoomSession
      {
         return _roomSession;
      }
      
      public function get friendList() : IHabboFriendList
      {
         return _friendList;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get clubDays() : int
      {
         return UnknownVarFromHabboInventory_Purse_1.clubDays;
      }
      
      public function get clubPeriods() : int
      {
         return UnknownVarFromHabboInventory_Purse_1.clubPeriods;
      }
      
      public function get clubPastPeriods() : int
      {
         return UnknownVarFromHabboInventory_Purse_1.clubPastPeriods;
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return UnknownVarFromHabboInventory_Purse_1.clubHasEverBeenMember;
      }
      
      public function get clubIsExpiring() : Boolean
      {
         return UnknownVarFromHabboInventory_Purse_1.clubIsExpiring;
      }
      
      public function get citizenshipVipIsExpiring() : Boolean
      {
         return UnknownVarFromHabboInventory_Purse_1.citizenshipVipIsExpiring;
      }
      
      public function get clubMinutesUntilExpiration() : int
      {
         return UnknownVarFromHabboInventory_Purse_1.minutesUntilExpiration;
      }
      
      public function get clubLevel() : int
      {
         if(clubDays == 0 && clubPeriods == 0)
         {
            return 0;
         }
         if(UnknownVarFromHabboInventory_Purse_1.isVIP)
         {
            return 2;
         }
         return 1;
      }
      
      public function get hasRoomSession() : Boolean
      {
         return _roomSession != null;
      }
      
      public function getSubCategoryViewId() : String
      {
         return _view.getSubCategoryViewId();
      }
      
      public function setClubStatus(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:int, param8:int) : void
      {
         UnknownVarFromHabboInventory_Purse_1.clubPeriods = param1;
         UnknownVarFromHabboInventory_Purse_1.clubDays = param2;
         UnknownVarFromHabboInventory_Purse_1.clubHasEverBeenMember = param3;
         UnknownVarFromHabboInventory_Purse_1.isVIP = param4;
         UnknownVarFromHabboInventory_Purse_1.clubIsExpiring = param5;
         UnknownVarFromHabboInventory_Purse_1.citizenshipVipIsExpiring = param6;
         UnknownVarFromHabboInventory_Purse_1.minutesUntilExpiration = param7;
         UnknownVarFromHabboInventory_Purse_1.minutesSinceLastModified = param8;
         if(param7 > 0 && param7 < 86400000)
         {
            if(UnknownVarFromHabboInventory_Timer_1 == null)
            {
               UnknownVarFromHabboInventory_Timer_1 = new Timer(60000,0);
               UnknownVarFromHabboInventory_Timer_1.addEventListener("timer",onPurseTimer);
            }
            if(!UnknownVarFromHabboInventory_Timer_1.running)
            {
               UnknownVarFromHabboInventory_Timer_1.start();
            }
         }
         else if(UnknownVarFromHabboInventory_Timer_1 != null)
         {
            UnknownVarFromHabboInventory_Timer_1.stop();
            UnknownVarFromHabboInventory_Timer_1.removeEventListener("timer",onPurseTimer);
            UnknownVarFromHabboInventory_Timer_1 = null;
         }
      }
      
      private function onPurseTimer(param1:TimerEvent) : void
      {
         _communication.connection.send(new ScrGetUserInfoMessageComposer("habbo_club"));
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_STARTED":
               _roomSession = param1.session;
               if(_isInitialized)
               {
                  if(petsModel != null)
                  {
                     petsModel.updatePetsAllowed();
                  }
                  if(furniModel != null)
                  {
                     furniModel.updateView();
                  }
               }
               break;
            case "RSE_ENDED":
               _roomSession = null;
               if(_isInitialized)
               {
                  deselectAllEffects();
               }
               break;
            case "RSDUE_ALLOW_PETS":
               if(_isInitialized)
               {
                  if(petsModel != null)
                  {
                     petsModel.updatePetsAllowed();
                  }
               }
         }
      }
      
      private function init() : void
      {
         if(!allRequiredDependenciesInjected)
         {
            return;
         }
         _inventories = new Map();
         var _loc8_:MarketplaceModel = new MarketplaceModel(this,_windowManager,_communication,assets,_roomEngine,_localization);
         _inventories.add("marketplace",_loc8_);
         var _loc1_:FurniModel = new FurniModel(this,_loc8_,_windowManager,_communication,assets,_roomEngine,_catalog,_soundManager,_localization);
         _inventories.add("furni",_loc1_);
         if(!mergeRentFurni)
         {
            _inventories.add("rentables",_loc1_);
         }
         var _loc10_:CollectiblesModel = new CollectiblesModel(this,_windowManager,_communication,assets,_roomEngine,_catalog,_avatarRenderer);
         _inventories.add("collectibles",_loc10_);
         var _loc2_:BadgesModel = new BadgesModel(this,_windowManager,_communication,assets);
         _inventories.add("badges",_loc2_);
         var _loc4_:EffectsModel = new EffectsModel(this,_windowManager,_communication,assets,_localization);
         _inventories.add("effects",_loc4_);
         var _loc5_:TradingModel = new TradingModel(this,_windowManager,_communication,assets,_roomEngine,_localization,_soundManager,_notifications);
         _inventories.add("trading",_loc5_);
         var _loc6_:WiredTradingModel = new WiredTradingModel(this,_windowManager,_communication,assets,_roomEngine,_localization,_soundManager,_notifications);
         _inventories.add("wired_trading",_loc6_);
         var _loc3_:RecyclerModel = new RecyclerModel(this,_windowManager,_communication,assets,_roomEngine,_localization);
         _inventories.add("recycler",_loc3_);
         var _loc9_:PetsModel = new PetsModel(this,_windowManager,_communication,assets,_roomEngine,_catalog);
         _inventories.add("pets",_loc9_);
         var _loc7_:BotsModel = new BotsModel(this,_windowManager,_communication,assets,_roomEngine,_catalog,_avatarRenderer);
         _inventories.add("bots",_loc7_);
         _isInitialized = true;
      }
      
      public function getCategoryWindowContainer(param1:String) : IWindowController_1
      {
         var _loc2_:IInventoryModel = IInventoryModel(_inventories.getValue(param1));
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.getWindowContainer();
      }
      
      public function updateView(param1:String) : void
      {
         var _loc2_:IInventoryModel = IInventoryModel(_inventories.getValue(param1));
         if(_loc2_ == null)
         {
            return;
         }
         return _loc2_.updateView();
      }
      
      public function getCategorySubWindowContainer(param1:String) : IWindowController_1
      {
         var _loc2_:IInventoryModel = IInventoryModel(_inventories.getValue(param1));
         return _loc2_ == null ? null : _loc2_.getWindowContainer();
      }
      
      public function getActivatedAvatarEffects() : Array
      {
         return effectsModel == null ? [] : effectsModel.getEffects(1);
      }
      
      public function getAvatarEffects() : Array
      {
         return effectsModel == null ? [] : effectsModel.getEffects();
      }
      
      public function setEffectSelected(param1:int) : void
      {
         var _loc2_:EffectsModel = effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.useEffect(param1);
         notifyChangedEffects();
      }
      
      public function setEffectDeselected(param1:int) : void
      {
         var _loc2_:EffectsModel = effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.stopUsingEffect(param1,true);
         notifyChangedEffects();
      }
      
      public function deselectAllEffects(param1:Boolean = false) : void
      {
         var _loc2_:EffectsModel = effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.stopUsingAllEffects(true,true,param1);
         notifyChangedEffects();
      }
      
      public function getAvatarEffect(param1:int) : IInventoryMainView
      {
         return effectsModel == null ? null : effectsModel.getEffectInterface(param1);
      }
      
      public function closeView() : void
      {
         if(_view && _view.isVisible)
         {
            _view.hideInventory();
         }
      }
      
      public function showView() : void
      {
         if(_view)
         {
            _view.showInventory();
         }
      }
      
      public function get isMainViewInitialized() : Boolean
      {
         return _view.mainContainer != null;
      }
      
      public function initializeFurniturePage() : void
      {
         if(_view)
         {
            toggleInventoryPage("furni");
            _view.hideInventory();
         }
      }
      
      public function toggleInventoryPage(param1:String, param2:String = null, param3:Boolean = false) : void
      {
         _currentCategoryId = param1;
         var _loc4_:Boolean = _view.toggleCategoryView(param1,false,param3);
         if(_loc4_)
         {
            inventoryViewOpened(param1);
            if(param2 != null)
            {
               IInventoryModel(_inventories.getValue(_currentCategoryId)).selectItemById(param2);
            }
         }
         if(!_loc4_)
         {
            events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_CLOSED"));
         }
      }
      
      public function toggleInventorySubPage(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IInventoryModel = null;
         switch(param1)
         {
            case "trading":
            case "wired_trading":
               _view.toggleCategoryView("furni",false);
         }
         _view.toggleSubCategoryView(param1,false);
         _loc2_ = 0;
         while(_loc2_ < _inventories.length)
         {
            _loc3_ = _inventories.getWithIndex(_loc2_) as IInventoryModel;
            _loc3_.subCategorySwitch(param1);
            _loc2_++;
         }
      }
      
      public function updateSubView() : void
      {
         _view.updateSubCategoryView();
      }
      
      public function closingInventoryView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IInventoryModel = null;
         if(_inventories)
         {
            _loc1_ = 0;
            while(_loc1_ < _inventories.length)
            {
               _loc2_ = _inventories.getWithIndex(_loc1_) as IInventoryModel;
               _loc2_.closingInventoryView();
               _loc1_++;
            }
         }
         events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_CLOSED"));
      }
      
      public function preparingInventoryView() : void
      {
         if(!_isInitialized)
         {
            init();
         }
      }
      
      public function inventoryViewOpened(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IInventoryModel = null;
         _loc2_ = 0;
         while(_loc2_ < _inventories.length)
         {
            _loc3_ = _inventories.getWithIndex(_loc2_) as IInventoryModel;
            _loc3_.categorySwitch(param1);
            _loc2_++;
         }
      }
      
      public function setupTrading(param1:int, param2:String) : void
      {
         if(!_isInitialized)
         {
            init();
         }
         var _loc3_:TradingModel = tradingModel;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.requestOpenTrading(param1);
      }
      
      public function get tradingActive() : Boolean
      {
         return activeTradingModel != null;
      }
      
      public function get activeTradingModel() : ITradingModel
      {
         if(tradingModel != null && tradingModel.running)
         {
            return tradingModel;
         }
         if(wiredTradingModel != null && wiredTradingModel.running)
         {
            return wiredTradingModel;
         }
         return null;
      }
      
      public function getItemImage(param1:FurnitureItem) : BitmapData
      {
         var _loc2_:UnknownHabboRoom1 = null;
         if(!param1.isWallItem)
         {
            _loc2_ = _roomEngine.getFurnitureImage(param1.type,new Vector3d(180,0,0),64,null,0,String(param1.extra),-1,-1,param1.stuffData);
         }
         else
         {
            _loc2_ = _roomEngine.getWallItemImage(param1.type,new Vector3d(180,0,0),64,null,0,param1.stuffData.getLegacyString());
         }
         return _loc2_.data as BitmapData;
      }
      
      public function onTradeActiveChanged(param1:Boolean = false) : void
      {
         view.disableNonTradingTabs(tradingActive);
         if(web3tradeEnabled)
         {
            view.showCollectiblesTab(tradingActive);
            if(param1)
            {
               collectiblesModel.onTradeComplete();
            }
         }
      }
      
      public function onWiredTradeActiveChanged() : void
      {
         view.disableNonTradingTabs(tradingActive);
      }
      
      public function get web3tradeEnabled() : Boolean
      {
         return getBoolean("web3trade.enabled");
      }
      
      public function setupRecycler(param1:Boolean) : void
      {
         if(recyclerModel != null)
         {
            if(param1)
            {
               recyclerModel.startRecycler();
            }
            else
            {
               recyclerModel.stopRecycler();
            }
         }
      }
      
      public function requestSelectedFurniToRecycler() : int
      {
         return recyclerModel != null ? recyclerModel.lockSelectedFurni() : 0;
      }
      
      public function returnInventoryFurniFromRecycler(param1:int) : Boolean
      {
         return recyclerModel != null ? recyclerModel.releaseFurni(param1) : false;
      }
      
      public function canUserOfferToTrade() : Boolean
      {
         if(wiredTradingModel.running)
         {
            return true;
         }
         var _loc1_:TradingModel = tradingModel;
         return _loc1_ != null ? _loc1_.ownUserCanTrade : false;
      }
      
      public function setInventoryCategoryInit(param1:String, param2:Boolean = true) : Boolean
      {
         var _loc3_:int = 0;
         if(param2)
         {
            if(_initedInventoryCategories.indexOf(param1) == -1)
            {
               _initedInventoryCategories.push(param1);
               return true;
            }
         }
         else
         {
            _loc3_ = int(_initedInventoryCategories.indexOf(param1));
            if(_loc3_ >= 0)
            {
               _initedInventoryCategories.splice(_loc3_,1);
            }
            if(_view != null && _view.isVisible)
            {
               if(param1 != "rentables")
               {
                  requestInventoryCategoryInit(param1);
               }
            }
         }
         return false;
      }
      
      public function isInventoryCategoryInit(param1:String) : Boolean
      {
         return _initedInventoryCategories.indexOf(param1) >= 0;
      }
      
      public function checkCategoryInitilization(param1:String) : Boolean
      {
         if(isInventoryCategoryInit(param1))
         {
            return true;
         }
         requestInventoryCategoryInit(param1);
         return false;
      }
      
      public function requestInventoryCategoryInit(param1:String) : void
      {
         var _loc2_:IInventoryModel = _inventories.getValue(param1) as IInventoryModel;
         if(_loc2_ != null)
         {
            _loc2_.requestInitialization();
         }
      }
      
      public function notifyChangedEffects() : void
      {
         events.dispatchEvent(new HabboInventoryEffectsEvent("HIEE_EFFECTS_CHANGED"));
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function requestSelectedFurniToMover(param1:IFurnitureItem) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(param1.isWallItem)
         {
            _loc3_ = 20;
         }
         else
         {
            _loc3_ = 10;
         }
         if(param1.category == 6)
         {
            _loc2_ = _roomEngine.initializeRoomObjectInsert("inventory",param1.id,_loc3_,param1.type,param1.stuffData.getLegacyString());
         }
         else
         {
            _loc2_ = _roomEngine.initializeRoomObjectInsert("inventory",param1.id,_loc3_,param1.type,param1.extra.toString(),param1.stuffData);
         }
         return _loc2_;
      }
      
      public function getFloorItemById(param1:int) : IFurnitureItem
      {
         var _loc2_:IFurnitureItem = null;
         for each(var _loc3_ in furniModel.furniData)
         {
            _loc2_ = _loc3_.getItem(param1);
            if(_loc2_ != null && !_loc2_.isWallItem)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getWallItemById(param1:int) : IFurnitureItem
      {
         var _loc2_:IFurnitureItem = null;
         for each(var _loc3_ in furniModel.furniData)
         {
            _loc2_ = _loc3_.getItem(param1);
            if(_loc2_ != null && _loc2_.isWallItem)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getNonRentedInventoryIds(param1:String, param2:int, param3:Boolean) : Array
      {
         var _loc5_:FurniModel = _inventories.getValue(param1);
         if(!_loc5_)
         {
            return null;
         }
         var _loc4_:GroupItem = furniModel.getGroupItemByItemTypeId(param2,param3);
         if(!_loc4_)
         {
            return null;
         }
         return _loc4_.getNonRentedFurnitureIds();
      }
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         return petsModel.placePetToRoom(param1,param2);
      }
      
      public function get mergeRentFurni() : Boolean
      {
         return true;
      }
      
      public function updateUnseenItemCounts() : void
      {
         var _loc4_:int = 0;
         _loc4_ = _unseenItemTracker.getCount(1);
         _view.updateUnseenFurniCount(_loc4_);
         _loc4_ = _unseenItemTracker.getCount(2);
         _view.updateUnseenRentedFurniCount(_loc4_);
         var _loc1_:int = _unseenItemTracker.getCount(3);
         _view.updateUnseenPetsCount(_loc1_);
         var _loc3_:int = _unseenItemTracker.getCount(4);
         _view.updateUnseenBadgeCount(_loc3_);
         var _loc2_:int = _unseenItemTracker.getCount(5);
         _view.updateUnseenBotCount(_loc2_);
      }
      
      public function removeUnseenFurniCounter(param1:int) : Boolean
      {
         var _loc2_:Boolean = furniModel.removeUnseenFurniCounter(param1);
         if(_loc2_)
         {
            updateUnseenItemCounts();
         }
         return _loc2_;
      }
      
      public function removeUnseenPetCounter(param1:int) : Boolean
      {
         var _loc2_:Boolean = petsModel.removeUnseenFurniCounter(param1);
         if(_loc2_)
         {
            updateUnseenItemCounts();
         }
         return _loc2_;
      }
      
      public function get botsMax() : int
      {
         return getInteger("inventory.bots.max",150);
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get currentCategoryId() : String
      {
         return _currentCategoryId;
      }
      
      public function getFurnitureData(param1:int, param2:String) : IFurnitureData
      {
         var _loc3_:IFurnitureData = null;
         if(_sessionDataManager == null)
         {
            return null;
         }
         if(param2 == "s")
         {
            _loc3_ = _sessionDataManager.getFloorItemData(param1);
         }
         if(param2 == "i")
         {
            _loc3_ = _sessionDataManager.getWallItemData(param1);
         }
         return _loc3_;
      }
      
      public function getFurnitureDataByName(param1:String, param2:String, param3:int = 0) : IFurnitureData
      {
         var _loc4_:IFurnitureData = null;
         if(_sessionDataManager == null)
         {
            return null;
         }
         if(param2 == "s")
         {
            _loc4_ = _sessionDataManager.getFloorItemDataByName(param1);
         }
         if(param2 == "i")
         {
            _loc4_ = _sessionDataManager.getWallItemDataByName(param1);
         }
         return _loc4_;
      }
      
      public function get linkPattern() : String
      {
         return "inventory/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("open" !== _loc3_)
         {
            Logger.log("Inventory unknown link-type received: " + _loc2_[1]);
         }
         else if(_loc2_.length == 2)
         {
            toggleInventoryPage("furni");
         }
         else if(_loc2_.length == 3)
         {
            toggleInventoryPage(_loc2_[2]);
         }
         else if(_loc2_.length == 4)
         {
            toggleInventoryPage(_loc2_[2],_loc2_[3]);
         }
      }
      
      public function getAllMyBadgeIds(param1:Array) : Array
      {
         var _loc2_:BadgesModel = _inventories.getValue("badges");
         var _loc4_:Array = [];
         if(_loc2_.getBadges().length == 0 && !UnknownVarFromHabboInventory_Boolean_1)
         {
            badgesModel.requestInitialization();
            UnknownVarFromHabboInventory_Boolean_1 = true;
         }
         for each(var _loc3_ in _loc2_.getBadges())
         {
            if(param1 == null || param1.indexOf(_loc3_.badgeId) == -1)
            {
               _loc4_.push(_loc3_.badgeId);
            }
         }
         return _loc4_;
      }
      
      public function hasFigureSetIdInInventory(param1:int) : Boolean
      {
         return UnknownVarFromHabboInventory_Vector_1.indexOf(param1) > -1;
      }
      
      public function hasBoundFigureSetFurniture(param1:String) : Boolean
      {
         return _boundFurnitureNames.indexOf(param1) > -1;
      }
      
      public function updatePurchasedFigureSetIds(param1:Vector.<int>, param2:Vector.<String>) : void
      {
         UnknownVarFromHabboInventory_Vector_1 = param1;
         _boundFurnitureNames = param2;
      }
      
      public function getLastActivatedEffect() : int
      {
         return effectsModel.lastActivatedEffect;
      }
      
      public function get avatarRenderer() : IAvatarRenderManager
      {
         return _avatarRenderer;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function recycleSelectedFurni() : void
      {
         var _loc2_:GroupItem = null;
         var _loc1_:FurnitureItem = null;
         var _loc3_:int = 0;
         var _loc4_:IRecycler = catalog.getRecycler();
         if(_loc4_ != null)
         {
            _loc2_ = furniModel.getSelectedItem();
            if(_loc2_ == null)
            {
               return;
            }
            _loc1_ = _loc2_.peek();
            if(_loc1_ == null)
            {
               return;
            }
            _loc3_ = _loc1_.isWallItem ? 20 : 10;
            _loc4_.placeObjectAtSlot(-1,_loc1_.id,_loc3_,_loc1_.type,String(_loc1_.extra),true);
         }
      }
   }
}

