package com.sulake.habbo.communication.messages.parser.tracking
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LatencyPingResponseMessageParser implements IMessageParser
   {
      private var _requestId:int;
      
      public function LatencyPingResponseMessageParser()
      {
         super();
      }
      
      public function get requestId() : int
      {
         return _requestId;
      }
      
      public function flush() : Boolean
      {
         _requestId = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _requestId = param1.readInteger();
         return true;
      }
   }
}

