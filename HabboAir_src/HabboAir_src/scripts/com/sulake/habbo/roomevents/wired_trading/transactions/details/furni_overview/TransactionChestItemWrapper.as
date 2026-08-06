package com.sulake.habbo.roomevents.wired_trading.transactions.details.furni_overview
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.IChestStorage;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.EmptyStuffData;
   
   public class TransactionChestItemWrapper implements IChestStorage
   {
      private static const EMPTY_STUFF_DATA:IStuffData = new EmptyStuffData();
      
      private var _type:ChestItemType;
      
      public function TransactionChestItemWrapper(param1:ChestItemType)
      {
         super();
         _type = param1;
      }
      
      public function get type() : ChestItemType
      {
         return _type;
      }
      
      public function get specialType() : int
      {
         return 1;
      }
      
      public function get stuffData() : IStuffData
      {
         return EMPTY_STUFF_DATA;
      }
   }
}

