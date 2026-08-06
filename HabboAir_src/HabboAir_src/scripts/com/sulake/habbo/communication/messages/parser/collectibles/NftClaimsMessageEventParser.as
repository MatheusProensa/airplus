package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftClaimsMessageEventParser implements IMessageParser
   {
      private var _nftClaims:Array;
      
      public function NftClaimsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _nftClaims = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _nftClaims = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _nftClaims.push(new NftClaim(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get nftClaims() : Array
      {
         return _nftClaims;
      }
   }
}

