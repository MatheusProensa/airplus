package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftStorePurchaseMessageEventParser implements IMessageParser
   {
      public static var UnknownVarFromNftStorePurchaseMessageEventParser_Int_1:int = 0;
      
      public static var UnknownVarFromNftStorePurchaseMessageEventParser_Int_2:int = 1;
      
      private var _result:int;
      
      public function NftStorePurchaseMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _result = param1.readShort();
         return true;
      }
      
      public function get result() : int
      {
         return _result;
      }
   }
}

