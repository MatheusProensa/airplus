package com.sulake.habbo.inventory.trading
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverFeeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverSetMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemsToTradeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.SilverFeeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.collectibles.AddNftToTradeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.collectibles.RemoveNftFromTradeComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeSilverSetParser;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.collectibles.CollectibleGroupedItem;
   import com.sulake.habbo.inventory.collectibles.CollectiblesModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.inventory.trading.namescam.TradingNameScamDetectionResult;
   import com.sulake.habbo.inventory.trading.namescam.TradingNameScamDetector;
   import com.sulake.habbo.inventory.trading.namescam.TradingNameScamWarningController;
   import com.sulake.habbo.inventory.trading.namescam.TradingNameScamWarningData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   
   public class TradingModel implements IInventoryModel, ITradingModel
   {
      public static const MAX_ITEMS_TO_TRADE:uint = 9;
      
      public static const TRADING_STATE_READY:uint = 0;
      
      public static const TRADING_STATE_RUNNING:uint = 1;
      
      public static const TRADING_STATE_COUNTDOWN:uint = 2;
      
      public static const TRADING_STATE_CONFIRMING:uint = 3;
      
      public static const TRADING_STATE_CONFIRMED:uint = 4;
      
      public static const TRADING_STATE_COMPLETED:uint = 5;
      
      public static const TRADING_STATE_CANCELLED:uint = 6;
      
      private static const SHOW_NAME_SCAM_WARNING_FOR_SELF_INITIATED_TRADES:Boolean = true;
      
      private var _inventory:HabboInventory;
      
      private var UnknownVarFromTradingModel_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var UnknownVarFromTradingModel_TradingView_1:TradingView;
      
      private var UnknownVarFromTradingModel_TradingNameScamWarningController_1:TradingNameScamWarningController;
      
      private var _notifications:IHabboNotifications;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromTradingModel_Boolean_1:Boolean = false;
      
      private var _state:uint = 0;
      
      private var _ownUserId:int = -1;
      
      private var _ownUserName:String = "";
      
      private var _ownUserItems:Map;
      
      private var _ownUserNumItems:int = 0;
      
      private var _ownUserNumCredits:int = 0;
      
      private var _ownUserNftItems:Map;
      
      private var _ownUserNumNftItems:int = 0;
      
      private var _ownUserAccepts:Boolean = false;
      
      private var _ownUserCanTrade:Boolean = false;
      
      private var _otherUserId:int = -1;
      
      private var _otherUserName:String = "";
      
      private var _otherUserItems:Map;
      
      private var _otherUserNumItems:int = 0;
      
      private var _otherUserNumCredits:int = 0;
      
      private var _otherUserNftItems:Map;
      
      private var _otherUserNumNftItems:int = 0;
      
      private var _otherUserAccepts:Boolean = false;
      
      private var _otherUserCanTrade:Boolean = false;
      
      private var _requiredSilverFee:int = 0;
      
      private var _playerSilver:int = 0;
      
      private var _otherPlayerSilver:int = 0;
      
      public function TradingModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IRoomEngine, param6:IHabboLocalizationManager, param7:IHabboSoundManagerFlash10, param8:IHabboNotifications)
      {
         super();
         _inventory = param1;
         _communication = param3;
         UnknownVarFromTradingModel_IAssetLibraryCollection_1 = param4;
         _roomEngine = param5;
         _localization = param6;
         _soundManager = param7;
         UnknownVarFromTradingModel_TradingView_1 = new TradingView(this,param2,param4,param5,param6,param7);
         UnknownVarFromTradingModel_TradingNameScamWarningController_1 = new TradingNameScamWarningController(param2,param4,param6,param3);
         _notifications = param8;
      }
      
      public static function getGuildFurniType(param1:int, param2:IStuffData) : String
      {
         var _loc5_:int = 0;
         var _loc4_:String = param1.toString();
         var _loc3_:StringArrayStuffData = param2 as StringArrayStuffData;
         if(!_loc3_)
         {
            return _loc4_;
         }
         _loc5_ = 1;
         while(_loc5_ < 5)
         {
            _loc4_ += "," + _loc3_.getValue(_loc5_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function get running() : Boolean
      {
         return _state != 0;
      }
      
      public function get state() : uint
      {
         return _state;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get ownUserId() : int
      {
         return _ownUserId;
      }
      
      public function get ownUserName() : String
      {
         return _ownUserName;
      }
      
      public function get ownUserItems() : Map
      {
         return _ownUserItems;
      }
      
      public function get ownUserAccepts() : Boolean
      {
         return _ownUserAccepts;
      }
      
      public function get ownUserCanTrade() : Boolean
      {
         return _ownUserCanTrade;
      }
      
      public function get otherUserId() : int
      {
         return _otherUserId;
      }
      
      public function get otherUserName() : String
      {
         return _otherUserName;
      }
      
      public function get otherUserItems() : Map
      {
         return _otherUserItems;
      }
      
      public function get otherUserAccepts() : Boolean
      {
         return _otherUserAccepts;
      }
      
      public function get otherUserCanTrade() : Boolean
      {
         return _otherUserCanTrade;
      }
      
      public function get ownUserNftItems() : Map
      {
         return _ownUserNftItems;
      }
      
      public function get ownUserNumNftItems() : int
      {
         return _ownUserNumNftItems;
      }
      
      public function get otherUserNftItems() : Map
      {
         return _otherUserNftItems;
      }
      
      public function get otherUserNumNftItems() : int
      {
         return _otherUserNumNftItems;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromTradingModel_TradingView_1 && !UnknownVarFromTradingModel_TradingView_1.disposed)
            {
               UnknownVarFromTradingModel_TradingView_1.dispose();
               UnknownVarFromTradingModel_TradingView_1 = null;
            }
            if(UnknownVarFromTradingModel_TradingNameScamWarningController_1 != null)
            {
               UnknownVarFromTradingModel_TradingNameScamWarningController_1.dispose();
               UnknownVarFromTradingModel_TradingNameScamWarningController_1 = null;
            }
            _inventory = null;
            _communication = null;
            UnknownVarFromTradingModel_IAssetLibraryCollection_1 = null;
            _roomEngine = null;
            _localization = null;
            _disposed = true;
         }
      }
      
      public function startTrading(param1:int, param2:String, param3:Boolean, param4:int, param5:String, param6:Boolean, param7:Boolean) : void
      {
         _ownUserId = param1;
         _ownUserName = param2;
         _ownUserItems = new Map();
         _ownUserNftItems = new Map();
         _ownUserAccepts = false;
         _ownUserCanTrade = param3;
         _otherUserId = param4;
         _otherUserName = param5;
         _otherUserItems = new Map();
         _otherUserNftItems = new Map();
         _otherUserAccepts = false;
         _otherUserCanTrade = param6;
         _requiredSilverFee = 0;
         _playerSilver = 0;
         _otherPlayerSilver = 0;
         _ownUserNumNftItems = 0;
         _ownUserNumItems = 0;
         _ownUserNumCredits = 0;
         _otherUserNumNftItems = 0;
         _otherUserNumItems = 0;
         _otherUserNumCredits = 0;
         UnknownVarFromTradingModel_TradingNameScamWarningController_1.hide();
         var _loc8_:TradingNameScamDetectionResult = detectNameScam(param7);
         var _loc9_:TradingNameScamWarningData = null;
         if(_loc8_.nameScamDetected)
         {
            _loc9_ = createNameScamWarningData(_loc8_);
         }
         UnknownVarFromTradingModel_Boolean_1 = true;
         state = 1;
         UnknownVarFromTradingModel_TradingView_1.setup(param1,param3,param4,param6);
         UnknownVarFromTradingModel_TradingView_1.updateItemList(_ownUserId);
         UnknownVarFromTradingModel_TradingView_1.updateItemList(_otherUserId);
         UnknownVarFromTradingModel_TradingView_1.updateUserInterface();
         UnknownVarFromTradingModel_TradingView_1.clearItemLists();
         _inventory.toggleInventoryPage("furni");
         _inventory.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_TRADING"));
         if(_loc9_ != null)
         {
            UnknownVarFromTradingModel_TradingNameScamWarningController_1.show(_loc9_);
         }
      }
      
      public function close() : void
      {
         if(UnknownVarFromTradingModel_Boolean_1)
         {
            if(_state != 0 && _state != 5)
            {
               requestCancelTrading();
               state = 6;
            }
            state = 0;
            _inventory.toggleInventorySubPage("empty");
            UnknownVarFromTradingModel_Boolean_1 = false;
         }
         UnknownVarFromTradingModel_TradingNameScamWarningController_1.hide();
         UnknownVarFromTradingModel_TradingView_1.setMinimized(false);
      }
      
      private function detectNameScam(param1:Boolean) : TradingNameScamDetectionResult
      {
         if(!param1 && false)
         {
            return TradingNameScamDetectionResult.NO_MATCHES;
         }
         return TradingNameScamDetector.detect(_otherUserName,getRoomUserNamesForNameScamDetection(),getFriendNamesForNameScamDetection());
      }
      
      private function createNameScamWarningData(param1:TradingNameScamDetectionResult) : TradingNameScamWarningData
      {
         var _loc3_:IUserData = null;
         var _loc2_:String = "";
         var _loc4_:IRoomSession = _inventory.roomSession;
         if(_loc4_ != null && _loc4_.userDataManager != null)
         {
            _loc3_ = _loc4_.userDataManager.getUserData(_otherUserId);
            if(_loc3_ != null && _loc3_.figure != null)
            {
               _loc2_ = _loc3_.figure;
            }
         }
         return new TradingNameScamWarningData(_otherUserId,_otherUserName,_loc2_,param1.similarInRoom,param1.similarInFriends);
      }
      
      private function getRoomUserNamesForNameScamDetection() : Array
      {
         var _loc2_:IUserData = null;
         var _loc5_:IRoomSession = _inventory.roomSession;
         if(_loc5_ == null || _loc5_.userDataManager == null)
         {
            return [];
         }
         var _loc1_:Array = [];
         var _loc3_:Array = _loc5_.userDataManager.getAllUserIds();
         for each(var _loc4_ in _loc3_)
         {
            if(!(_loc4_ == _ownUserId || _loc4_ == _otherUserId))
            {
               _loc2_ = _loc5_.userDataManager.getUserData(_loc4_);
               if(!(_loc2_ == null || _loc2_.name == null || _loc2_.name.length == 0))
               {
                  _loc1_.push(_loc2_.name);
               }
            }
         }
         return _loc1_;
      }
      
      private function getFriendNamesForNameScamDetection() : Array
      {
         var _loc1_:IHabboFriendList = _inventory.friendList;
         if(_loc1_ == null)
         {
            return [];
         }
         var _loc2_:Array = _loc1_.getFriendNames();
         return _loc2_ ?? [];
      }
      
      public function isConfirmingWeb3Trade() : Boolean
      {
         return isWeb3Trade() && _state == 4;
      }
      
      public function isWeb3Trade() : Boolean
      {
         return requiredSilverFee > 0 || (otherUserNftItems.length > 0 || ownUserNftItems.length > 0);
      }
      
      public function categorySwitch(param1:String) : void
      {
         UnknownVarFromTradingModel_TradingView_1.setMinimized(param1 != "furni" && param1 != "collectibles");
         _inventory.updateSubView();
      }
      
      public function set state(param1:uint) : void
      {
         Logger.log("OLD STATE: " + _state + " NEW STATE: " + param1 + " OWN: " + _ownUserAccepts + " OTHER: " + _otherUserAccepts);
         var _loc2_:Boolean = false;
         if(_state == param1)
         {
            return;
         }
         switch(int(_state))
         {
            case 0:
               if(param1 == 1 || param1 == 5)
               {
                  _state = param1;
                  _inventory.onTradeActiveChanged();
                  _loc2_ = true;
               }
               break;
            case 1:
               if(param1 == 2)
               {
                  _state = param1;
                  _loc2_ = true;
                  startConfirmCountdown();
               }
               else if(param1 == 6)
               {
                  _state = param1;
                  UnknownVarFromTradingModel_TradingView_1.setMinimized(false);
                  _loc2_ = true;
               }
               break;
            case 2:
               if(param1 == 3)
               {
                  _state = param1;
                  _loc2_ = true;
               }
               else if(param1 == 6)
               {
                  _state = param1;
                  UnknownVarFromTradingModel_TradingView_1.setMinimized(false);
                  _loc2_ = true;
               }
               else if(param1 == 1)
               {
                  _state = param1;
                  _loc2_ = true;
                  cancelConfirmCountdown();
               }
               break;
            case 3:
               if(param1 == 4)
               {
                  _state = param1;
                  _loc2_ = true;
               }
               else if(param1 == 5)
               {
                  _state = param1;
                  _loc2_ = true;
                  close();
               }
               else if(param1 == 6)
               {
                  _state = param1;
                  UnknownVarFromTradingModel_TradingView_1.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               break;
            case 4:
               if(param1 == 5)
               {
                  _state = param1;
                  UnknownVarFromTradingModel_TradingView_1.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               else if(param1 == 6)
               {
                  _state = param1;
                  UnknownVarFromTradingModel_TradingView_1.setMinimized(false);
                  _loc2_ = true;
                  close();
               }
               break;
            case 5:
               if(param1 == 0)
               {
                  _state = param1;
                  _inventory.onTradeActiveChanged(true);
                  _loc2_ = true;
               }
               break;
            case 6:
               if(param1 == 0)
               {
                  _state = param1;
                  _inventory.onTradeActiveChanged();
                  _loc2_ = true;
               }
               else if(param1 == 1)
               {
                  _state = param1;
                  _loc2_ = true;
               }
               break;
            default:
               throw new Error("Unknown trading progress state: \"" + _state + "\"");
         }
         if(_loc2_)
         {
            UnknownVarFromTradingModel_TradingView_1.updateUserInterface();
            return;
         }
         throw new Error("Error assigning trading process status! States does not match: (from) " + _state + " (to) " + param1);
      }
      
      public function getFurniInventoryModel() : FurniModel
      {
         return _inventory.furniModel;
      }
      
      public function getInventory() : HabboInventory
      {
         return _inventory;
      }
      
      public function updateItemGroupMaps(param1:TradingItemListEvent, param2:Map, param3:Map) : void
      {
         if(_inventory == null)
         {
            return;
         }
         if(_ownUserItems != null)
         {
            _ownUserItems.dispose();
         }
         if(_otherUserItems != null)
         {
            _otherUserItems.dispose();
         }
         if(param1.firstUserID == _ownUserId)
         {
            _ownUserItems = param2;
            _ownUserNumItems = param1.firstUserNumItems;
            _ownUserNumCredits = param1.firstUserNumCredits;
            _otherUserItems = param3;
            _otherUserNumItems = param1.secondUserNumItems;
            _otherUserNumCredits = param1.secondUserNumCredits;
         }
         else
         {
            _ownUserItems = param3;
            _ownUserNumItems = param1.secondUserNumItems;
            _ownUserNumCredits = param1.secondUserNumCredits;
            _otherUserItems = param2;
            _otherUserNumItems = param1.firstUserNumItems;
            _otherUserNumCredits = param1.firstUserNumCredits;
         }
         _ownUserAccepts = false;
         _otherUserAccepts = false;
         UnknownVarFromTradingModel_TradingView_1.updateItemList(_ownUserId);
         UnknownVarFromTradingModel_TradingView_1.updateItemList(_otherUserId);
         UnknownVarFromTradingModel_TradingView_1.updateUserInterface();
         var _loc4_:FurniModel = _inventory.furniModel;
         if(_loc4_ != null)
         {
            _loc4_.updateItemLocks();
         }
      }
      
      public function updateNftItems(param1:Map, param2:Map, param3:Number, param4:Number) : *
      {
         if(_inventory == null)
         {
            return;
         }
         if(_ownUserNftItems != null)
         {
            _ownUserNftItems.dispose();
         }
         if(_otherUserNftItems != null)
         {
            _otherUserNftItems.dispose();
         }
         _ownUserAccepts = false;
         _otherUserAccepts = false;
         _ownUserNftItems = param1;
         _otherUserNftItems = param2;
         _ownUserNumNftItems = param3;
         _otherUserNumNftItems = param4;
         UnknownVarFromTradingModel_TradingView_1.updateItemList(_ownUserId);
         UnknownVarFromTradingModel_TradingView_1.updateItemList(_otherUserId);
         UnknownVarFromTradingModel_TradingView_1.updateUserInterface();
         var _loc5_:CollectiblesModel = _inventory.collectiblesModel;
         if(_loc5_ != null)
         {
            _loc5_.updateItemLocks();
         }
      }
      
      public function getOwnItemIdsInTrade() : Array
      {
         var _loc5_:GroupItem = null;
         var _loc2_:IFurnitureItem = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
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
      
      public function get ownUserNumItems() : int
      {
         return _ownUserNumItems;
      }
      
      public function get ownHasAnyOffer() : Boolean
      {
         return _ownUserItems.length > 0 || _ownUserNftItems.length > 0;
      }
      
      public function get ownUserNumItemsTotal() : int
      {
         return _ownUserNumItems + _ownUserNumNftItems;
      }
      
      public function get ownUserNumCredits() : int
      {
         return _ownUserNumCredits;
      }
      
      public function get otherUserNumItems() : int
      {
         return _otherUserNumItems;
      }
      
      public function get otherHasAnyOffer() : Boolean
      {
         return _otherUserItems.length > 0 || _otherUserNftItems.length > 0;
      }
      
      public function get otherUserNumItemsTotal() : int
      {
         return _otherUserNumItems + _otherUserNumNftItems;
      }
      
      public function get otherUserNumCredits() : int
      {
         return _otherUserNumCredits;
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return UnknownVarFromTradingModel_TradingView_1.getWindowContainer();
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
         if(UnknownVarFromTradingModel_Boolean_1)
         {
            if(_state != 0)
            {
               requestCancelTrading();
            }
         }
      }
      
      public function closingInventoryView() : void
      {
         if(UnknownVarFromTradingModel_Boolean_1)
         {
            if(isConfirmingWeb3Trade())
            {
               _notifications.addItem(_localization.getLocalization("tradingdialog.minimize_web3"),"info","icon_curator_stamp_large_png");
            }
            else
            {
               close();
            }
         }
      }
      
      public function startConfirmCountdown() : void
      {
         UnknownVarFromTradingModel_TradingView_1.startConfirmCountdown();
      }
      
      public function cancelConfirmCountdown() : void
      {
         UnknownVarFromTradingModel_TradingView_1.cancelConfirmCountdown();
      }
      
      public function confirmCountdownReady() : void
      {
         if(_state == 2)
         {
            state = 3;
         }
      }
      
      public function handleMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:TradingCloseEvent = null;
         var _loc4_:TradeSilverSetMessageEvent = null;
         var _loc3_:TradeSilverSetParser = null;
         var _loc5_:TradeSilverFeeMessageEvent = null;
         if(param1 is TradeOpenFailedEvent)
         {
            Logger.log("TRADING::TradingOpenFailedEvent");
            if(TradeOpenFailedEvent(param1).getParser().reason == 7 || TradeOpenFailedEvent(param1).getParser().reason == 8)
            {
               UnknownVarFromTradingModel_TradingView_1.alertPopup(2);
            }
            else
            {
               UnknownVarFromTradingModel_TradingView_1.alertTradeOpenFailed(TradeOpenFailedEvent(param1));
            }
         }
         else if(param1 is TradingAcceptEvent)
         {
            Logger.log("TRADING::TradingAcceptEvent");
            if(TradingAcceptEvent(param1).userID == _ownUserId)
            {
               _ownUserAccepts = TradingAcceptEvent(param1).userAccepts != 0;
            }
            else
            {
               _otherUserAccepts = TradingAcceptEvent(param1).userAccepts != 0;
            }
            UnknownVarFromTradingModel_TradingView_1.updateUserInterface();
         }
         else if(param1 is TradingConfirmationEvent)
         {
            Logger.log("TRADING::TradingConfirmationEvent");
            state = 2;
         }
         else if(param1 is TradingCompletedEvent)
         {
            Logger.log("TRADING::TradingCompletedEvent");
            if(isConfirmingWeb3Trade())
            {
               _notifications.addItem(_localization.getLocalization("tradingdialog.done_messsage"),"info","icon_curator_stamp_large_png");
            }
            state = 5;
         }
         else if(param1 is TradingCloseEvent)
         {
            Logger.log("TRADING::TradingCloseEvent");
            if(!UnknownVarFromTradingModel_Boolean_1)
            {
               Logger.log("Received TradingCloseEvent, but trading already stopped!!!");
               return;
            }
            _loc2_ = param1 as TradingCloseEvent;
            if(_loc2_.getParser().reason == 1)
            {
               if(_inventory.getBoolean("trading.commiterror.enabled"))
               {
                  UnknownVarFromTradingModel_TradingView_1.windowManager.simpleAlert("${inventory.trading.notification.title}","${inventory.trading.notification.commiterror.caption}","${inventory.trading.notification.commiterror.info}");
               }
            }
            else if(_loc2_.getParser().userID != _ownUserId)
            {
               UnknownVarFromTradingModel_TradingView_1.alertPopup(1);
            }
            close();
         }
         else if(param1 is TradingNotOpenEvent)
         {
            Logger.log("TRADING::TradingNotOpenEvent");
         }
         else if(param1 is TradingOtherNotAllowedEvent)
         {
            UnknownVarFromTradingModel_TradingView_1.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
         }
         else if(param1 is TradingYouAreNotAllowedEvent)
         {
            UnknownVarFromTradingModel_TradingView_1.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
         }
         else if(param1 is TradeSilverSetMessageEvent)
         {
            _loc4_ = param1 as TradeSilverSetMessageEvent;
            _loc3_ = _loc4_.getParser();
            _playerSilver = _loc3_.playerSilver;
            _otherPlayerSilver = _loc3_.otherPlayerSilver;
            UnknownVarFromTradingModel_TradingView_1.updateUserInterface();
         }
         else if(param1 is TradeSilverFeeMessageEvent)
         {
            _loc5_ = param1 as TradeSilverFeeMessageEvent;
            _requiredSilverFee = _loc5_.getParser().silverFee;
            UnknownVarFromTradingModel_TradingView_1.updateUserInterface();
         }
         else
         {
            Logger.log("TRADING/Unknown message event: " + param1);
         }
      }
      
      public function tradeFeeReached() : Boolean
      {
         return _playerSilver + _otherPlayerSilver >= _requiredSilverFee;
      }
      
      public function requestFurniViewOpen() : void
      {
         _inventory.toggleInventoryPage("furni");
      }
      
      public function requestOpenTrading(param1:int) : void
      {
         _communication.connection.send(new OpenTradingComposer(param1));
      }
      
      public function requestAddItemsToTrading(param1:Vector.<int>, param2:Boolean, param3:int, param4:int, param5:Boolean, param6:IStuffData) : void
      {
         var _loc8_:* = undefined;
         if(!param5 && param1.length > 0)
         {
            _communication.connection.send(new AddItemToTradeComposer(param1.pop()));
         }
         else
         {
            _loc8_ = new Vector.<int>();
            for each(var _loc7_ in param1)
            {
               if(canAddItemToTrade(param2,param3,param4,param5,param6))
               {
                  _loc8_.push(_loc7_);
               }
            }
            if(_loc8_.length > 0)
            {
               if(_loc8_.length == 1)
               {
                  _communication.connection.send(new AddItemToTradeComposer(_loc8_.pop()));
               }
               else
               {
                  _communication.connection.send(new AddItemsToTradeComposer(_loc8_));
               }
            }
         }
      }
      
      public function requestAddNftsToTrading(param1:Vector.<Number>) : void
      {
         var _loc3_:Vector.<int> = new Vector.<int>();
         for each(var _loc2_ in param1)
         {
            _loc3_.push(int(_loc2_));
         }
         _communication.connection.send(new AddNftToTradeComposer(_loc3_));
      }
      
      public function canAddItemToTrade(param1:Boolean, param2:int, param3:int, param4:Boolean, param5:IStuffData) : Boolean
      {
         var _loc6_:String = null;
         if(_ownUserAccepts)
         {
            return false;
         }
         if(_ownUserItems == null)
         {
            return false;
         }
         if(_ownUserItems.length < 9)
         {
            return true;
         }
         if(!param4)
         {
            return false;
         }
         _loc6_ = String(param2);
         if(param3 == 6)
         {
            _loc6_ = String(param2) + "poster" + param5.getLegacyString();
         }
         else if(param3 == 17)
         {
            _loc6_ = getGuildFurniType(param2,param5);
         }
         else
         {
            _loc6_ = (param1 ? "I" : "S") + _loc6_;
         }
         return _ownUserItems.getValue(_loc6_) != null;
      }
      
      public function requestRemoveItemFromTrading(param1:int) : void
      {
         var _loc5_:CollectibleGroupedItem = null;
         var _loc4_:* = undefined;
         var _loc3_:IFurnitureItem = null;
         if(_ownUserAccepts)
         {
            return;
         }
         var _loc2_:int = int(ownUserItems.length);
         if(param1 >= _loc2_)
         {
            _loc5_ = ownUserNftItems.getWithIndex(param1 - _loc2_);
            if(_loc5_ != null)
            {
               _loc4_ = _loc5_.pop(1);
               if(_loc4_ != null && _loc4_.length == 1)
               {
                  _communication.connection.send(new RemoveNftFromTradeComposer(_loc4_[0]));
               }
            }
            return;
         }
         var _loc6_:GroupItem = ownUserItems.getWithIndex(param1);
         if(_loc6_)
         {
            _loc3_ = _loc6_.peek();
            if(_loc3_)
            {
               _communication.connection.send(new RemoveItemFromTradeComposer(_loc3_.id));
            }
         }
      }
      
      public function requestAcceptTrading() : void
      {
         _communication.connection.send(new AcceptTradingComposer());
      }
      
      public function requestUnacceptTrading() : void
      {
         _communication.connection.send(new UnacceptTradingComposer());
      }
      
      public function requestConfirmAcceptTrading() : void
      {
         state = 4;
         _communication.connection.send(new ConfirmAcceptTradingComposer());
      }
      
      public function requestConfirmDeclineTrading() : void
      {
         _communication.connection.send(new ConfirmDeclineTradingComposer());
      }
      
      public function requestCancelTrading() : void
      {
         if(!isConfirmingWeb3Trade())
         {
            _communication.connection.send(new CloseTradingComposer());
         }
      }
      
      public function addSilverFee(param1:Boolean) : void
      {
         _communication.connection.send(new SilverFeeMessageComposer(param1));
      }
      
      public function isCreditFurniPresent() : Boolean
      {
         return _ownUserNumCredits > 0 || _otherUserNumCredits > 0;
      }
      
      private function get citizenshipTalentTrackEnabled() : Boolean
      {
         return _inventory.getBoolean("talent.track.citizenship.enabled");
      }
      
      public function updateView() : void
      {
      }
      
      public function selectItemById(param1:String) : void
      {
         Logger.log("NOT SUPPORTED: TRADING VIEW SELECT BY ID");
      }
      
      public function get requiredSilverFee() : int
      {
         return _requiredSilverFee;
      }
      
      public function get playerSilver() : int
      {
         return _playerSilver;
      }
      
      public function get otherPlayerSilver() : int
      {
         return _otherPlayerSilver;
      }
   }
}

