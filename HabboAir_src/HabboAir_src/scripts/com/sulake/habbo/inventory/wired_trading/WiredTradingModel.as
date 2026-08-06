package com.sulake.habbo.inventory.wired_trading
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.trade.WiredTradeAddDeleteItemsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.trade.WiredTradeCancelMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.trade.WiredTradeConfirmMessageComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.TradeRequirement;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.inventory.trading.ITradingModel;
   import com.sulake.habbo.inventory.wired_trading.requirements.WiredTradeRequirementsModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.utils.getTimer;
   
   public class WiredTradingModel implements IInventoryModel, ITradingModel
   {
      public static var UnknownVarFromWiredTradingModel_Int_1:int = 0;
      
      public static const STATE_READY:uint = 0;
      
      public static const STATE_ADDING_ITEMS:uint = 1;
      
      public static const STATE_COUNTDOWN:uint = 2;
      
      public static const STATE_CONFIRMING:uint = 3;
      
      public static const STATE_CONFIRMED:uint = 4;
      
      private var _inventory:HabboInventory;
      
      private var UnknownVarFromWiredTradingModel_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _tradingView:WiredTradingView;
      
      private var _notifications:IHabboNotifications;
      
      private var _tradeRequirementsModel:WiredTradeRequirementsModel;
      
      private var _running:Boolean;
      
      private var _disposed:Boolean;
      
      private var _state:uint = 0;
      
      private var _ownUserItems:Map;
      
      private var _ownUserNumItems:int = 0;
      
      private var _ownUserNumCredits:int = 0;
      
      private var _wiredItems:Map;
      
      private var _wiredNumItems:int = 0;
      
      private var _wiredNumCredits:int = 0;
      
      private var _canAccept:Boolean;
      
      private var _extra:int;
      
      private var UnknownVarFromWiredTradingModel_Int_2:int;
      
      private var _tradeStartTime:int;
      
      public function WiredTradingModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IRoomEngine, param6:IHabboLocalizationManager, param7:IHabboSoundManagerFlash10, param8:IHabboNotifications)
      {
         super();
         _inventory = param1;
         _communication = param3;
         UnknownVarFromWiredTradingModel_IAssetLibraryCollection_1 = param4;
         _roomEngine = param5;
         _localization = param6;
         _soundManager = param7;
         _tradingView = new WiredTradingView(this,param2,param4,param5,param6,param7);
         _notifications = param8;
         _tradeRequirementsModel = new WiredTradeRequirementsModel(this);
      }
      
      public function onWiredTradeInitiate(param1:TradeRequirement, param2:Boolean, param3:Boolean, param4:int) : void
      {
         if(param3)
         {
            close(false,false,false);
         }
         _running = false;
         if(_state != 0)
         {
            clear();
            state = 0;
         }
         UnknownVarFromWiredTradingModel_Int_2 = param4;
         _tradeStartTime = getTimer();
         _tradingView.startSecondsLeftTimer();
         _tradeRequirementsModel.setRequirements(param1,param2);
         _inventory.toggleInventorySubPage("wired_trading");
         if(param3)
         {
            _tradeRequirementsModel.highlightRefresh();
         }
      }
      
      public function set state(param1:uint) : void
      {
         _state = param1;
         _tradingView.tradeStateUpdated();
      }
      
      private function clear() : void
      {
         _ownUserItems = new Map();
         _ownUserNumCredits = 0;
         _ownUserNumItems = 0;
         _wiredItems = new Map();
         _wiredNumCredits = 0;
         _wiredNumItems = 0;
         _canAccept = false;
         _extra = 0;
         _tradingView.updateAllUI();
      }
      
      public function get inventory() : HabboInventory
      {
         return _inventory;
      }
      
      public function get running() : Boolean
      {
         return _running;
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return _tradingView.getWindowContainer();
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
         if(!_running && param1 == "wired_trading")
         {
            if(_state != 0)
            {
               Logger.log("opened wired trade but wasn\'t ready");
            }
            initializeNewTrade();
         }
         else if(_running && param1 != "wired_trading" && _state != 0)
         {
            close(false,true);
         }
      }
      
      public function closingInventoryView() : void
      {
         if(_running)
         {
            close(true,true);
         }
      }
      
      public function initializeNewTrade() : void
      {
         _running = true;
         clear();
         state = 1;
         _inventory.onWiredTradeActiveChanged();
         _inventory.view.activate();
         _inventory.furniModel.updateView();
      }
      
      public function requestAddItemsToTrading(param1:Vector.<int>, param2:Boolean, param3:int, param4:int, param5:Boolean, param6:IStuffData) : void
      {
         if(_state == 1)
         {
            send(new WiredTradeAddDeleteItemsMessageComposer(false,param1));
         }
      }
      
      public function requestRemoveItemFromTrading(param1:int) : void
      {
         var _loc3_:GroupItem = null;
         var _loc2_:IFurnitureItem = null;
         if(_state == 1)
         {
            _loc3_ = ownUserItems.getWithIndex(param1);
            _loc2_ = _loc3_.peek();
            if(_loc2_)
            {
               _communication.connection.send(new WiredTradeAddDeleteItemsMessageComposer(true,Vector.<int>([_loc2_.id])));
            }
         }
      }
      
      public function requestAccept() : Boolean
      {
         if(_state == 1)
         {
            send(new WiredTradeConfirmMessageComposer(false));
            state = 2;
            return true;
         }
         return false;
      }
      
      public function confirmCountdownReady() : void
      {
         if(_state == 2)
         {
            state = 3;
         }
      }
      
      public function requestConfirm() : Boolean
      {
         if(_state == 3)
         {
            send(new WiredTradeConfirmMessageComposer(true));
            state = 4;
            return true;
         }
         return false;
      }
      
      public function get tradingView() : WiredTradingView
      {
         return _tradingView;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function close(param1:Boolean, param2:Boolean, param3:Boolean = true) : void
      {
         if(_running)
         {
            _tradingView.stopSecondsLeftTimer();
            if(_state != 0 && param2)
            {
               requestCancelTrading();
            }
            clear();
            state = 0;
            _running = false;
            _inventory.onWiredTradeActiveChanged();
            if(param1)
            {
               _inventory.toggleInventorySubPage("empty");
            }
            if(param3)
            {
               _inventory.furniModel.updateView();
            }
         }
      }
      
      public function requestCancelTrading() : void
      {
         _communication.connection.send(new WiredTradeCancelMessageComposer());
      }
      
      public function updateItemGroupMaps(param1:TradingItemListParser, param2:Map, param3:Map, param4:Boolean, param5:int) : void
      {
         if(_inventory == null || !_running)
         {
            return;
         }
         _ownUserItems = param2;
         _ownUserNumItems = param1.firstUserNumItems;
         _ownUserNumCredits = param1.firstUserNumCredits;
         _wiredItems = param3;
         _wiredNumItems = param1.secondUserNumItems;
         _wiredNumCredits = param1.secondUserNumCredits;
         _canAccept = param4;
         _extra = param5;
         _tradingView.updateAllUI();
         _tradeRequirementsModel.requirementsStateUpdated();
         var _loc6_:FurniModel = _inventory.furniModel;
         if(_loc6_ != null)
         {
            _loc6_.updateItemLocks();
         }
      }
      
      public function tradeIsCancelled(param1:int) : void
      {
         _inventory.wiredTradingModel.close(true,false);
         _tradingView.alertTradeCancelled(param1);
      }
      
      public function tradeIsCompleted() : void
      {
         _inventory.wiredTradingModel.close(true,false);
      }
      
      public function updateView() : void
      {
      }
      
      public function selectItemById(param1:String) : void
      {
         Logger.log("NOT SUPPORTED: TRADING VIEW SELECT BY ID");
      }
      
      public function getInventory() : HabboInventory
      {
         return _inventory;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _tradeRequirementsModel.dispose();
         _tradeRequirementsModel = null;
         _tradingView.dispose();
         _tradingView = null;
         _inventory = null;
         UnknownVarFromWiredTradingModel_IAssetLibraryCollection_1 = null;
         _roomEngine = null;
         _communication = null;
         _localization = null;
         _soundManager = null;
         _notifications = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getOwnItemIdsInTrade() : Array
      {
         var _loc3_:int = 0;
         var _loc5_:GroupItem = null;
         var _loc4_:int = 0;
         var _loc2_:IFurnitureItem = null;
         var _loc1_:Array = [];
         if(_ownUserItems == null || _ownUserItems.disposed)
         {
            return _loc1_;
         }
         _loc3_ = 0;
         while(_loc3_ < _ownUserItems.length)
         {
            _loc5_ = _ownUserItems.getWithIndex(_loc3_) as GroupItem;
            if(_loc5_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc5_.getTotalCount())
               {
                  _loc2_ = _loc5_.getAt(_loc4_);
                  if(_loc2_ != null)
                  {
                     _loc1_.push(_loc2_.ref);
                  }
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get tradeRequirementsModel() : WiredTradeRequirementsModel
      {
         return _tradeRequirementsModel;
      }
      
      public function isPayment() : Boolean
      {
         if(_tradeRequirementsModel.requirement == null)
         {
            return true;
         }
         return _tradeRequirementsModel.requirement.isPaymentOnly();
      }
      
      public function get paymentLayoutType() : String
      {
         if(_tradeRequirementsModel.requirement == null)
         {
            return null;
         }
         return _tradeRequirementsModel.requirement.layoutType;
      }
      
      public function get tradeTypeLocalization() : String
      {
         return _localization.getLocalization(isPayment() ? "inventory.wired_trading.payment" : "inventory.wired_trading.trade");
      }
      
      public function get ownUserItems() : Map
      {
         return _ownUserItems;
      }
      
      public function get ownUserNumItems() : int
      {
         return _ownUserNumItems;
      }
      
      public function get ownUserNumCredits() : int
      {
         return _ownUserNumCredits;
      }
      
      public function get wiredItems() : Map
      {
         return _wiredItems;
      }
      
      public function get wiredNumItems() : int
      {
         return _wiredNumItems;
      }
      
      public function get wiredNumCredits() : int
      {
         return _wiredNumCredits;
      }
      
      public function get canAccept() : Boolean
      {
         return _canAccept;
      }
      
      public function get extra() : int
      {
         return _extra;
      }
      
      public function get state() : uint
      {
         return _state;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get secondsLeft() : int
      {
         if(UnknownVarFromWiredTradingModel_Int_2 <= 0 || _tradeStartTime <= 0)
         {
            return -1;
         }
         var _loc1_:int = (getTimer() - _tradeStartTime) / 1000;
         var _loc2_:int = UnknownVarFromWiredTradingModel_Int_2 - _loc1_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
   }
}

