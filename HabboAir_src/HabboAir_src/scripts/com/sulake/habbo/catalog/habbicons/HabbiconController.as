package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomUseHabbiconEvent;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.BuyHabbiconCollectionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.BuyHabbiconMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.ClaimHabbiconMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.FavoriteHabbiconMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.GetHabbiconInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.GetHabbiconShopDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.UnfavoriteHabbiconMessageComposer;
   import com.sulake.habbo.communication.messages.parser.habbicons.HabbiconInfoEvent;
   import com.sulake.habbo.communication.messages.parser.habbicons.HabbiconShopDataEvent;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons1;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons2;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons3;
   import com.sulake.habbo.communication.messages.parser.habbicons.UserHabbiconStatusChangedEvent;
   import com.sulake.habbo.communication.messages.parser.habbicons.UserHabbiconsEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class HabbiconController extends Component implements ILinkEventTracker, IHabbiconController
   {
      private static const RECENT_HABBICON_LIMIT:int = 10;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _configurationManager:IHabboConfigurationManager;
      
      private var _inventory:IHabboInventory;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _notifications:IHabboNotifications;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromHabbiconController_HabbiconView_1:HabbiconView;
      
      private var UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1:HabbiconPurchaseConfirmationView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromHabbiconController_EventDispatcher_1:EventDispatcher;
      
      private var UnknownVarFromHabbiconController_Dictionary_1:Dictionary;
      
      private var UnknownVarFromHabbiconController_Array_1:Array;
      
      private var UnknownVarFromHabbiconController_Dictionary_2:Dictionary;
      
      private var UnknownVarFromHabbiconController_Dictionary_3:Dictionary;
      
      private var UnknownVarFromHabbiconController_Vector_1:Vector.<UnknownHabboCommunicationMessagesParserHabbicons3>;
      
      private var _hasLoadedOwnedHabbicons:Boolean;
      
      private var _hasLoadedShopData:Boolean;
      
      private var UnknownVarFromHabbiconController_Boolean_1:Boolean;
      
      private var UnknownVarFromHabbiconController_Boolean_2:Boolean;
      
      private var _pendingPurchaseRefresh:Boolean;
      
      public function HabbiconController(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboConfigurationManager(),function(param1:IHabboConfigurationManager):void
         {
            _configurationManager = param1;
         },true),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         },true),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         },false),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         UnknownVarFromHabbiconController_EventDispatcher_1 = new EventDispatcher();
         UnknownVarFromHabbiconController_Dictionary_1 = new Dictionary();
         UnknownVarFromHabbiconController_Array_1 = [];
         UnknownVarFromHabbiconController_Dictionary_2 = new Dictionary();
         UnknownVarFromHabbiconController_Dictionary_3 = new Dictionary();
         UnknownVarFromHabbiconController_Vector_1 = new Vector.<UnknownHabboCommunicationMessagesParserHabbicons3>(0);
         if(!habbiconsEnabled())
         {
            return;
         }
         context.addLinkEventTracker(this);
         addMessageEvent(new UserHabbiconsEvent(onUserHabbicons));
         addMessageEvent(new UserHabbiconStatusChangedEvent(onUserHabbiconStatusChanged));
         addMessageEvent(new HabbiconShopDataEvent(onHabbiconShopData));
         addMessageEvent(new HabbiconInfoEvent(onHabbiconInfo));
         addMessageEvent(new RoomUseHabbiconEvent(onRoomUseHabbicon));
         addMessageEvent(new PurchaseOKMessageEvent(onPurchaseOk));
         addMessageEvent(new PurchaseErrorMessageEvent(onPurchaseFailed));
         addMessageEvent(new PurchaseNotAllowedMessageEvent(onPurchaseFailed));
         HabbiconAssetManager.configure(_configurationManager);
         HabbiconAssetManager.addEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
         HabbiconAssetManager.preload();
      }
      
      public function get linkPattern() : String
      {
         return "habbicons/";
      }
      
      public function get configuration() : IHabboConfigurationManager
      {
         return _configurationManager;
      }
      
      public function linkReceived(param1:String) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            openHabbiconHub();
         }
      }
      
      public function openHabbiconHub() : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         resetUnseenHabbicons();
         if(!UnknownVarFromHabbiconController_HabbiconView_1 || UnknownVarFromHabbiconController_HabbiconView_1.disposed)
         {
            UnknownVarFromHabbiconController_HabbiconView_1 = new HabbiconView(this,_windowManager);
         }
         UnknownVarFromHabbiconController_HabbiconView_1.showWindow();
      }
      
      public function get hasLoadedOwnedHabbicons() : Boolean
      {
         return _hasLoadedOwnedHabbicons;
      }
      
      public function get hasLoadedShopData() : Boolean
      {
         return _hasLoadedShopData;
      }
      
      public function get ownedHabbicons() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in UnknownVarFromHabbiconController_Dictionary_1)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get recentHabbiconIds() : Array
      {
         return UnknownVarFromHabbiconController_Array_1.concat();
      }
      
      public function get shopCollections() : Vector.<UnknownHabboCommunicationMessagesParserHabbicons3>
      {
         return UnknownVarFromHabbiconController_Vector_1.concat();
      }
      
      public function get unseenHabbiconCount() : int
      {
         if(_inventory == null || _inventory.unseenItemTracker == null)
         {
            return 0;
         }
         return _inventory.unseenItemTracker.getCount(8);
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromHabbiconController_EventDispatcher_1.addEventListener(param1,param2);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromHabbiconController_EventDispatcher_1.removeEventListener(param1,param2);
      }
      
      public function getShopData(param1:Boolean = false) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         if(_hasLoadedShopData && !param1)
         {
            UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_shop_data_updated"));
            return;
         }
         if(UnknownVarFromHabbiconController_Boolean_2)
         {
            return;
         }
         UnknownVarFromHabbiconController_Boolean_2 = send(new GetHabbiconShopDataMessageComposer());
      }
      
      public function getHabbiconInfo(param1:int) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         send(new GetHabbiconInfoMessageComposer(param1));
      }
      
      public function noteHabbiconUsed(param1:int) : void
      {
         if(!habbiconsEnabled() || param1 <= 0)
         {
            return;
         }
         addRecentHabbiconId(param1);
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_recent_habbicons_updated",param1));
      }
      
      public function isUnseenHabbicon(param1:int) : Boolean
      {
         return _inventory != null && _inventory.unseenItemTracker != null && _inventory.unseenItemTracker.isUnseen(8,param1);
      }
      
      public function removeUnseenHabbicon(param1:int) : void
      {
         if(_inventory == null || _inventory.unseenItemTracker == null)
         {
            return;
         }
         _inventory.unseenItemTracker.removeUnseen(8,param1);
         _inventory.unseenItemTracker.resetCategoryIfEmpty(8);
      }
      
      public function resetUnseenHabbicons() : void
      {
         if(_inventory == null || _inventory.unseenItemTracker == null)
         {
            return;
         }
         _inventory.unseenItemTracker.resetCategory(8);
      }
      
      public function buyHabbicon(param1:int) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         _pendingPurchaseRefresh = true;
         send(new BuyHabbiconMessageComposer(param1));
      }
      
      public function buyHabbiconCollection(param1:int) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         _pendingPurchaseRefresh = true;
         send(new BuyHabbiconCollectionMessageComposer(param1));
      }
      
      public function openHabbiconPurchaseConfirmation(param1:HabbiconEntryModel) : void
      {
         if(!habbiconsEnabled() || param1 == null || !param1.purchasable)
         {
            return;
         }
         closeHabbiconPurchaseConfirmation();
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1 = new HabbiconPurchaseConfirmationView(this,_windowManager);
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1.initializeForHabbicon(param1);
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1.show();
      }
      
      public function openHabbiconSetPurchaseConfirmation(param1:HabbiconSetModel) : void
      {
         if(!habbiconsEnabled() || param1 == null || !param1.canBuy)
         {
            return;
         }
         closeHabbiconPurchaseConfirmation();
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1 = new HabbiconPurchaseConfirmationView(this,_windowManager);
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1.initializeForSet(param1);
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1.show();
      }
      
      public function closeHabbiconPurchaseConfirmation() : void
      {
         if(UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1 == null)
         {
            return;
         }
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1.dispose();
         UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1 = null;
      }
      
      public function claimHabbicon(param1:int) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         _pendingPurchaseRefresh = true;
         send(new ClaimHabbiconMessageComposer(param1));
      }
      
      public function favoriteHabbicon(param1:int) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         send(new FavoriteHabbiconMessageComposer(param1));
      }
      
      public function unfavoriteHabbicon(param1:int) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         send(new UnfavoriteHabbiconMessageComposer(param1));
      }
      
      public function tryGetOwnedHabbicon(param1:int) : UnknownHabboCommunicationMessagesParserHabbicons1
      {
         return UnknownVarFromHabbiconController_Dictionary_1[param1] as UnknownHabboCommunicationMessagesParserHabbicons1;
      }
      
      public function tryGetShopItem(param1:int) : UnknownHabboCommunicationMessagesParserHabbicons2
      {
         return UnknownVarFromHabbiconController_Dictionary_3[param1] as UnknownHabboCommunicationMessagesParserHabbicons2;
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(_communicationManager == null)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(_communicationManager == null)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      private function send(param1:*) : Boolean
      {
         if(_communicationManager == null || _communicationManager.connection == null)
         {
            return false;
         }
         _communicationManager.connection.send(param1);
         return true;
      }
      
      private function onUserHabbicons(param1:UserHabbiconsEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:UnknownHabboCommunicationMessagesParserHabbicons1 = null;
         var _loc8_:UnknownHabboCommunicationMessagesParserHabbicons1 = null;
         var _loc3_:* = param1.getParser();
         var _loc2_:Array = _loc3_.habbicons;
         var _loc5_:Boolean = _hasLoadedOwnedHabbicons;
         var _loc7_:Dictionary = UnknownVarFromHabbiconController_Dictionary_1;
         UnknownVarFromHabbiconController_Dictionary_1 = new Dictionary();
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc6_] as UnknownHabboCommunicationMessagesParserHabbicons1;
            if(_loc4_ != null)
            {
               _loc8_ = _loc7_[_loc4_.habbiconId] as UnknownHabboCommunicationMessagesParserHabbicons1;
               UnknownVarFromHabbiconController_Dictionary_1[_loc4_.habbiconId] = _loc4_;
               if(_loc5_ && isStoredUserState(_loc4_.habbiconState) && (_loc8_ == null || isClaimedRewardTransition(_loc8_.habbiconState,_loc4_.habbiconState)))
               {
                  handleNewOwnedHabbicon(_loc4_.habbiconId);
               }
            }
            _loc6_++;
         }
         setRecentHabbiconIds(_loc3_.recentHabbiconIds);
         _hasLoadedOwnedHabbicons = true;
         UnknownVarFromHabbiconController_Boolean_1 = false;
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_owned_habbicons_updated"));
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_shop_data_updated"));
      }
      
      private function onUserHabbiconStatusChanged(param1:UserHabbiconStatusChangedEvent) : void
      {
         var _loc4_:UnknownHabboCommunicationMessagesParserHabbicons1 = null;
         var _loc3_:* = param1.getParser();
         var _loc6_:int = _loc3_.habbiconState;
         var _loc2_:int = _loc3_.habbiconId;
         var _loc5_:int = 0;
         if(isStoredUserState(_loc6_))
         {
            _loc4_ = UnknownVarFromHabbiconController_Dictionary_1[_loc2_] as UnknownHabboCommunicationMessagesParserHabbicons1;
            if(_loc4_ == null)
            {
               _loc4_ = new UnknownHabboCommunicationMessagesParserHabbicons1();
               _loc4_.habbiconId = _loc2_;
               UnknownVarFromHabbiconController_Dictionary_1[_loc2_] = _loc4_;
               handleNewOwnedHabbicon(_loc2_);
            }
            else
            {
               _loc5_ = _loc4_.habbiconState;
            }
            _loc4_.habbiconState = _loc6_;
            if(isClaimedRewardTransition(_loc5_,_loc6_))
            {
               handleNewOwnedHabbicon(_loc2_);
            }
         }
         else
         {
            delete UnknownVarFromHabbiconController_Dictionary_1[_loc2_];
         }
         updateCachedShopItemState(_loc2_,_loc6_,null);
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_habbicon_status_changed",_loc2_));
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_owned_habbicons_updated",_loc2_));
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_shop_data_updated",_loc2_));
      }
      
      private function onHabbiconShopData(param1:HabbiconShopDataEvent) : void
      {
         var _loc8_:UnknownHabboCommunicationMessagesParserHabbicons3 = null;
         var _loc2_:Array = null;
         var _loc5_:UnknownHabboCommunicationMessagesParserHabbicons2 = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = param1.getParser();
         var _loc4_:Array = _loc3_.collections;
         UnknownVarFromHabbiconController_Dictionary_2 = new Dictionary();
         UnknownVarFromHabbiconController_Dictionary_3 = new Dictionary();
         UnknownVarFromHabbiconController_Vector_1 = new Vector.<UnknownHabboCommunicationMessagesParserHabbicons3>(0);
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc6_] as UnknownHabboCommunicationMessagesParserHabbicons3;
            if(_loc8_ != null)
            {
               UnknownVarFromHabbiconController_Dictionary_2[_loc8_.collectionId] = _loc8_;
               UnknownVarFromHabbiconController_Vector_1.push(_loc8_);
               _loc2_ = _loc8_.habbicons;
               if(_loc2_ != null)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc2_.length)
                  {
                     _loc5_ = _loc2_[_loc7_] as UnknownHabboCommunicationMessagesParserHabbicons2;
                     if(_loc5_ != null)
                     {
                        UnknownVarFromHabbiconController_Dictionary_3[_loc5_.habbiconId] = _loc5_;
                     }
                     _loc7_++;
                  }
               }
            }
            _loc6_++;
         }
         _hasLoadedShopData = true;
         UnknownVarFromHabbiconController_Boolean_2 = false;
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_shop_data_updated"));
      }
      
      private function onHabbiconInfo(param1:HabbiconInfoEvent) : void
      {
         var _loc2_:* = param1.getParser();
         var _loc3_:UnknownHabboCommunicationMessagesParserHabbicons2 = _loc2_.habbicon as UnknownHabboCommunicationMessagesParserHabbicons2;
         if(_loc3_ == null)
         {
            return;
         }
         UnknownVarFromHabbiconController_Dictionary_3[_loc3_.habbiconId] = _loc3_;
         updateCachedShopItemState(_loc3_.habbiconId,_loc3_.state,_loc3_);
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_shop_data_updated",_loc3_.habbiconId,_loc3_.collectionId));
      }
      
      private function onRoomUseHabbicon(param1:RoomUseHabbiconEvent) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         var _loc2_:* = param1.getParser();
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_room_use_habbicon",_loc2_.habbiconId,0,_loc2_.roomIndex));
      }
      
      private function onPurchaseOk(param1:PurchaseOKMessageEvent) : void
      {
         if(!_pendingPurchaseRefresh)
         {
            return;
         }
         _pendingPurchaseRefresh = false;
         closeHabbiconPurchaseConfirmation();
         getShopData(true);
      }
      
      private function onPurchaseFailed(param1:IMessageEvent) : void
      {
         if(!_pendingPurchaseRefresh)
         {
            return;
         }
         _pendingPurchaseRefresh = false;
         if(UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1 != null)
         {
            UnknownVarFromHabbiconController_HabbiconPurchaseConfirmationView_1.purchaseFailed();
         }
      }
      
      private function onHabbiconAssetsLoaded(param1:Event) : void
      {
         if(!habbiconsEnabled())
         {
            return;
         }
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_owned_habbicons_updated"));
         UnknownVarFromHabbiconController_EventDispatcher_1.dispatchEvent(new HabbiconControllerEvent("hce_shop_data_updated"));
      }
      
      private function handleNewOwnedHabbicon(param1:int) : void
      {
         if(_inventory != null && _inventory.unseenItemTracker != null)
         {
            _inventory.unseenItemTracker.setUnseenItem(8,param1);
         }
         showNewHabbiconNotification(param1);
      }
      
      private function showNewHabbiconNotification(param1:int) : void
      {
         if(_notifications == null || _localizationManager == null)
         {
            return;
         }
         var _loc3_:String = resolveHabbiconDisplayName(param1);
         _localizationManager.registerParameter("notification.new.habbicon","habbicon_name",_loc3_);
         var _loc2_:String = _localizationManager.getLocalization("notification.new.habbicon");
         _notifications.addItemWithBitmap(_loc2_,"habbicon_received",createHabbiconNotificationIcon(param1),"habbicons/open");
      }
      
      private function resolveHabbiconDisplayName(param1:int) : String
      {
         var _loc2_:String = HabbiconAssetManager.getHabbiconNameKey(param1);
         if(_loc2_ != null && _loc2_.length > 0)
         {
            return _localizationManager.getLocalization("habbicon_" + _loc2_ + "_name",_loc2_);
         }
         return param1.toString();
      }
      
      private function createHabbiconNotificationIcon(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(param1,false);
         return _loc2_ != null ? _loc2_.clone() : null;
      }
      
      private function habbiconsEnabled() : Boolean
      {
         return _configurationManager != null && Boolean(_configurationManager.getBoolean("habbicons.enabled"));
      }
      
      private function updateCachedShopItemState(param1:int, param2:int, param3:UnknownHabboCommunicationMessagesParserHabbicons2 = null) : void
      {
         var _loc5_:int = 0;
         var _loc4_:UnknownHabboCommunicationMessagesParserHabbicons2 = null;
         if(updateCachedRewardState(param1,param2))
         {
            return;
         }
         if(param3 != null)
         {
            UnknownVarFromHabbiconController_Dictionary_3[param1] = param3;
         }
         else
         {
            param3 = UnknownVarFromHabbiconController_Dictionary_3[param1] as UnknownHabboCommunicationMessagesParserHabbicons2;
            if(param3 == null)
            {
               return;
            }
         }
         param3.state = param2;
         var _loc6_:UnknownHabboCommunicationMessagesParserHabbicons3 = UnknownVarFromHabbiconController_Dictionary_2[param3.collectionId] as UnknownHabboCommunicationMessagesParserHabbicons3;
         if(_loc6_ == null || _loc6_.habbicons == null)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc6_.habbicons.length)
         {
            _loc4_ = _loc6_.habbicons[_loc5_] as UnknownHabboCommunicationMessagesParserHabbicons2;
            if(!(_loc4_ == null || _loc4_.habbiconId != param1))
            {
               _loc6_.habbicons[_loc5_] = param3;
               break;
            }
            _loc5_++;
         }
         _loc6_.completed = isCollectionCompleted(_loc6_);
         if(_loc6_.completed)
         {
            markCollectionRewardClaimable(_loc6_);
         }
      }
      
      private function updateCachedRewardState(param1:int, param2:int) : Boolean
      {
         for each(var _loc3_ in UnknownVarFromHabbiconController_Vector_1)
         {
            if(!(_loc3_ == null || _loc3_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1 != param1))
            {
               _loc3_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_2 = param2;
               return true;
            }
         }
         return false;
      }
      
      private function markCollectionRewardClaimable(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : void
      {
         var _loc2_:UnknownHabboCommunicationMessagesParserHabbicons1 = null;
         if(param1 == null || param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1 <= 0)
         {
            return;
         }
         if(param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_2 == 2 || param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_2 == 3)
         {
            return;
         }
         param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_2 = 1;
         _loc2_ = UnknownVarFromHabbiconController_Dictionary_1[param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1] as UnknownHabboCommunicationMessagesParserHabbicons1;
         if(_loc2_ == null)
         {
            _loc2_ = new UnknownHabboCommunicationMessagesParserHabbicons1();
            _loc2_.habbiconId = param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1;
            UnknownVarFromHabbiconController_Dictionary_1[param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1] = _loc2_;
         }
         _loc2_.habbiconState = 1;
      }
      
      private function isStoredUserState(param1:int) : Boolean
      {
         return param1 == 1 || param1 == 2 || param1 == 3;
      }
      
      private function isClaimedRewardTransition(param1:int, param2:int) : Boolean
      {
         return param1 == 1 && (param2 == 2 || param2 == 3);
      }
      
      private function isCollectionCompleted(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:* = null;
         if(param1 == null || param1.habbicons == null || param1.habbicons.length == 0)
         {
            return false;
         }
         _loc2_ = param1.habbicons;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_ == null || !isStoredUserState(_loc3_.state))
            {
               return false;
            }
         }
         return true;
      }
      
      private function setRecentHabbiconIds(param1:Array) : void
      {
         UnknownVarFromHabbiconController_Array_1 = [];
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            UnknownVarFromHabbiconController_Array_1.push(_loc2_);
         }
      }
      
      private function addRecentHabbiconId(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         var _loc2_:int = int(UnknownVarFromHabbiconController_Array_1.indexOf(param1));
         if(_loc2_ >= 0)
         {
            UnknownVarFromHabbiconController_Array_1.splice(_loc2_,1);
         }
         UnknownVarFromHabbiconController_Array_1.unshift(param1);
         if(UnknownVarFromHabbiconController_Array_1.length > 10)
         {
            UnknownVarFromHabbiconController_Array_1.length = 10;
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         if(UnknownVarFromHabbiconController_HabbiconView_1)
         {
            UnknownVarFromHabbiconController_HabbiconView_1.dispose();
            UnknownVarFromHabbiconController_HabbiconView_1 = null;
         }
         closeHabbiconPurchaseConfirmation();
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
         _messageEvents = null;
         UnknownVarFromHabbiconController_EventDispatcher_1 = null;
         UnknownVarFromHabbiconController_Dictionary_1 = null;
         UnknownVarFromHabbiconController_Array_1 = null;
         UnknownVarFromHabbiconController_Dictionary_2 = null;
         UnknownVarFromHabbiconController_Dictionary_3 = null;
         UnknownVarFromHabbiconController_Vector_1 = null;
         _communicationManager = null;
         _configurationManager = null;
         _localizationManager = null;
         _windowManager = null;
         super.dispose();
      }
   }
}

