package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceCancelAllOffersResultParser implements IMessageParser
   {
      private var _offerIds:Vector.<int>;
      
      private var _success:Boolean;
      
      public function MarketplaceCancelAllOffersResultParser()
      {
         super();
      }
      
      public function get offerIds() : Vector.<int>
      {
         return _offerIds;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function flush() : Boolean
      {
         _offerIds = null;
         _success = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _offerIds = new Vector.<int>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _offerIds.push(param1.readInteger());
            _loc3_++;
         }
         _success = param1.readBoolean();
         return true;
      }
   }
}

