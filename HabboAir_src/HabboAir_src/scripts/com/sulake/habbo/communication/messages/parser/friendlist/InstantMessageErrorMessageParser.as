package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InstantMessageErrorMessageParser implements IMessageParser
   {
      private var _errorCode:int;
      
      private var UnknownVarFromInstantMessageErrorMessageParser_Int_1:int;
      
      private var UnknownVarFromInstantMessageErrorMessageParser_String_1:String;
      
      public function InstantMessageErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._errorCode = param1.readInteger();
         this.UnknownVarFromInstantMessageErrorMessageParser_Int_1 = param1.readInteger();
         this.UnknownVarFromInstantMessageErrorMessageParser_String_1 = param1.readString();
         return true;
      }
      
      public function get errorCode() : int
      {
         return this._errorCode;
      }
      
      public function get userId() : int
      {
         return this.UnknownVarFromInstantMessageErrorMessageParser_Int_1;
      }
      
      public function get message() : String
      {
         return this.UnknownVarFromInstantMessageErrorMessageParser_String_1;
      }
   }
}

