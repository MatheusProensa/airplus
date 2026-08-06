package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftCollectionsMessageEventParser implements IMessageParser
   {
      private var _nftCollections:Array;
      
      public function NftCollectionsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _nftCollections = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _nftCollections = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _nftCollections.push(new NftCollection(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get nftCollections() : Array
      {
         return _nftCollections;
      }
   }
}

