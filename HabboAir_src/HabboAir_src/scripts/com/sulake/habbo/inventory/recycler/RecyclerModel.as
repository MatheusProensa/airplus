package com.sulake.habbo.inventory.recycler
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class RecyclerModel implements IInventoryModel
   {
      public static const STATE_READY:uint = 0;
      
      public static const STATE_ACTIVE:uint = 1;
      
      private var _inventory:HabboInventory;
      
      private var UnknownVarFromRecyclerModel_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromRecyclerModel_Boolean_1:Boolean = false;
      
      private var _state:uint = 0;
      
      private var _itemList:Map;
      
      public function RecyclerModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IRoomEngine, param6:IHabboLocalizationManager)
      {
         super();
         _inventory = param1;
         _communication = param3;
         UnknownVarFromRecyclerModel_IAssetLibraryCollection_1 = param4;
         _roomEngine = param5;
         _localization = param6;
      }
      
      public function get running() : Boolean
      {
         return _state == 1;
      }
      
      public function get state() : uint
      {
         return _state;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set state(param1:uint) : void
      {
         _state = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _inventory = null;
            _communication = null;
            UnknownVarFromRecyclerModel_IAssetLibraryCollection_1 = null;
            _roomEngine = null;
            _localization = null;
            _disposed = true;
         }
         stopRecycler();
      }
      
      public function startRecycler() : void
      {
         if(_inventory == null || _inventory.furniModel == null)
         {
            return;
         }
         _state = 1;
         _itemList = new Map();
         _inventory.furniModel.showRecyclable(true);
      }
      
      public function stopRecycler() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_itemList == null || _inventory == null || _inventory.furniModel == null)
         {
            return;
         }
         _state = 0;
         _inventory.furniModel.showRecyclable(false);
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList.getKey(_loc2_);
            _inventory.furniModel.removeLockFrom(_loc1_);
            _loc2_++;
         }
         _itemList = null;
      }
      
      public function lockSelectedFurni() : int
      {
         if(_itemList == null || _inventory == null || _inventory.furniModel == null)
         {
            return 0;
         }
         var _loc1_:IFurnitureItem = _inventory.furniModel.requestSelectedFurniToRecycler();
         if(_loc1_ == null)
         {
            return 0;
         }
         if(_itemList.getValue(_loc1_.id) == null)
         {
            _itemList.add(_loc1_.id,_loc1_);
         }
         return _loc1_.id;
      }
      
      public function releaseFurni(param1:int) : Boolean
      {
         if(_itemList == null)
         {
            return true;
         }
         var _loc2_:IFurnitureItem = _itemList.getValue(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:FurniModel = _inventory.furniModel;
         if(_loc3_ == null)
         {
            return false;
         }
         _loc3_.removeLockFrom(param1);
         _itemList.remove(param1);
         return true;
      }
      
      public function getOwnItemsInRecycler() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(_itemList == null)
         {
            return [];
         }
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_.push(_itemList.getKey(_loc2_));
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return null;
      }
      
      public function updateView() : void
      {
      }
      
      public function selectItemById(param1:String) : void
      {
         Logger.log("NOT SUPPORTED: MARKETPLACE SELECT BY ID");
      }
   }
}

