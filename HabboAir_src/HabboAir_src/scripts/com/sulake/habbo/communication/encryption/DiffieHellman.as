package com.sulake.habbo.communication.encryption
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.communication.handshake.UnknownICoreCommunicationHandshake1;
   
   public class DiffieHellman implements UnknownICoreCommunicationHandshake1
   {
      private var _privateKey:BigInteger;
      
      private var _publicKey:BigInteger;
      
      private var _serverPublicKey:BigInteger;
      
      private var _sharedKey:BigInteger;
      
      private var _prime:BigInteger;
      
      private var UnknownVarFromDiffieHellman_BigInteger_1:BigInteger;
      
      private var _minimumPublicKey:BigInteger = BigInteger.nbv(2);
      
      private var UnknownVarFromDiffieHellman_BigInteger_2:BigInteger = BigInteger.nbv(2);
      
      public function DiffieHellman(param1:BigInteger, param2:BigInteger)
      {
         super();
         _prime = param1;
         UnknownVarFromDiffieHellman_BigInteger_1 = param2;
      }
      
      public function init(param1:String, param2:uint = 16) : Boolean
      {
         _privateKey = new BigInteger();
         _privateKey.fromRadix(param1,param2);
         _publicKey = UnknownVarFromDiffieHellman_BigInteger_1.modPow(_privateKey,_prime);
         return true;
      }
      
      public function generateSharedKey(param1:String, param2:uint = 16) : String
      {
         _serverPublicKey = new BigInteger();
         _serverPublicKey.fromRadix(param1,param2);
         _sharedKey = _serverPublicKey.modPow(_privateKey,_prime);
         return getSharedKey(param2);
      }
      
      public function getPublicKey(param1:uint = 16) : String
      {
         return _publicKey.toRadix(param1);
      }
      
      public function getSharedKey(param1:uint = 16) : String
      {
         return _sharedKey.toRadix(param1);
      }
      
      public function isValidServerPublicKey() : Boolean
      {
         return _serverPublicKey.compareTo(_minimumPublicKey) >= 0;
      }
      
      public function isValidSharedKey() : Boolean
      {
         return _sharedKey.compareTo(UnknownVarFromDiffieHellman_BigInteger_2) >= 0;
      }
   }
}

