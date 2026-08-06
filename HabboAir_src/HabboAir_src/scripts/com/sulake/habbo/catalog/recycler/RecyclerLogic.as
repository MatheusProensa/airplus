package com.sulake.habbo.catalog.recycler
{
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.utils.getTimer;
   
   public class RecyclerLogic implements IRecycler
   {
      private static const STATUS_OFF:int = 0;
      
      private static const STATUS_READY:int = 1;
      
      private static const STATUS_WAITING_FOR_SERVER:int = 2;
      
      private var _localStatus:int = 0;
      
      private var _systemStatus:int;
      
      private var UnknownVarFromRecyclerLogic_Int_1:int;
      
      private var UnknownVarFromRecyclerLogic_Array_1:Array = [];
      
      private var _catalog:HabboCatalog;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromRecyclerLogic_IRecyclerVisualization_1:IRecyclerVisualization;
      
      private var _prizes:Array;
      
      private var UnknownVarFromRecyclerLogic_Function_1:Function;
      
      private var _numberOfSlots:int;
      
      public function RecyclerLogic(param1:HabboCatalog, param2:IHabboWindowManagerComponent)
      {
         super();
         _catalog = param1;
         _windowManager = param2;
         _numberOfSlots = param1.getInteger("recycler.number_of_slots",5);
      }
      
      private function get statusActive() : Boolean
      {
         return _localStatus != 0;
      }
      
      private function get systemActive() : Boolean
      {
         return _systemStatus != 2;
      }
      
      private function get ready() : Boolean
      {
         return active && _localStatus == 1;
      }
      
      public function get active() : Boolean
      {
         return statusActive && systemActive;
      }
      
      public function get numberOfSlots() : int
      {
         return _numberOfSlots;
      }
      
      public function dispose() : void
      {
         UnknownVarFromRecyclerLogic_Array_1 = null;
         _catalog = null;
         _windowManager = null;
         UnknownVarFromRecyclerLogic_Function_1 = null;
      }
      
      public function init(param1:IRecyclerVisualization = null) : void
      {
         _localStatus = 2;
         UnknownVarFromRecyclerLogic_Array_1 = new Array(_numberOfSlots);
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromRecyclerLogic_IRecyclerVisualization_1 = param1;
         _catalog.getRecyclerStatus();
      }
      
      public function activate() : void
      {
         if(systemActive)
         {
            _localStatus = 1;
         }
      }
      
      public function cancel() : void
      {
         _catalog.setupInventoryForRecycler(false);
         releaseAllSlots();
         _localStatus = 0;
      }
      
      public function releaseAllSlots() : void
      {
         var _loc1_:int = 0;
         if(!ready)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _numberOfSlots)
         {
            if(UnknownVarFromRecyclerLogic_Array_1[_loc1_] != null)
            {
               _catalog.returnInventoryFurniFromRecycler(UnknownVarFromRecyclerLogic_Array_1[_loc1_].id);
               UnknownVarFromRecyclerLogic_Array_1[_loc1_] = null;
            }
            _loc1_ += 1;
         }
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function empty() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _numberOfSlots)
         {
            releaseSlot(_loc1_);
            _loc1_++;
         }
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function secondsToWait() : int
      {
         if(_systemStatus == 3)
         {
            return Math.max(0,int(Math.ceil((UnknownVarFromRecyclerLogic_Int_1 - getTimer()) / 1000)));
         }
         return 0;
      }
      
      public function setNextRecycleAllowedTimestamp(param1:int) : void
      {
         UnknownVarFromRecyclerLogic_Int_1 = param1;
         if(UnknownVarFromRecyclerLogic_Int_1 > getTimer())
         {
            _systemStatus = 3;
         }
      }
      
      public function setSystemStatus(param1:int, param2:int) : void
      {
         _systemStatus = param1;
         setNextRecycleAllowedTimestamp(getTimer() + param2 * 1000);
         if(!systemActive)
         {
            if(UnknownVarFromRecyclerLogic_IRecyclerVisualization_1 == null || UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.disposed)
            {
               return;
            }
            UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.updateUI();
            return;
         }
         _localStatus = 1;
         if(UnknownVarFromRecyclerLogic_IRecyclerVisualization_1 == null || UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.disposed)
         {
            return;
         }
         UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.updateUI();
         _catalog.setupInventoryForRecycler(_systemStatus != 2);
         verifyRoomSessionStatus();
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function setFinished(param1:int, param2:int) : void
      {
         var status:int = param1;
         var prizeId:int = param2;
         if(!statusActive)
         {
            return;
         }
         _localStatus = 1;
         if(!systemActive)
         {
            return;
         }
         switch(status - 1)
         {
            case 0:
               if(UnknownVarFromRecyclerLogic_IRecyclerVisualization_1 != null)
               {
                  UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.updateUI();
               }
               break;
            case 1:
               Logger.log("* Recycler finished with FAILURE");
               _windowManager.alert("${generic.alert.title}","${recycler.info.closed}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               if(UnknownVarFromRecyclerLogic_IRecyclerVisualization_1 != null)
               {
                  UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.updateUI();
                  break;
               }
         }
         releaseAllSlots();
      }
      
      public function getSlotContent(param1:int) : FurniSlotItem
      {
         if(UnknownVarFromRecyclerLogic_Array_1 == null)
         {
            return null;
         }
         if(param1 >= UnknownVarFromRecyclerLogic_Array_1.length)
         {
            return null;
         }
         return UnknownVarFromRecyclerLogic_Array_1[param1];
      }
      
      public function placeObjectAtSlot(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Boolean = false) : void
      {
         var oldObjectData:FurniSlotItem;
         var newSlotId:int;
         var itemId:int;
         var slotId:int = param1;
         var id:int = param2;
         var category:int = param3;
         var typeId:int = param4;
         var xxxExtra:String = param5;
         var findNewSlotId:Boolean = param6;
         if(!ready)
         {
            return;
         }
         if(!findNewSlotId)
         {
            oldObjectData = UnknownVarFromRecyclerLogic_Array_1[slotId];
            if(oldObjectData != null)
            {
               releaseSlot(slotId);
            }
         }
         else if(UnknownVarFromRecyclerLogic_Array_1.length > 0)
         {
            oldObjectData = UnknownVarFromRecyclerLogic_Array_1[0];
            newSlotId = 0;
            while(oldObjectData != null && newSlotId < _numberOfSlots)
            {
               oldObjectData = UnknownVarFromRecyclerLogic_Array_1[newSlotId];
               if(oldObjectData != null)
               {
                  newSlotId++;
               }
            }
            if(oldObjectData != null)
            {
               return;
            }
            slotId = newSlotId;
         }
         itemId = _catalog.requestInventoryFurniToRecycler();
         if(itemId == 0)
         {
            _windowManager.alert("${generic.alert.title}","${recycler.alert.non.recyclable}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
            return;
         }
         UnknownVarFromRecyclerLogic_Array_1[slotId] = new FurniSlotItem(itemId,category,typeId,xxxExtra);
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function releaseSlot(param1:int) : void
      {
         if(!ready)
         {
            return;
         }
         if(UnknownVarFromRecyclerLogic_Array_1[param1] == null)
         {
            return;
         }
         if(!_catalog.returnInventoryFurniFromRecycler(UnknownVarFromRecyclerLogic_Array_1[param1].id))
         {
            return;
         }
         UnknownVarFromRecyclerLogic_Array_1[param1] = null;
         updateRecyclerSlots();
         updateRecyclerButton();
      }
      
      public function executeRecycler() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FurniSlotItem = null;
         if(!isReadyToRecycle())
         {
            return;
         }
         _localStatus = 2;
         updateRecyclerButton();
         var _loc3_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromRecyclerLogic_Array_1.length)
         {
            _loc2_ = UnknownVarFromRecyclerLogic_Array_1[_loc1_];
            if(_loc2_ == null)
            {
               return;
            }
            _loc3_.push(_loc2_.id);
            _loc1_++;
         }
         _catalog.sendRecycleItems(_loc3_);
         UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.updateUI();
      }
      
      public function isReadyToRecycle() : Boolean
      {
         if(!ready || !_catalog.privateRoomSessionActive)
         {
            return false;
         }
         if(isTradingActive())
         {
            _windowManager.alert("${generic.alert.title}","${recycler.alert.trading}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
            return false;
         }
         return isPoolFull();
      }
      
      public function get ducketCost() : int
      {
         return _catalog.getInteger("recycler.ducket_cost",0);
      }
      
      public function hasEnoughDuckets() : Boolean
      {
         return _catalog.getPurse().getActivityPointsForType(0) >= ducketCost;
      }
      
      public function get timeout() : int
      {
         return _catalog.getInteger("recycler.timeout_seconds",10);
      }
      
      public function setRoomSessionActive(param1:Boolean) : void
      {
         if(param1 == false)
         {
            empty();
            verifyRoomSessionStatus();
         }
         updateRecyclerButton();
      }
      
      private function verifyRoomSessionStatus() : void
      {
         if(!_catalog.privateRoomSessionActive && ready)
         {
            _windowManager.alert("${generic.alert.title}","${recycler.alert.privateroom}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
            {
               param1.dispose();
            });
         }
      }
      
      private function updateRecyclerSlots() : void
      {
         if(UnknownVarFromRecyclerLogic_IRecyclerVisualization_1 == null || !statusActive)
         {
            return;
         }
         UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.updateSlots();
      }
      
      private function updateRecyclerButton() : void
      {
         if(UnknownVarFromRecyclerLogic_IRecyclerVisualization_1 == null || !statusActive)
         {
            return;
         }
         UnknownVarFromRecyclerLogic_IRecyclerVisualization_1.updateRecycleButton();
      }
      
      private function isPoolFull() : Boolean
      {
         var _loc1_:int = 0;
         if(UnknownVarFromRecyclerLogic_Array_1 == null)
         {
            return false;
         }
         if(UnknownVarFromRecyclerLogic_Array_1.length < _numberOfSlots)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromRecyclerLogic_Array_1.length)
         {
            if(UnknownVarFromRecyclerLogic_Array_1[_loc1_] == null)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function isTradingActive() : Boolean
      {
         return _catalog.tradingActive;
      }
      
      public function storePrizeTable(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PrizeLevelContainer = null;
         _prizes = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new PrizeLevelContainer(param1[_loc3_],_catalog);
            _prizes.push(_loc2_);
            _loc3_++;
         }
         if(UnknownVarFromRecyclerLogic_Function_1 != null)
         {
            UnknownVarFromRecyclerLogic_Function_1(_prizes);
            UnknownVarFromRecyclerLogic_Function_1 = null;
         }
      }
      
      public function getPrizeTable(param1:Function) : Array
      {
         if(_prizes == null)
         {
            UnknownVarFromRecyclerLogic_Function_1 = param1;
            _catalog.getRecyclerPrizes();
            return null;
         }
         return _prizes;
      }
      
      public function get recyclerDisabled() : Boolean
      {
         return !systemActive;
      }
   }
}

