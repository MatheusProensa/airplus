package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MessengerErrorMessageParser implements IMessageParser
   {
      private var UnknownVarFromMessengerErrorMessageParser_Int_1:int;
      
      private var _errorCode:int;
      
      public function MessengerErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.UnknownVarFromMessengerErrorMessageParser_Int_1 = param1.readInteger();
         this._errorCode = param1.readInteger();
         return true;
      }
      
      public function get clientMessageId() : int
      {
         return this.UnknownVarFromMessengerErrorMessageParser_Int_1;
      }
      
      public function get errorCode() : int
      {
         return this._errorCode;
      }
   }
}

