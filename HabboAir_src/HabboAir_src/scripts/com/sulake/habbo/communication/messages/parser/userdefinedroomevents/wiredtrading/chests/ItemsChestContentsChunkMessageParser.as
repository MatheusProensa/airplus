package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestStorage;
   
   [SecureSWF(rename="true")]
   public class ItemsChestContentsChunkMessageParser implements IMessageParser
   {
      private var _chestId:int;
      
      private var _totalFragments:int;
      
      private var _fragmentNo:int;
      
      private var _storageChunk:Vector.<ChestStorage>;
      
      public function ItemsChestContentsChunkMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chestId = 0;
         _totalFragments = 0;
         _fragmentNo = 0;
         _storageChunk = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _chestId = param1.readInteger();
         _totalFragments = param1.readInteger();
         _fragmentNo = param1.readInteger();
         _storageChunk = new Vector.<ChestStorage>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _storageChunk.push(new ChestStorage(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get chestId() : int
      {
         return _chestId;
      }
      
      public function get totalFragments() : int
      {
         return _totalFragments;
      }
      
      public function get fragmentNo() : int
      {
         return _fragmentNo;
      }
      
      public function get storageChunk() : Vector.<ChestStorage>
      {
         return _storageChunk;
      }
   }
}

