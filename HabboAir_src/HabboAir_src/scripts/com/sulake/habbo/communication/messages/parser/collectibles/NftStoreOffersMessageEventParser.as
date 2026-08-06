package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftStoreOffersMessageEventParser implements IMessageParser
   {
      private var _nftStoreOffers:Array;
      
      public function NftStoreOffersMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _nftStoreOffers = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _nftStoreOffers = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _nftStoreOffers.push(new NftStoreOffer(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get nftStoreOffers() : Array
      {
         return _nftStoreOffers;
      }
   }
}

