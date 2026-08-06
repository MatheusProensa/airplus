package com.sulake.habbo.inventory
{
   import com.sulake.core.utils.Set;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.notifications.UnseenItemsEvent;
   import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemIdsComposer;
   import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;
   import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsParser;
   import com.sulake.habbo.inventory.enum.UnknownHabboInventoryEnum1;
   import com.sulake.habbo.inventory.events.HabboUnseenItemsUpdatedEvent;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class UnseenItemTracker implements IUnseenItemTracker
   {
      private var _communication:IHabboCommunicationManager;
      
      private var _inventory:HabboInventory;
      
      private var _unseenItems:Dictionary;
      
      private var UnknownVarFromUnseenItemTracker_Dictionary_1:Dictionary;
      
      private var UnknownVarFromUnseenItemTracker_IEventDispatcher_1:IEventDispatcher;
      
      public function UnseenItemTracker(param1:IHabboCommunicationManager, param2:IEventDispatcher, param3:HabboInventory)
      {
         super();
         _communication = param1;
         _inventory = param3;
         UnknownVarFromUnseenItemTracker_IEventDispatcher_1 = param2;
         _unseenItems = new Dictionary();
         UnknownVarFromUnseenItemTracker_Dictionary_1 = new Dictionary();
         _communication.addHabboConnectionMessageEvent(new UnseenItemsEvent(onUnseenItems));
      }
      
      public function dispose() : void
      {
         _communication = null;
         _unseenItems = null;
      }
      
      public function resetCategory(param1:int) : Boolean
      {
         if(getCount(param1) == 0)
         {
            return false;
         }
         delete _unseenItems[param1];
         delete UnknownVarFromUnseenItemTracker_Dictionary_1[param1];
         sendResetCategoryMessage(param1);
         sendUpdateEvent();
         return true;
      }
      
      public function resetItems(param1:int, param2:Array) : Boolean
      {
         if(getCount(param1) == 0)
         {
            return false;
         }
         var _loc4_:Set = _unseenItems[param1];
         for each(var _loc3_ in param2)
         {
            _loc4_.remove(_loc3_);
         }
         removeItemsFromMovedToTop(param1,param2);
         sendResetItemsMessage(param1,param2);
         sendUpdateEvent();
         return true;
      }
      
      public function resetCategoryIfEmpty(param1:int) : Boolean
      {
         if(getCount(param1) == 0)
         {
            delete _unseenItems[param1];
            delete UnknownVarFromUnseenItemTracker_Dictionary_1[param1];
            sendResetCategoryMessage(param1);
            sendUpdateEvent();
            return true;
         }
         return false;
      }
      
      public function isUnseen(param1:int, param2:int) : Boolean
      {
         var _loc3_:Set = null;
         if(_unseenItems[param1] != null)
         {
            _loc3_ = _unseenItems[param1];
            return _loc3_.contains(param2);
         }
         return false;
      }
      
      public function removeUnseen(param1:int, param2:int) : Boolean
      {
         var _loc3_:Set = null;
         if(_unseenItems[param1] != null)
         {
            _loc3_ = _unseenItems[param1];
            if(_loc3_.remove(param2))
            {
               removeItemsFromMovedToTop(param1,[param2]);
               sendUpdateEvent();
               return true;
            }
         }
         return false;
      }
      
      public function getIds(param1:int) : Array
      {
         if(_unseenItems[param1] != null)
         {
            return (_unseenItems[param1] as Set).toArray();
         }
         return [];
      }
      
      public function getCount(param1:int) : int
      {
         if(_unseenItems[param1] != null)
         {
            return (_unseenItems[param1] as Set).length;
         }
         return 0;
      }
      
      private function onUnseenItems(param1:UnseenItemsEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc5_:Array = null;
         var _loc3_:UnseenItemsParser = param1.getParser();
         for each(var _loc4_ in _loc3_.getCategories())
         {
            _loc5_ = _loc3_.getItemsByCategory(_loc4_);
            addItems(_loc4_,_loc5_);
            if(UnknownHabboInventoryEnum1.INVENTORY_CATEGORIES.indexOf(_loc4_) >= 0)
            {
               _loc2_ = true;
            }
         }
         onUnseenItemsUpdate();
      }
      
      public function setUnseenItem(param1:int, param2:int) : void
      {
         addItems(param1,[param2]);
         onUnseenItemsUpdate();
      }
      
      private function onUnseenItemsUpdate() : void
      {
         if(_inventory.isInitialized)
         {
            _inventory.updateUnseenItemCounts();
            _inventory.furniModel.updateUnseenItemsThumbs();
            _inventory.petsModel.updateView();
            _inventory.botsModel.updateView();
         }
         sendUpdateEvent();
      }
      
      private function sendUpdateEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:HabboUnseenItemsUpdatedEvent = new HabboUnseenItemsUpdatedEvent();
         var _loc3_:Array = UnknownHabboInventoryEnum1.INVENTORY_CATEGORIES;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = getCount(_loc4_);
            _loc1_.setCategoryCount(_loc4_,_loc2_);
            if(UnknownHabboInventoryEnum1.INVENTORY_CATEGORIES.indexOf(_loc4_) >= 0)
            {
               _loc1_.inventoryCount += _loc2_;
            }
         }
         UnknownVarFromUnseenItemTracker_IEventDispatcher_1.dispatchEvent(_loc1_);
      }
      
      private function addItems(param1:int, param2:Array, param3:Dictionary = null) : void
      {
         var _loc4_:Set = null;
         if(param2 == null)
         {
            return;
         }
         if(param3 == null)
         {
            param3 = _unseenItems;
         }
         if(param3[param1] == null)
         {
            _loc4_ = new Set();
            param3[param1] = _loc4_;
         }
         _loc4_ = param3[param1];
         for each(var _loc5_ in param2)
         {
            _loc4_.add(_loc5_);
         }
      }
      
      private function sendResetCategoryMessage(param1:int) : void
      {
         _communication.connection.send(new ResetUnseenItemsComposer(param1));
      }
      
      private function sendResetItemsMessage(param1:int, param2:Array) : void
      {
         _communication.connection.send(new ResetUnseenItemIdsComposer(param1,param2));
      }
      
      private function removeItemsFromMovedToTop(param1:int, param2:Array) : void
      {
         if(UnknownVarFromUnseenItemTracker_Dictionary_1[param1] == null || param2 == null)
         {
            return;
         }
         var _loc4_:Set = UnknownVarFromUnseenItemTracker_Dictionary_1[param1];
         for each(var _loc3_ in param2)
         {
            _loc4_.remove(_loc3_);
         }
      }
      
      public function setUnseenItemMovedToTop(param1:int, param2:Array) : void
      {
         addItems(param1,param2,UnknownVarFromUnseenItemTracker_Dictionary_1);
      }
      
      public function isUnseenItemMovedToTop(param1:int, param2:int) : Boolean
      {
         var _loc3_:Set = null;
         if(UnknownVarFromUnseenItemTracker_Dictionary_1[param1] != null)
         {
            _loc3_ = UnknownVarFromUnseenItemTracker_Dictionary_1[param1];
            return _loc3_.contains(param2);
         }
         return false;
      }
   }
}

