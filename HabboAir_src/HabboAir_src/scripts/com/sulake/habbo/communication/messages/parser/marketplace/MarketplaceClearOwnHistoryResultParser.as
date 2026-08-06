package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceClearOwnHistoryResultParser implements IMessageParser
   {
      private var _success:Boolean;
      
      public function MarketplaceClearOwnHistoryResultParser()
      {
         super();
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function flush() : Boolean
      {
         _success = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _success = param1.readBoolean();
         return true;
      }
   }
}

