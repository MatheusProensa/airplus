package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredContractUpdateResultMessageParser implements IMessageParser
   {
      private var _contractId:int;
      
      private var _isSuccess:Boolean;
      
      private var _failCode:String;
      
      public function WiredContractUpdateResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _contractId = 0;
         _isSuccess = false;
         _failCode = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _contractId = param1.readInteger();
         _isSuccess = param1.readBoolean();
         _failCode = param1.readString();
         return true;
      }
      
      public function get contractId() : int
      {
         return _contractId;
      }
      
      public function get isSuccess() : Boolean
      {
         return _isSuccess;
      }
      
      public function get failCode() : String
      {
         return _failCode;
      }
   }
}

