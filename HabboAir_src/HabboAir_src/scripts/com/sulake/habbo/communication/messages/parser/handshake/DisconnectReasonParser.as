package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DisconnectReasonParser implements IMessageParser
   {
      private var _reason:int;
      
      public function DisconnectReasonParser()
      {
         super();
         _reason = -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1.bytesAvailable)
         {
            _reason = param1.readInteger();
         }
         return true;
      }
      
      public function get reason() : int
      {
         return _reason;
      }
   }
}

