package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ApproveNameMessageParser implements IMessageParser
   {
      private var _result:int;
      
      private var _nameValidationInfo:String;
      
      public function ApproveNameMessageParser()
      {
         super();
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function get nameValidationInfo() : String
      {
         return _nameValidationInfo;
      }
      
      public function flush() : Boolean
      {
         _result = -1;
         _nameValidationInfo = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _result = param1.readInteger();
         _nameValidationInfo = param1.readString();
         return true;
      }
   }
}

