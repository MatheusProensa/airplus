package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   
   public class PetsModel implements IInventoryModel
   {
      private var _controller:HabboInventory;
      
      private var UnknownVarFromPetsModel_PetsView_1:PetsView;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _pets:Map;
      
      private var UnknownVarFromPetsModel_Boolean_1:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var _isListInitialized:Boolean;
      
      public function PetsModel(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IHabboCommunicationManager, param4:IAssetLibraryCollection, param5:IRoomEngine, param6:IHabboCatalog)
      {
         super();
         _controller = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _roomEngine.events.addEventListener("REOE_PLACED",onObjectPlaced);
         _catalog = param6;
         _pets = new Map();
         UnknownVarFromPetsModel_PetsView_1 = new PetsView(this,param2,param4,param5);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromPetsModel_PetsView_1)
            {
               UnknownVarFromPetsModel_PetsView_1.dispose();
               UnknownVarFromPetsModel_PetsView_1 = null;
            }
            if(_roomEngine)
            {
               if(_roomEngine.events)
               {
                  _roomEngine.events.removeEventListener("REOE_PLACED",onObjectPlaced);
               }
               _roomEngine = null;
            }
            if(_pets)
            {
               _pets.dispose();
               _pets = null;
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
         UnknownVarFromPetsModel_PetsView_1.updateState();
      }
      
      public function requestPetInventory() : void
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
         _loc1_.send(new GetPetInventoryComposer());
      }
      
      public function get pets() : Map
      {
         return _pets;
      }
      
      public function addPet(param1:PetData) : void
      {
         if(_pets.add(param1.id,param1))
         {
            UnknownVarFromPetsModel_PetsView_1.addPet(param1);
         }
         UnknownVarFromPetsModel_PetsView_1.updateState();
      }
      
      public function updatePets(param1:Map) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.getKeys();
         var _loc4_:Array = _pets.getKeys();
         _controller.setInventoryCategoryInit("pets");
         for each(_loc3_ in _loc4_)
         {
            if(_loc2_.indexOf(_loc3_) == -1)
            {
               _pets.remove(_loc3_);
               UnknownVarFromPetsModel_PetsView_1.removePet(_loc3_);
            }
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc4_.indexOf(_loc3_) == -1)
            {
               _pets.add(_loc3_,param1.getValue(_loc3_));
               UnknownVarFromPetsModel_PetsView_1.addPet(param1.getValue(_loc3_));
            }
         }
         setListInitialized();
      }
      
      public function removePet(param1:int) : void
      {
         _pets.remove(param1);
         UnknownVarFromPetsModel_PetsView_1.removePet(param1);
         UnknownVarFromPetsModel_PetsView_1.updateState();
      }
      
      public function requestInitialization() : void
      {
         requestPetInventory();
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "pets" && _controller.isVisible)
         {
            _controller.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_PETS"));
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return UnknownVarFromPetsModel_PetsView_1.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(UnknownVarFromPetsModel_PetsView_1.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:PetData = getPetById(param1);
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc3_:String = null;
         if(_loc5_.typeId == 16)
         {
            if(_loc5_.level >= 7)
            {
               _loc3_ = "std";
            }
            else
            {
               _loc3_ = "grw" + _loc5_.level;
            }
         }
         if(_controller.roomSession.isRoomOwner)
         {
            _loc4_ = _loc5_.id * -1;
            UnknownVarFromPetsModel_Boolean_1 = _roomEngine.initializeRoomObjectInsert("inventory",_loc4_,100,2,_loc5_.figureString,null,-1,-1,_loc3_);
            _controller.closeView();
            return UnknownVarFromPetsModel_Boolean_1;
         }
         if(!_controller.roomSession.arePetsAllowed)
         {
            return false;
         }
         if(!param2)
         {
            _communication.connection.send(new PlacePetMessageComposer(_loc5_.id,0,0));
         }
         return true;
      }
      
      public function updateView() : void
      {
         if(UnknownVarFromPetsModel_PetsView_1 == null)
         {
            return;
         }
         UnknownVarFromPetsModel_PetsView_1.update();
      }
      
      private function getPetById(param1:int) : PetData
      {
         for each(var _loc2_ in _pets)
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
         if(UnknownVarFromPetsModel_Boolean_1 && param1.type == "REOE_PLACED")
         {
            _controller.showView();
            UnknownVarFromPetsModel_Boolean_1 = false;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return _controller.roomSession;
      }
      
      public function updatePetsAllowed() : void
      {
         UnknownVarFromPetsModel_PetsView_1.update();
      }
      
      public function resetUnseenItems() : void
      {
         _controller.unseenItemTracker.resetCategory(3);
         _controller.updateUnseenItemCounts();
         UnknownVarFromPetsModel_PetsView_1.update();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return _controller.unseenItemTracker.isUnseen(3,param1);
      }
      
      public function removeUnseenFurniCounter(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(isUnseen(param1))
         {
            _loc2_ = _controller.unseenItemTracker.removeUnseen(3,param1);
            if(_loc2_)
            {
               _controller.unseenItemTracker.resetCategoryIfEmpty(3);
            }
         }
         return _loc2_;
      }
      
      public function selectItemById(param1:String) : void
      {
         UnknownVarFromPetsModel_PetsView_1.selectById(int(param1));
      }
   }
}

