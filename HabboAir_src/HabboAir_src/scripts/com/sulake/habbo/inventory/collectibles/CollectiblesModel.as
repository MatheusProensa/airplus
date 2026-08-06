package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.collectibles.GetNftTradeInventoryComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftItem;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   
   public class CollectiblesModel implements IInventoryModel
   {
      private var _controller:HabboInventory;
      
      private var UnknownVarFromCollectiblesModel_CollectiblesView_1:CollectiblesView;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _disposed:Boolean = false;
      
      private var _isLoaded:Boolean;
      
      private var _items:Map;
      
      private var _requestedInventoryThisTrade:Boolean = false;
      
      private var _selected:CollectibleGroupedItem = null;
      
      public function CollectiblesModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IRoomEngine, param6:IHabboCatalog, param7:IAvatarRenderManager)
      {
         super();
         _controller = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _catalog = param6;
         _items = new Map();
         UnknownVarFromCollectiblesModel_CollectiblesView_1 = new CollectiblesView(this,param2,param4);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromCollectiblesModel_CollectiblesView_1)
            {
               UnknownVarFromCollectiblesModel_CollectiblesView_1.dispose();
               UnknownVarFromCollectiblesModel_CollectiblesView_1 = null;
            }
            if(_items)
            {
               _items.dispose();
               _items = null;
            }
            _controller = null;
            _catalog = null;
            _assets = null;
            _communication = null;
            _disposed = true;
         }
      }
      
      public function get controller() : HabboInventory
      {
         return _controller;
      }
      
      public function isListInitialized() : Boolean
      {
         return _isLoaded;
      }
      
      public function setListInitialized() : void
      {
         _isLoaded = true;
         UnknownVarFromCollectiblesModel_CollectiblesView_1.updateState();
      }
      
      public function onTradeComplete() : void
      {
         _isLoaded = false;
         controller.setInventoryCategoryInit("collectibles",false);
         UnknownVarFromCollectiblesModel_CollectiblesView_1.updateState();
      }
      
      public function get items() : Map
      {
         return _items;
      }
      
      public function initCollectibles(param1:Map) : void
      {
         var _loc6_:int = 0;
         var _loc2_:TradeNftItem = null;
         var _loc3_:Array = param1.getKeys();
         var _loc7_:Array = _items.getKeys();
         var _loc4_:Vector.<TradeNftItem> = new Vector.<TradeNftItem>();
         var _loc5_:Vector.<TradeNftItem> = new Vector.<TradeNftItem>();
         for each(_loc6_ in _loc7_)
         {
            if(_loc3_.indexOf(_loc6_) == -1)
            {
               _loc2_ = _items.remove(_loc6_);
               if(_loc2_ != null)
               {
                  _loc4_.push(_loc2_);
               }
            }
         }
         for each(_loc6_ in _loc3_)
         {
            if(_loc7_.indexOf(_loc6_) == -1)
            {
               _loc2_ = param1.getValue(_loc6_);
               _items.add(_loc6_,_loc2_);
               _loc5_.push(_loc2_);
            }
         }
         UnknownVarFromCollectiblesModel_CollectiblesView_1.initCollectibles(_loc5_,_loc4_);
         if(!controller.checkCategoryInitilization("collectibles"))
         {
            controller.setInventoryCategoryInit("collectibles");
            setListInitialized();
         }
      }
      
      public function requestAddTrading(param1:CollectibleGroupedItem, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 < 1 || param2 > param1.unlockedAssetCount)
         {
            return;
         }
         var _loc3_:Vector.<Number> = param1.pop(param2);
         if(_loc3_.length < 1)
         {
            return;
         }
         controller.tradingModel.requestAddNftsToTrading(_loc3_);
      }
      
      public function updateItemLocks() : void
      {
         var _loc5_:CollectibleGroupedItem = null;
         UnknownVarFromCollectiblesModel_CollectiblesView_1.unlockAll();
         var _loc3_:TradingModel = controller.tradingModel;
         if(_loc3_ == null || !_loc3_.running)
         {
            return;
         }
         var _loc4_:Map = _loc3_.ownUserNftItems;
         for each(var _loc1_ in _loc4_.getValues())
         {
            _loc5_ = UnknownVarFromCollectiblesModel_CollectiblesView_1.findGroupedItem(_loc1_.item,false);
            if(_loc5_ != null)
            {
               for each(var _loc2_ in _loc1_.assetIds)
               {
                  _loc5_.lockAsset(_loc2_);
               }
            }
         }
         UnknownVarFromCollectiblesModel_CollectiblesView_1.updatePreview();
      }
      
      public function setSelected(param1:CollectibleGroupedItem) : void
      {
         if(param1 == _selected)
         {
            return;
         }
         if(_selected != null)
         {
            _selected.isSelected = false;
            _selected = null;
         }
         if(param1 != null)
         {
            param1.isSelected = true;
            _selected = param1;
         }
         UnknownVarFromCollectiblesModel_CollectiblesView_1.updatePreview();
      }
      
      public function get selected() : CollectibleGroupedItem
      {
         return _selected;
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "collectibles" && _controller.isVisible)
         {
            _controller.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_COLLECTIBLES"));
            requestNftAssets();
            UnknownVarFromCollectiblesModel_CollectiblesView_1.updateContainerVisibility();
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return UnknownVarFromCollectiblesModel_CollectiblesView_1.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(UnknownVarFromCollectiblesModel_CollectiblesView_1.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
         switch(param1)
         {
            case "trading":
               _requestedInventoryThisTrade = false;
               if(UnknownVarFromCollectiblesModel_CollectiblesView_1.isVisible)
               {
                  requestNftAssets();
               }
               break;
            case "empty":
               UnknownVarFromCollectiblesModel_CollectiblesView_1.unlockAll();
         }
      }
      
      public function requestNftAssets() : void
      {
         if(!_requestedInventoryThisTrade)
         {
            _requestedInventoryThisTrade = true;
            _communication.connection.send(new GetNftTradeInventoryComposer());
         }
      }
      
      public function updateView() : void
      {
         if(UnknownVarFromCollectiblesModel_CollectiblesView_1 == null)
         {
            return;
         }
      }
      
      private function getItemById(param1:Number) : TradeNftItem
      {
         return _items[param1];
      }
      
      public function getGroupedItemById(param1:Number) : CollectibleGroupedItem
      {
         var _loc2_:TradeNftItem = getItemById(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return UnknownVarFromCollectiblesModel_CollectiblesView_1.findGroupedItem(_loc2_);
      }
      
      public function resetUnseenItems() : void
      {
         _controller.unseenItemTracker.resetCategory(7);
         _controller.updateUnseenItemCounts();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return _controller.unseenItemTracker.isUnseen(5,param1);
      }
      
      public function selectItemById(param1:String) : void
      {
      }
   }
}

