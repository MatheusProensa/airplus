package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleMintableItemResultMessageEventParser implements IMessageParser
   {
      public static var UnknownVarFromNftStorePurchaseMessageEventParser_Int_2:int = 0;
      
      public static var UnknownVarFromNftStorePurchaseMessageEventParser_Int_1:int = 1;
      
      public static var UnknownVarFromCollectibleMintableItemResultMessageEventParser_Int_1:int = 2;
      
      private var _mintResult:int;
      
      public function CollectibleMintableItemResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _mintResult = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _mintResult = param1.readShort();
         return true;
      }
      
      public function get mintResult() : int
      {
         return _mintResult;
      }
   }
}

