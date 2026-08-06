package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectibleWalletAddressesMessageEventParser implements IMessageParser
   {
      private var _stardustWalletAddress:String;
      
      private var _walletAddresses:Array;
      
      public function CollectibleWalletAddressesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stardustWalletAddress = null;
         _walletAddresses = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _stardustWalletAddress = param1.readString();
         _walletAddresses = [];
         if(_stardustWalletAddress != "")
         {
            _walletAddresses.push(_stardustWalletAddress);
         }
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _walletAddresses.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get walletAddresses() : Array
      {
         return _walletAddresses;
      }
      
      public function get stardustWalletAddress() : String
      {
         return _stardustWalletAddress;
      }
   }
}

