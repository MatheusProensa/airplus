package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintTokenCountMessageEventParser implements IMessageParser
   {
      private var _totalTokens:int = 0;
      
      public function CollectibleMintTokenCountMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _totalTokens = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _totalTokens = param1.readInteger();
         return true;
      }
      
      public function get totalTokens() : int
      {
         return _totalTokens;
      }
   }
}

