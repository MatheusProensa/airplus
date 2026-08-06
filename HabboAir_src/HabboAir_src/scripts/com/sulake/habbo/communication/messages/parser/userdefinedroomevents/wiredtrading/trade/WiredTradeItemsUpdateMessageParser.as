package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;
   
   [SecureSWF(rename="true")]
   public class WiredTradeItemsUpdateMessageParser implements IMessageParser
   {
      private var _tradingItems:TradingItemListParser = new TradingItemListParser();
      
      private var _canAccept:Boolean;
      
      private var _extra:int;
      
      public function WiredTradeItemsUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _tradingItems.flush();
         _canAccept = false;
         _extra = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _tradingItems.parse(param1);
         _canAccept = param1.readBoolean();
         _extra = param1.readInteger();
         return true;
      }
      
      public function get tradingItems() : TradingItemListParser
      {
         return _tradingItems;
      }
      
      public function get canAccept() : Boolean
      {
         return _canAccept;
      }
      
      public function get extra() : int
      {
         return _extra;
      }
   }
}

