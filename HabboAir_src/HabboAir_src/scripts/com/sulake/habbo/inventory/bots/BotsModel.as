package com.sulake.habbo.inventory.bots
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.bots.GetBotInventoryComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceBotMessageComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotData;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   
   public class BotsModel implements IInventoryModel
   {
      private var _controller:HabboInventory;
      
      private var UnknownVarFromBotsModel_BotsView_1:BotsView;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _items:Map;
      
      private var UnknownVarFromBotsModel_Boolean_1:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var _isListInitialized:Boolean;
      
      public function BotsModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IRoomEngine, param6:IHabboCatalog, param7:IAvatarRenderManager)
      {
         super();
         _controller = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _roomEngine.events.addEventListener("REOE_PLACED",onObjectPlaced);
         _catalog = param6;
         _items = new Map();
         UnknownVarFromBotsModel_BotsView_1 = new BotsView(this,param2,param4,param5,param7);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromBotsModel_BotsView_1)
            {
               UnknownVarFromBotsModel_BotsView_1.dispose();
               UnknownVarFromBotsModel_BotsView_1 = null;
            }
            if(_roomEngine)
            {
               if(_roomEngine.events)
               {
                  _roomEngine.events.removeEventListener("REOE_PLACED",onObjectPlaced);
               }
               _roomEngine = null;
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
         return _isListInitialized;
      }
      
      public function setListInitialized() : void
      {
         _isListInitialized = true;
         UnknownVarFromBotsModel_BotsView_1.updateState();
      }
      
      public function requestInventory() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:IConnection = _communication.connection;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.send(new GetBotInventoryComposer());
      }
      
      public function get items() : Map
      {
         return _items;
      }
      
      public function addItem(param1:BotData) : void
      {
         if(_items.add(param1.id,param1))
         {
            UnknownVarFromBotsModel_BotsView_1.addItem(param1);
         }
         UnknownVarFromBotsModel_BotsView_1.updateState();
      }
      
      public function updateItems(param1:Map) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.getKeys();
         var _loc4_:Array = _items.getKeys();
         for each(_loc3_ in _loc4_)
         {
            if(_loc2_.indexOf(_loc3_) == -1)
            {
               _items.remove(_loc3_);
               UnknownVarFromBotsModel_BotsView_1.removeItem(_loc3_);
            }
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc4_.indexOf(_loc3_) == -1)
            {
               _items.add(_loc3_,param1.getValue(_loc3_));
               UnknownVarFromBotsModel_BotsView_1.addItem(param1.getValue(_loc3_));
            }
         }
      }
      
      public function removeItem(param1:int) : void
      {
         _items.remove(param1);
         UnknownVarFromBotsModel_BotsView_1.removeItem(param1);
         UnknownVarFromBotsModel_BotsView_1.updateState();
      }
      
      public function requestInitialization() : void
      {
         requestInventory();
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "bots" && _controller.isVisible)
         {
            _controller.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_BOTS"));
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return UnknownVarFromBotsModel_BotsView_1.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(UnknownVarFromBotsModel_BotsView_1.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function placeItemToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:BotData = getItemById(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         if(!_controller.roomSession.areBotsAllowed)
         {
            return false;
         }
         if(_controller.roomSession.isRoomOwner)
         {
            _loc4_ = _loc3_.id * -1;
            UnknownVarFromBotsModel_Boolean_1 = _roomEngine.initializeRoomObjectInsert("inventory",_loc4_,100,4,_loc3_.figure);
            _controller.closeView();
            return UnknownVarFromBotsModel_Boolean_1;
         }
         if(!param2)
         {
            _communication.connection.send(new PlaceBotMessageComposer(_loc3_.id,0,0));
         }
         return true;
      }
      
      public function updateView() : void
      {
         if(UnknownVarFromBotsModel_BotsView_1 == null)
         {
            return;
         }
         UnknownVarFromBotsModel_BotsView_1.update();
      }
      
      private function getItemById(param1:int) : BotData
      {
         for each(var _loc2_ in _items)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onObjectPlaced(param1:Event) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromBotsModel_Boolean_1 && param1.type == "REOE_PLACED")
         {
            _controller.showView();
            UnknownVarFromBotsModel_Boolean_1 = false;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return _controller.roomSession;
      }
      
      public function resetUnseenItems() : void
      {
         _controller.unseenItemTracker.resetCategory(5);
         _controller.updateUnseenItemCounts();
         UnknownVarFromBotsModel_BotsView_1.update();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return _controller.unseenItemTracker.isUnseen(5,param1);
      }
      
      public function selectItemById(param1:String) : void
      {
         UnknownVarFromBotsModel_BotsView_1.selectById(int(param1));
      }
   }
}

