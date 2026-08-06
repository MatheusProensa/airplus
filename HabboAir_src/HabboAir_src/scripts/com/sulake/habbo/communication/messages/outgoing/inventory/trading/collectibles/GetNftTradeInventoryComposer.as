package com.sulake.habbo.communication.messages.outgoing.inventory.trading.collectibles
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetNftTradeInventoryComposer implements IMessageComposer
   {
      public function GetNftTradeInventoryComposer()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
   }
}

