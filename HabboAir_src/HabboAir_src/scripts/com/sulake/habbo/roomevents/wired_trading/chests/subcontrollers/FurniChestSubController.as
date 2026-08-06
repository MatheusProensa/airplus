package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests.ItemsChestContentsChunkMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests.ItemsChestContentsUpdatedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.WithdrawItemsFromChestMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.ItemsChestContentsChunkMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.ItemsChestContentsUpdatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestStorage;
   import com.sulake.habbo.roomevents.wired_trading.chests.IWiredChestController_2;
   import com.sulake.habbo.roomevents.wired_trading.chests.UnknownHabboRoomeventsWired_TradingChests1;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestController;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views.FurniChestView;
   import flash.utils.Dictionary;
   
   public class FurniChestSubController extends AbstractChestSubController
   {
      private var UnknownVarFromFurniChestSubController_FurniChestView_1:FurniChestView;
      
      private var _storages:Vector.<ChestStorage>;
      
      public function FurniChestSubController(param1:IWiredChestController_2)
      {
         super(param1);
         _storages = new Vector.<ChestStorage>();
         addMessageEvent(new ItemsChestContentsUpdatedMessageEvent(onItemsUpdated));
         addMessageEvent(new ItemsChestContentsChunkMessageEvent(onItemsChunk));
         UnknownVarFromFurniChestSubController_FurniChestView_1 = new FurniChestView(this);
      }
      
      private function onItemsUpdated(param1:ItemsChestContentsUpdatedMessageEvent) : void
      {
         var _loc3_:ItemsChestContentsUpdatedMessageParser = param1.getParser();
         if(parentController.activeChestId != _loc3_.chestId || parentController.status != WiredChestController.STATUS_OPEN)
         {
            return;
         }
         var _loc8_:Dictionary = new Dictionary();
         for each(var _loc4_ in _loc3_.removedIds)
         {
            _loc8_[_loc4_] = true;
         }
         var _loc6_:Vector.<ChestStorage> = new Vector.<ChestStorage>();
         var _loc2_:Vector.<ChestStorage> = new Vector.<ChestStorage>();
         var _loc10_:Vector.<ChestStorage> = new Vector.<ChestStorage>();
         var _loc5_:Dictionary = new Dictionary();
         for each(var _loc9_ in _storages)
         {
            if(_loc9_.inventoryId in _loc8_)
            {
               _loc2_.push(_loc9_);
            }
            else
            {
               _loc6_.push(_loc9_);
               _loc5_[_loc9_.inventoryId] = true;
            }
         }
         for each(var _loc7_ in _loc3_.addedStorage)
         {
            if(!(_loc7_.inventoryId in _loc5_))
            {
               _loc10_.push(_loc7_);
               _loc6_.push(_loc7_);
               _loc5_[_loc7_.inventoryId] = true;
            }
         }
         _storages = _loc6_;
         UnknownVarFromFurniChestSubController_FurniChestView_1.itemsUpdated(_loc2_,_loc10_);
      }
      
      private function onItemsChunk(param1:ItemsChestContentsChunkMessageEvent) : void
      {
         var _loc2_:ItemsChestContentsChunkMessageParser = param1.getParser();
         var _loc3_:int = _loc2_.chestId;
         if(_loc2_.fragmentNo == 0)
         {
            if(parentController.requestedChestId != _loc3_)
            {
               return;
            }
            UnknownVarFromFurniChestSubController_FurniChestView_1.clear();
            _storages = new Vector.<ChestStorage>();
            parentController.setOpeningStatus(_loc3_);
         }
         for each(var _loc4_ in _loc2_.storageChunk)
         {
            _storages.push(_loc4_);
         }
         if(_loc2_.fragmentNo == _loc2_.totalFragments - 1)
         {
            parentController.setOpenStatus(_loc3_,this);
            UnknownVarFromFurniChestSubController_FurniChestView_1.itemsInitialize(_storages);
         }
      }
      
      public function withdrawItemsWithType(param1:ChestItemType, param2:int) : void
      {
         parentController.send(new WithdrawItemsFromChestMessageComposer(viewingChestId,param1,param2));
      }
      
      public function viewLogsWithType(param1:ChestItemType) : void
      {
      }
      
      override public function get type() : int
      {
         return UnknownHabboRoomeventsWired_TradingChests1.TYPE_FURNI;
      }
      
      override public function get title() : String
      {
         return localize("wiredchests.furni_chest");
      }
      
      override public function get view() : IWindowController_1
      {
         return UnknownVarFromFurniChestSubController_FurniChestView_1.container;
      }
      
      override public function get isEmpty() : Boolean
      {
         return _storages.length == 0;
      }
      
      override public function get itemCount() : int
      {
         return _storages.length;
      }
      
      override public function clear() : void
      {
         _storages = new Vector.<ChestStorage>();
         UnknownVarFromFurniChestSubController_FurniChestView_1.clear();
         super.clear();
      }
      
      override public function updateUI() : void
      {
         UnknownVarFromFurniChestSubController_FurniChestView_1.updateUI();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromFurniChestSubController_FurniChestView_1.dispose();
         UnknownVarFromFurniChestSubController_FurniChestView_1 = null;
         super.dispose();
      }
   }
}

