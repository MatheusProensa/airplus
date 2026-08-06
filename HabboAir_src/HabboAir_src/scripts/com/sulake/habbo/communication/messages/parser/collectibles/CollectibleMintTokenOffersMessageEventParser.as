package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintTokenOffersMessageEventParser implements IMessageParser
   {
      private var _tokenOffers:Vector.<MintTokenOffer>;
      
      public function CollectibleMintTokenOffersMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _tokenOffers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:MintTokenOffer = null;
         _tokenOffers = new Vector.<MintTokenOffer>();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new MintTokenOffer(param1);
            _tokenOffers.push(_loc2_);
            _loc4_++;
         }
         return true;
      }
      
      public function get tokenOffers() : Vector.<MintTokenOffer>
      {
         return _tokenOffers;
      }
   }
}

