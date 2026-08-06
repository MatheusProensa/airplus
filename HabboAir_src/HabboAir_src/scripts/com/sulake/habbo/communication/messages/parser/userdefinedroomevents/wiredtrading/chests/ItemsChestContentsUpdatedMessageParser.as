package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestStorage;
   
   [SecureSWF(rename="true")]
   public class ItemsChestContentsUpdatedMessageParser implements IMessageParser
   {
      private var _chestId:int;
      
      private var _removedIds:Vector.<int>;
      
      private var _addedStorage:Vector.<ChestStorage>;
      
      public function ItemsChestContentsUpdatedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chestId = 0;
         _removedIds = null;
         _addedStorage = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         _chestId = param1.readInteger();
         _removedIds = new Vector.<int>();
         _addedStorage = new Vector.<ChestStorage>();
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _removedIds.push(param1.readInteger());
            _loc4_++;
         }
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _addedStorage.push(new ChestStorage(param1));
            _loc4_++;
         }
         return true;
      }
      
      public function get removedIds() : Vector.<int>
      {
         return _removedIds;
      }
      
      public function get addedStorage() : Vector.<ChestStorage>
      {
         return _addedStorage;
      }
      
      public function get chestId() : int
      {
         return _chestId;
      }
   }
}

