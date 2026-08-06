package com.sulake.habbo.communication.messages.parser.collectibles.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetInventoryMessageParser implements IMessageParser
   {
      private var _items:Vector.<TradeNftItem>;
      
      public function TradeNftAssetInventoryMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _items = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _items = new Vector.<TradeNftItem>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _items.push(new TradeNftItem(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get items() : Vector.<TradeNftItem>
      {
         return _items;
      }
   }
}

