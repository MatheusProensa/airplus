package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredOpenContractMessageParser implements IMessageParser
   {
      private var _contractId:int;
      
      public function WiredOpenContractMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _contractId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _contractId = param1.readInteger();
         return true;
      }
      
      public function get contractId() : int
      {
         return _contractId;
      }
   }
}

