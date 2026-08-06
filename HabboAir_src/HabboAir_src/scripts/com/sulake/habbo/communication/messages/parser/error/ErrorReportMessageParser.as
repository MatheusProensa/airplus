package com.sulake.habbo.communication.messages.parser.error
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ErrorReportMessageParser implements IMessageParser
   {
      private var _errorCode:int;
      
      private var _messageId:int;
      
      private var _timestamp:String;
      
      public function ErrorReportMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _messageId = param1.readInteger();
         _errorCode = param1.readInteger();
         _timestamp = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         _errorCode = 0;
         _messageId = 0;
         _timestamp = null;
         return true;
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
      
      public function get messageId() : int
      {
         return _messageId;
      }
      
      public function get timestamp() : String
      {
         return _timestamp;
      }
   }
}

