package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AddItemsToTradeComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function AddItemsToTradeComposer(param1:Vector.<int>)
      {
         super();
         _messageArray.push(param1.length);
         for each(var _loc2_ in param1)
         {
            _messageArray.push(_loc2_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
      }
   }
}

