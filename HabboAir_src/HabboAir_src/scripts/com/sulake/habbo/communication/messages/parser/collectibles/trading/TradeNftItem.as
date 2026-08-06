package com.sulake.habbo.communication.messages.parser.collectibles.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleBaseItem;
   
   [SecureSWF(rename="true")]
   public class TradeNftItem extends CollectibleBaseItem
   {
      private var _assetId:Number;
      
      public function TradeNftItem(param1:IMessageDataWrapper)
      {
         _assetId = param1.readLong();
         super(param1);
      }
      
      public function get assetId() : Number
      {
         return _assetId;
      }
   }
}

