package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftBonusItemClaimResultMessageEventParser implements IMessageParser
   {
      private var _collectionId:String;
      
      private var _walletAddress:String;
      
      private var _success:Boolean;
      
      public function NftBonusItemClaimResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _collectionId = param1.readString();
         _walletAddress = param1.readString();
         _success = param1.readBoolean();
         return true;
      }
      
      public function get collectionId() : String
      {
         return _collectionId;
      }
      
      public function get walletAddress() : String
      {
         return _walletAddress;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
   }
}

