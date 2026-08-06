package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CompleteDiffieHandshakeParser implements IMessageParser
   {
      private var _encryptedPublicKey:String;
      
      private var _serverClientEncryption:Boolean = false;
      
      public function CompleteDiffieHandshakeParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _encryptedPublicKey = param1.readString();
         if(param1.bytesAvailable)
         {
            _serverClientEncryption = param1.readBoolean();
         }
         return true;
      }
      
      public function get encryptedPublicKey() : String
      {
         return _encryptedPublicKey;
      }
      
      public function get serverClientEncryption() : Boolean
      {
         return _serverClientEncryption;
      }
   }
}

