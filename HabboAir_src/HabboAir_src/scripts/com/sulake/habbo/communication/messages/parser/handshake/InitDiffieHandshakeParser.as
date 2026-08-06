package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InitDiffieHandshakeParser implements IMessageParser
   {
      private var _encryptedPrime:String;
      
      private var _encryptedGenerator:String;
      
      public function InitDiffieHandshakeParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _encryptedPrime = param1.readString();
         _encryptedGenerator = param1.readString();
         return true;
      }
      
      public function get encryptedPrime() : String
      {
         return _encryptedPrime;
      }
      
      public function get encryptedGenerator() : String
      {
         return _encryptedGenerator;
      }
   }
}

