package com.sulake.habbo.inventory.marketplace
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.Set;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceTokensMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceCanMakeOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.MakeOfferMessageComposer;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class MarketplaceModel implements IInventoryModel
   {
      private static const DEFAULT_BULK_OFFER_LIMIT:int = 500;
      
      private var _controller:HabboInventory;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _disposed:Boolean = false;
      
      private var _offerGroup:GroupItem;
      
      private var _offerItems:Vector.<FurnitureItem>;
      
      private var _isEnabled:Boolean;
      
      private var _commission:int;
      
      private var _tokenBatchPrice:int;
      
      private var _tokenBatchSize:int;
      
      private var _offerMinPrice:int;
      
      private var _offerMaxPrice:int;
      
      private var _expirationHours:int;
      
      private var UnknownVarFromMarketplaceModel_Int_1:int;
      
      private var _sellingFeePercentage:int;
      
      private var _revenueLimit:int;
      
      private var _halfTaxLimit:int;
      
      private var UnknownVarFromMarketplaceModel_Int_2:int;
      
      private var UnknownVarFromMarketplaceModel_Int_3:int;
      
      private var UnknownVarFromMarketplaceModel_MarketplaceView_1:MarketplaceView;
      
      private var UnknownVarFromMarketplaceModel_Boolean_1:Boolean = false;
      
      public function MarketplaceModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IRoomEngine, param6:IHabboLocalizationManager)
      {
         super();
         _controller = param1;
         _communication = param3;
         _windowManager = param2;
         _assets = param4;
         _roomEngine = param5;
         UnknownVarFromMarketplaceModel_MarketplaceView_1 = new MarketplaceView(this,_windowManager,_assets,param5,param6,param1);
      }
      
      public function get id() : String
      {
         return "marketplace";
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         _isEnabled = param1;
      }
      
      public function set commission(param1:int) : void
      {
         _commission = param1;
      }
      
      public function set tokenBatchPrice(param1:int) : void
      {
         _tokenBatchPrice = param1;
      }
      
      public function set tokenBatchSize(param1:int) : void
      {
         _tokenBatchSize = param1;
      }
      
      public function set offerMinPrice(param1:int) : void
      {
         _offerMinPrice = param1;
      }
      
      public function set offerMaxPrice(param1:int) : void
      {
         _offerMaxPrice = param1;
      }
      
      public function set expirationHours(param1:int) : void
      {
         _expirationHours = param1;
      }
      
      public function set averagePricePeriod(param1:int) : void
      {
         UnknownVarFromMarketplaceModel_Int_1 = param1;
      }
      
      public function set sellingFeePercentage(param1:int) : void
      {
         _sellingFeePercentage = param1;
      }
      
      public function set revenueLimit(param1:int) : void
      {
         _revenueLimit = param1;
      }
      
      public function set halfTaxLimit(param1:int) : void
      {
         _halfTaxLimit = param1;
      }
      
      public function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
      
      public function get commission() : int
      {
         return _commission;
      }
      
      public function get tokenBatchPrice() : int
      {
         return _tokenBatchPrice;
      }
      
      public function get tokenBatchSize() : int
      {
         return _tokenBatchSize;
      }
      
      public function get offerMinPrice() : int
      {
         return _offerMinPrice;
      }
      
      public function get offerMaxPrice() : int
      {
         return _offerMaxPrice;
      }
      
      public function get expirationHours() : int
      {
         return _expirationHours;
      }
      
      public function get sellingFeePercentage() : int
      {
         return _sellingFeePercentage;
      }
      
      public function get revenueLimit() : int
      {
         return _revenueLimit;
      }
      
      public function get halfTaxLimit() : int
      {
         return _halfTaxLimit;
      }
      
      public function get bulkOfferLimit() : int
      {
         var _loc1_:int = 0;
         if(_controller != null)
         {
            _loc1_ = int(_controller.getProperty("marketplace.bulkOfferLimit"));
         }
         return _loc1_ > 0 ? _loc1_ : 500;
      }
      
      public function get controller() : HabboInventory
      {
         return _controller;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         releaseItems();
         _controller = null;
         _communication = null;
         _windowManager = null;
         _assets = null;
         _roomEngine = null;
      }
      
      public function releaseItems() : void
      {
         var _loc2_:Set = null;
         if(_controller != null && _controller.furniModel != null && _offerItems != null && _offerGroup != null)
         {
            _loc2_ = new Set();
            for each(var _loc1_ in _offerItems)
            {
               _loc2_.add(_loc1_.id);
            }
            _controller.furniModel.removeLocksFor(_offerGroup,_loc2_);
         }
         _offerItems = null;
         _offerGroup = null;
      }
      
      public function startOfferMaking(param1:GroupItem) : void
      {
         if(_offerGroup != null || param1 == null)
         {
            return;
         }
         if(_controller == null)
         {
            return;
         }
         var _loc2_:FurniModel = _controller.furniModel;
         if(_loc2_ == null)
         {
            return;
         }
         _offerGroup = param1;
         send(new GetMarketplaceCanMakeOfferMessageComposer());
      }
      
      public function buyMarketplaceTokens() : void
      {
         send(new BuyMarketplaceTokensMessageComposer());
         UnknownVarFromMarketplaceModel_Boolean_1 = true;
      }
      
      public function makeOffer(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         if(_offerItems == null || _offerItems.length == 0)
         {
            return;
         }
         var _loc6_:int = Math.max(1,Math.min(param2,_offerItems.length));
         var _loc3_:Vector.<int> = new Vector.<int>();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc3_.push(_offerItems[_loc4_].ref);
            _loc4_++;
         }
         var _loc5_:int = _offerItems[0].isWallItem ? 2 : 1;
         send(new MakeOfferMessageComposer(param1,_loc5_,_loc3_));
         releaseItems();
      }
      
      public function getItemStats() : void
      {
         var _loc1_:FurnitureItem = getOfferItem() as FurnitureItem;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc3_:int = resolveStatsRequestCategory(_loc1_);
         var _loc2_:String = null;
         if(_loc1_.category == 6)
         {
            if(_loc1_.stuffData != null)
            {
               _loc2_ = _loc1_.stuffData.getLegacyString();
            }
            else if(!isNaN(_loc1_.extra))
            {
               _loc2_ = String(int(_loc1_.extra));
            }
         }
         UnknownVarFromMarketplaceModel_Int_2 = _loc3_;
         UnknownVarFromMarketplaceModel_Int_3 = _loc1_.type;
         send(new GetMarketplaceItemStatsComposer(_loc3_,_loc1_.type,_loc2_));
      }
      
      public function proceedOfferMaking(param1:int, param2:int) : void
      {
         UnknownVarFromMarketplaceModel_Boolean_1 = false;
         switch(param1 - 1)
         {
            case 0:
               if(_offerGroup == null)
               {
                  releaseItems();
                  return;
               }
               _offerItems = _controller.furniModel.lockAllSellable(_offerGroup);
               if(_offerItems == null || _offerItems.length == 0)
               {
                  releaseItems();
                  return;
               }
               UnknownVarFromMarketplaceModel_MarketplaceView_1.showMakeOffer(_offerItems[0],Math.min(_offerItems.length,bulkOfferLimit));
               break;
            case 1:
               UnknownVarFromMarketplaceModel_MarketplaceView_1.showAlert("${inventory.marketplace.no_trading_privilege.title}","${inventory.marketplace.no_trading_privilege.info}");
               break;
            case 2:
               UnknownVarFromMarketplaceModel_MarketplaceView_1.showAlert("${inventory.marketplace.no_trading_pass.title}","${inventory.marketplace.no_trading_pass.info}");
               break;
            case 3:
               UnknownVarFromMarketplaceModel_MarketplaceView_1.showBuyTokens(_tokenBatchPrice,_tokenBatchSize);
               break;
            case 4:
               releaseItems();
               break;
            case 5:
               UnknownVarFromMarketplaceModel_MarketplaceView_1.showAlert("${inventory.marketplace.trading_lock.title}","${inventory.marketplace.trading_lock.info}");
         }
      }
      
      public function endOfferMaking(param1:int) : void
      {
         if(!UnknownVarFromMarketplaceModel_MarketplaceView_1)
         {
            return;
         }
         UnknownVarFromMarketplaceModel_MarketplaceView_1.showResult(param1);
      }
      
      public function setItemStats(param1:MarketplaceItemStats) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.furniCategoryId != UnknownVarFromMarketplaceModel_Int_2 || param1.furniTypeId != UnknownVarFromMarketplaceModel_Int_3)
         {
            return;
         }
         if(!UnknownVarFromMarketplaceModel_MarketplaceView_1)
         {
            return;
         }
         UnknownVarFromMarketplaceModel_MarketplaceView_1.updateItemStats(param1,UnknownVarFromMarketplaceModel_Int_1);
      }
      
      private function resolveStatsRequestCategory(param1:FurnitureItem) : int
      {
         if(param1 != null && param1.stuffData != null && param1.stuffData.uniqueSerialNumber > 0)
         {
            return 3;
         }
         return param1 != null && param1.isWallItem ? 2 : 1;
      }
      
      public function onNotEnoughCredits() : void
      {
         if(UnknownVarFromMarketplaceModel_Boolean_1)
         {
            UnknownVarFromMarketplaceModel_Boolean_1 = false;
            releaseItems();
         }
      }
      
      public function requestInitialization() : void
      {
         send(new GetMarketplaceConfigurationMessageComposer());
      }
      
      public function getOfferItem() : IFurnitureItem
      {
         if(_offerItems != null && _offerItems.length > 0)
         {
            return _offerItems[0];
         }
         if(_offerGroup != null)
         {
            return _offerGroup.getOneForSelling();
         }
         return null;
      }
      
      public function getOfferItemRefs() : Array
      {
         var _loc2_:Array = [];
         if(_offerItems == null)
         {
            return _loc2_;
         }
         for each(var _loc1_ in _offerItems)
         {
            _loc2_.push(_loc1_.ref);
         }
         return _loc2_;
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return null;
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function updateView() : void
      {
      }
      
      private function send(param1:IMessageComposer) : void
      {
         if(_communication != null && _communication.connection != null)
         {
            _communication.connection.send(param1);
         }
      }
      
      public function selectItemById(param1:String) : void
      {
         Logger.log("NOT SUPPORTED: MARKETPLACE SELECT BY ID");
      }
   }
}

