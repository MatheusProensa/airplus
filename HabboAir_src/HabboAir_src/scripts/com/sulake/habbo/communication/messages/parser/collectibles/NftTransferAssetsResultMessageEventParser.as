package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftTransferAssetsResultMessageEventParser implements IMessageParser
   {
      private var _resultCode:*;
      
      public function NftTransferAssetsResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _resultCode = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _resultCode = param1.readShort();
         return true;
      }
      
      public function get success() : Boolean
      {
         return _resultCode == 0;
      }
      
      public function get resultCode() : *
      {
         return _resultCode;
      }
   }
}

