package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   
   public class WiredTransactionDetails
   {
      private var _transactionInfo:WiredTransactionInfo;
      
      private var _chestIds:Vector.<int>;
      
      private var _depositedFurnis:Map;
      
      private var _withdrawnFurnis:Map;
      
      private var _isIncompleteData:Boolean;
      
      public function WiredTransactionDetails(param1:IMessageDataWrapper)
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ChestItemType = null;
         var _loc3_:int = 0;
         super();
         _transactionInfo = new WiredTransactionInfo(param1);
         _chestIds = new Vector.<int>();
         _loc4_ = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _chestIds.push(param1.readInteger());
            _loc5_++;
         }
         _depositedFurnis = new Map();
         _withdrawnFurnis = new Map();
         _loc4_ = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = ChestItemType.readFromMessage(param1);
            _loc3_ = param1.readInteger();
            _depositedFurnis.add(_loc2_,_loc3_);
            _loc5_++;
         }
         _loc4_ = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = ChestItemType.readFromMessage(param1);
            _loc3_ = param1.readInteger();
            _withdrawnFurnis.add(_loc2_,_loc3_);
            _loc5_++;
         }
         _isIncompleteData = param1.readBoolean();
      }
      
      public function get transactionInfo() : WiredTransactionInfo
      {
         return _transactionInfo;
      }
      
      public function get chestIds() : Vector.<int>
      {
         return _chestIds;
      }
      
      public function get depositedFurnis() : Map
      {
         return _depositedFurnis;
      }
      
      public function get withdrawnFurnis() : Map
      {
         return _withdrawnFurnis;
      }
      
      public function get isIncompleteData() : Boolean
      {
         return _isIncompleteData;
      }
   }
}

