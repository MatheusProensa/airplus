package com.sulake.habbo.communication.messages.parser.collectibles.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetsMessageParser implements IMessageParser
   {
      private var _myItems:Vector.<TradeNftItem>;
      
      private var _theirItems:Vector.<TradeNftItem>;
      
      public function TradeNftAssetsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _myItems = null;
         _theirItems = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         _myItems = new Vector.<TradeNftItem>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _myItems.push(new TradeNftItem(param1));
            _loc3_++;
         }
         _theirItems = new Vector.<TradeNftItem>();
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _theirItems.push(new TradeNftItem(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get myItems() : Vector.<TradeNftItem>
      {
         return _myItems;
      }
      
      public function get theirItems() : Vector.<TradeNftItem>
      {
         return _theirItems;
      }
   }
}

