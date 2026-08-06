package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class NftWardrobeItem
   {
      private var _id:String;
      
      private var _gender:String;
      
      private var _figureString:String;
      
      private var _tokenId:String;
      
      private var _contractKey:String;
      
      public function NftWardrobeItem(param1:IMessageDataWrapper)
      {
         super();
         _id = param1.readString();
         _figureString = param1.readString();
         _gender = param1.readString();
         _tokenId = param1.readString();
         _contractKey = param1.readString();
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
      
      public function get contractKey() : String
      {
         return _contractKey;
      }
      
      public function get tokenId() : String
      {
         return _tokenId;
      }
   }
}

