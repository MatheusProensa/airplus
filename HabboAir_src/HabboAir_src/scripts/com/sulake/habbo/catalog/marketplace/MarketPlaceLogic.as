package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelAllOffersResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceClearOwnHistoryResultEvent;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelAllOffersResultParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceClearOwnHistoryResultParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class MarketPlaceLogic implements IMarketPlace
   {
      private static const TYPE_POSTER:String = "poster";
      
      public const PURCHASE_CONFIRM_TYPE_NORMAL:int = 1;
      
      public const PURCHASE_CONFIRM_TYPE_HIGHER:int = 2;
      
      public const UnknownConstFromMarketPlaceLogic_Int_1:int = 3;
      
      private var _catalog:HabboCatalog;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _visualization:IMarketPlaceVisualization;
      
      private var UnknownVarFromMarketPlaceLogic_MarketplaceConfirmationDialog_1:MarketplaceConfirmationDialog;
      
      private var _latestOffers:Map;
      
      private var _latestOwnOffers:Map;
      
      private var _creditsWaiting:int;
      
      private var _averagePricePeriod:int = -1;
      
      private var _itemStats:MarketplaceItemStats;
      
      private var UnknownVarFromMarketPlaceLogic_Int_1:int;
      
      private var UnknownVarFromMarketPlaceLogic_Int_2:int;
      
      private var _totalItemsFound:int;
      
      private var _ownOffersCategory:int = 1;
      
      private var UnknownVarFromMarketPlaceLogic_Int_3:int = 0;
      
      private var _minPrice:int = 0;
      
      private var _maxPrice:int = 0;
      
      private var _searchString:String = "";
      
      private var UnknownVarFromMarketPlaceLogic_Int_4:int = -1;
      
      private var _combineUniques:Boolean = true;
      
      private var _disposed:Boolean = false;
      
      public function MarketPlaceLogic(param1:HabboCatalog, param2:IHabboWindowManagerComponent, param3:IRoomEngine)
      {
         super();
         _catalog = param1;
         _windowManager = param2;
         _roomEngine = param3;
         getConfiguration();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _catalog = null;
         _windowManager = null;
         if(_latestOffers != null)
         {
            disposeOffers(_latestOffers);
            _latestOffers = null;
         }
         if(_latestOwnOffers != null)
         {
            disposeOffers(_latestOwnOffers);
            _latestOwnOffers = null;
         }
         _disposed = true;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _catalog.localization;
      }
      
      public function registerVisualization(param1:IMarketPlaceVisualization = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         _visualization = param1;
      }
      
      private function getConfiguration() : void
      {
         if(!_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.connection.send(new GetMarketplaceConfigurationMessageComposer());
      }
      
      private function showConfirmation(param1:int, param2:MarketPlaceOfferData) : void
      {
         if(!UnknownVarFromMarketPlaceLogic_MarketplaceConfirmationDialog_1)
         {
            UnknownVarFromMarketPlaceLogic_MarketplaceConfirmationDialog_1 = new MarketplaceConfirmationDialog(this,_catalog,_roomEngine);
         }
         UnknownVarFromMarketPlaceLogic_MarketplaceConfirmationDialog_1.showConfirmation(param1,param2);
      }
      
      public function requestOffersByName(param1:String, param2:Boolean = true) : void
      {
         requestOffers(-1,-1,param1,-1,param2);
      }
      
      public function requestOffersByPrice(param1:int, param2:Boolean = true) : void
      {
         requestOffers(param1,-1,"",-1,param2);
      }
      
      public function requestOffers(param1:int, param2:int, param3:String, param4:int, param5:Boolean = true) : void
      {
         _minPrice = param1;
         _maxPrice = param2;
         _searchString = param3;
         UnknownVarFromMarketPlaceLogic_Int_4 = param4;
         _combineUniques = param5;
         if(_catalog)
         {
            _catalog.getPublicMarketPlaceOffers(param1,param2,param3,param4,param5);
         }
      }
      
      public function refreshOffers() : void
      {
         requestOffers(_minPrice,_maxPrice,_searchString,UnknownVarFromMarketPlaceLogic_Int_4,_combineUniques);
      }
      
      public function requestOwnItems(param1:int = 1) : void
      {
         _ownOffersCategory = param1;
         if(_catalog)
         {
            _catalog.getOwnMarketPlaceOffers(param1);
         }
      }
      
      public function requestItemStats(param1:IMarketPlaceOfferData) : void
      {
         if(_catalog == null || param1 == null)
         {
            return;
         }
         UnknownVarFromMarketPlaceLogic_Int_2 = param1.furniId;
         UnknownVarFromMarketPlaceLogic_Int_1 = resolveStatsRequestCategory(param1);
         var _loc2_:String = null;
         if(isPosterItem(param1))
         {
            _loc2_ = param1.extraData;
         }
         _catalog.getMarketplaceItemStats(UnknownVarFromMarketPlaceLogic_Int_1,param1.furniId,_loc2_);
      }
      
      public function buyOffer(param1:int) : void
      {
         if(!_latestOffers || !_catalog || !_catalog.getPurse())
         {
            return;
         }
         var _loc2_:MarketPlaceOfferData = _latestOffers.getValue(param1) as MarketPlaceOfferData;
         if(!_loc2_)
         {
            return;
         }
         if(_catalog.getPurse().credits < _loc2_.price)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         showConfirmation(1,_loc2_);
      }
      
      public function redeemExpiredOffer(param1:int) : void
      {
         if(_catalog)
         {
            _catalog.redeemExpiredMarketPlaceOffer(param1);
         }
      }
      
      public function recallAllOffers() : void
      {
         if(_catalog)
         {
            _catalog.cancelAllMarketPlaceOffers();
         }
      }
      
      public function clearOwnHistory(param1:int) : void
      {
         if(!_catalog || !UnknownHabboCatalogMarketplace1.isClearable(param1))
         {
            return;
         }
         UnknownVarFromMarketPlaceLogic_Int_3 = param1;
         _catalog.clearOwnMarketPlaceHistory(param1);
      }
      
      private function disposeOffers(param1:Map) : void
      {
         if(param1 != null)
         {
            for each(var _loc2_ in param1)
            {
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            param1.dispose();
         }
      }
      
      public function onOffers(param1:IMessageEvent) : void
      {
         var _loc3_:MarketPlaceOfferData = null;
         var _loc4_:MarketPlaceOffersEvent = param1 as MarketPlaceOffersEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:MarketPlaceOffersParser = _loc4_.getParser() as MarketPlaceOffersParser;
         if(_loc2_ == null)
         {
            return;
         }
         disposeOffers(_latestOffers);
         _latestOffers = new Map();
         for each(var _loc5_ in _loc2_.offers)
         {
            _loc3_ = new MarketPlaceOfferData(_loc5_.offerId,_loc5_.furniId,_loc5_.furniType,_loc5_.extraData,_loc5_.stuffData,_loc5_.price,_loc5_.status,_loc5_.averagePrice,_loc5_.offerCount,_loc5_.isUsable,_loc5_.isUsed);
            _loc3_.timeLeftMinutes = _loc5_.timeLeftMinutes;
            _latestOffers.add(_loc5_.offerId,_loc3_);
         }
         _totalItemsFound = _loc2_.totalItemsFound;
         if(_visualization != null)
         {
            _visualization.listUpdatedNotify();
         }
      }
      
      public function onOwnOffers(param1:IMessageEvent) : void
      {
         var _loc3_:MarketPlaceOfferData = null;
         var _loc4_:MarketPlaceOwnOffersEvent = param1 as MarketPlaceOwnOffersEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:MarketPlaceOwnOffersParser = _loc4_.getParser() as MarketPlaceOwnOffersParser;
         if(_loc2_ == null)
         {
            return;
         }
         disposeOffers(_latestOwnOffers);
         _latestOwnOffers = new Map();
         _creditsWaiting = _loc2_.creditsWaiting;
         for each(var _loc5_ in _loc2_.offers)
         {
            _loc3_ = new MarketPlaceOfferData(_loc5_.offerId,_loc5_.furniId,_loc5_.furniType,_loc5_.extraData,_loc5_.stuffData,_loc5_.price,_loc5_.status,_loc5_.averagePrice);
            _loc3_.timeLeftMinutes = _loc5_.timeLeftMinutes;
            _loc3_.statusTime = _loc5_.statusTime;
            _latestOwnOffers.add(_loc5_.offerId,_loc3_);
         }
         if(_visualization != null)
         {
            _visualization.listUpdatedNotify();
         }
      }
      
      public function onBuyResult(param1:IMessageEvent) : void
      {
         var parser:MarketplaceBuyOfferResultParser;
         var item:MarketPlaceOfferData;
         var updateItem:MarketPlaceOfferData;
         var event:IMessageEvent = param1;
         var buyEvent:MarketplaceBuyOfferResultEvent = event as MarketplaceBuyOfferResultEvent;
         if(event == null)
         {
            return;
         }
         parser = buyEvent.getParser() as MarketplaceBuyOfferResultParser;
         if(parser == null)
         {
            return;
         }
         if(parser.result == 1)
         {
            refreshOffers();
         }
         else if(parser.result == 2)
         {
            item = _latestOffers.remove(parser.requestedOfferId);
            if(item != null)
            {
               item.dispose();
            }
            if(_visualization != null)
            {
               _visualization.listUpdatedNotify();
            }
            if(_windowManager != null)
            {
               _windowManager.alert("${catalog.marketplace.not_available_title}","${catalog.marketplace.not_available_header}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
            }
         }
         else if(parser.result == 3)
         {
            updateItem = _latestOffers.getValue(parser.requestedOfferId) as MarketPlaceOfferData;
            if(updateItem)
            {
               updateItem.offerId = parser.offerId;
               updateItem.price = parser.newPrice;
               updateItem.offerCount--;
               _latestOffers.add(parser.offerId,updateItem);
            }
            _latestOffers.remove(parser.requestedOfferId);
            showConfirmation(2,updateItem);
            if(_visualization != null)
            {
               _visualization.listUpdatedNotify();
            }
         }
         else if(parser.result == 4)
         {
            if(_windowManager != null)
            {
               _windowManager.alert("${catalog.alert.notenough.title}","${catalog.alert.notenough.credits.description}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
            }
         }
      }
      
      public function onCancelResult(param1:IMessageEvent) : void
      {
         var parser:MarketplaceCancelOfferResultParser;
         var item:MarketPlaceOfferData;
         var event:IMessageEvent = param1;
         var cancelEvent:MarketplaceCancelOfferResultEvent = event as MarketplaceCancelOfferResultEvent;
         if(cancelEvent == null)
         {
            return;
         }
         parser = cancelEvent.getParser() as MarketplaceCancelOfferResultParser;
         if(parser == null)
         {
            return;
         }
         if(parser.success)
         {
            item = _latestOwnOffers.remove(parser.offerId);
            if(item != null)
            {
               item.dispose();
            }
            if(_visualization != null)
            {
               _visualization.removeOfferIds([parser.offerId]);
            }
         }
         else if(_windowManager != null)
         {
            _windowManager.alert("${catalog.marketplace.operation_failed.topic}","${catalog.marketplace.cancel_failed}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
         }
      }
      
      public function onCancelAllResult(param1:IMessageEvent) : void
      {
         var parser:MarketplaceCancelAllOffersResultParser;
         var removedOfferIds:Array;
         var offerId:int;
         var item:MarketPlaceOfferData;
         var event:IMessageEvent = param1;
         var cancelEvent:MarketplaceCancelAllOffersResultEvent = event as MarketplaceCancelAllOffersResultEvent;
         if(cancelEvent == null)
         {
            return;
         }
         parser = cancelEvent.getParser() as MarketplaceCancelAllOffersResultParser;
         if(parser == null)
         {
            return;
         }
         if(parser.success)
         {
            removedOfferIds = [];
            if(_latestOwnOffers != null)
            {
               for each(offerId in parser.offerIds)
               {
                  item = _latestOwnOffers.remove(offerId);
                  if(item != null)
                  {
                     removedOfferIds.push(offerId);
                     item.dispose();
                  }
               }
            }
            if(_visualization != null)
            {
               _visualization.removeOfferIds(removedOfferIds);
            }
         }
         else if(_windowManager != null)
         {
            _windowManager.alert("${catalog.marketplace.operation_failed.topic}","${shop.marketplace.recall.failed}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
         }
      }
      
      public function onClearOwnHistoryResult(param1:IMessageEvent) : void
      {
         var parser:MarketplaceClearOwnHistoryResultParser;
         var pendingCategory:int;
         var removedOfferIds:Array;
         var offerId:int;
         var item:MarketPlaceOfferData;
         var event:IMessageEvent = param1;
         var clearEvent:MarketplaceClearOwnHistoryResultEvent = event as MarketplaceClearOwnHistoryResultEvent;
         if(clearEvent == null)
         {
            return;
         }
         parser = clearEvent.getParser() as MarketplaceClearOwnHistoryResultParser;
         if(parser == null)
         {
            return;
         }
         pendingCategory = UnknownVarFromMarketPlaceLogic_Int_3;
         UnknownVarFromMarketPlaceLogic_Int_3 = 0;
         if(parser.success)
         {
            if(pendingCategory != _ownOffersCategory || _latestOwnOffers == null)
            {
               return;
            }
            removedOfferIds = _latestOwnOffers.getKeys();
            if(removedOfferIds == null)
            {
               removedOfferIds = [];
            }
            for each(offerId in removedOfferIds)
            {
               item = _latestOwnOffers.remove(offerId);
               if(item != null)
               {
                  item.dispose();
               }
            }
            if(_visualization != null)
            {
               _visualization.removeOfferIds(removedOfferIds);
            }
         }
         else if(_windowManager != null)
         {
            _windowManager.alert("${catalog.marketplace.operation_failed.topic}","${shop.marketplace.mark.as.seen.failed}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
         }
      }
      
      public function latestOffers() : Map
      {
         return _latestOffers;
      }
      
      public function latestOwnOffers() : Map
      {
         return _latestOwnOffers;
      }
      
      public function totalItemsFound() : int
      {
         return _totalItemsFound;
      }
      
      public function set itemStats(param1:MarketplaceItemStats) : void
      {
         if(param1.furniCategoryId != UnknownVarFromMarketPlaceLogic_Int_1 || param1.furniTypeId != UnknownVarFromMarketPlaceLogic_Int_2)
         {
            return;
         }
         _itemStats = param1;
         if(_visualization != null)
         {
            _visualization.updateStats();
         }
      }
      
      public function get itemStats() : MarketplaceItemStats
      {
         return _itemStats;
      }
      
      public function get creditsWaiting() : int
      {
         return _creditsWaiting;
      }
      
      public function get ownOffersCategory() : int
      {
         return _ownOffersCategory;
      }
      
      public function get averagePricePeriod() : int
      {
         return _averagePricePeriod;
      }
      
      public function set averagePricePeriod(param1:int) : void
      {
         _averagePricePeriod = param1;
      }
      
      private function resolveStatsRequestCategory(param1:IMarketPlaceOfferData) : int
      {
         if(param1 != null && param1.isUniqueLimitedItem)
         {
            return 3;
         }
         return param1 != null && param1.furniType == 2 ? 2 : 1;
      }
      
      private function isPosterItem(param1:IMarketPlaceOfferData) : Boolean
      {
         var _loc2_:IFurnitureData = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         if(param1.furniType == 2 && param1.extraData != null)
         {
            _loc2_ = _catalog.getFurnitureData(param1.furniId,"i");
            if(_loc2_)
            {
               _loc3_ = _loc2_.className;
               if(_loc3_ != null && _loc3_ == "poster")
               {
                  _loc4_ = true;
               }
            }
         }
         return _loc4_;
      }
      
      public function getNameLocalizationKey(param1:IMarketPlaceOfferData) : String
      {
         var _loc2_:String = "";
         if(param1 != null)
         {
            if(isPosterItem(param1))
            {
               _loc2_ = "poster_" + param1.extraData + "_name";
            }
            else if(param1.furniType == 1)
            {
               _loc2_ = "roomItem.name." + param1.furniId;
            }
            else if(param1.furniType == 2)
            {
               _loc2_ = "wallItem.name." + param1.furniId;
            }
         }
         return _loc2_;
      }
      
      public function getDescriptionLocalizationKey(param1:IMarketPlaceOfferData) : String
      {
         var _loc2_:String = "";
         if(param1 != null)
         {
            if(isPosterItem(param1))
            {
               _loc2_ = "poster_" + param1.extraData + "_desc";
            }
            else if(param1.furniType == 1)
            {
               _loc2_ = "roomItem.desc." + param1.furniId;
            }
            else if(param1.furniType == 2)
            {
               _loc2_ = "wallItem.desc." + param1.furniId;
            }
         }
         return _loc2_;
      }
      
      public function isAccountSafetyLocked() : Boolean
      {
         if(_catalog)
         {
            return _catalog.sessionDataManager.isAccountSafetyLocked();
         }
         return false;
      }
   }
}

