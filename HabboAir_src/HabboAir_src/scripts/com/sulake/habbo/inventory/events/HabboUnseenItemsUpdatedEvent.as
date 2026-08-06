package com.sulake.habbo.inventory.events
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class HabboUnseenItemsUpdatedEvent extends Event
   {
      public static const UnknownConstFromHabboUnseenItemsUpdatedEvent_String_1:String = "HUIUE_UNSEEN_ITEMS_CHANGED";
      
      private var _inventoryCount:int;
      
      private var UnknownVarFromHabboUnseenItemsUpdatedEvent_Dictionary_1:Dictionary;
      
      public function HabboUnseenItemsUpdatedEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("HUIUE_UNSEEN_ITEMS_CHANGED");
         UnknownVarFromHabboUnseenItemsUpdatedEvent_Dictionary_1 = new Dictionary();
      }
      
      public function setCategoryCount(param1:int, param2:int) : void
      {
         UnknownVarFromHabboUnseenItemsUpdatedEvent_Dictionary_1[param1.toString()] = param2;
      }
      
      public function getCategoryCount(param1:int) : int
      {
         return UnknownVarFromHabboUnseenItemsUpdatedEvent_Dictionary_1[param1.toString()];
      }
      
      public function set inventoryCount(param1:int) : void
      {
         _inventoryCount = param1;
      }
      
      public function get inventoryCount() : int
      {
         return _inventoryCount;
      }
   }
}

