package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftTransferFeeMessageEventParser implements IMessageParser
   {
      private var _transferFee:int = 0;
      
      public function NftTransferFeeMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _transferFee = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _transferFee = param1.readInteger();
         return true;
      }
      
      public function get transferFee() : int
      {
         return _transferFee;
      }
   }
}

