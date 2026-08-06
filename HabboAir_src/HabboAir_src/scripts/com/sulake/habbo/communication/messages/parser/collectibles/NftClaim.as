package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class NftClaim
   {
      private var _claimId:String;
      
      private var _status:int;
      
      private var _claimedAmount:int;
      
      private var _claimLimit:int;
      
      private var _validFrom:Number;
      
      private var _validTo:Number;
      
      private var _createdAt:Number;
      
      private var _updatedAt:Number;
      
      private var _collection:String;
      
      private var _productCode:String;
      
      private var _wallet:String;
      
      private var _claimItem:ClaimItem;
      
      public function NftClaim(param1:IMessageDataWrapper)
      {
         super();
         _claimId = param1.readString();
         _status = param1.readInteger();
         _claimedAmount = param1.readInteger();
         _claimLimit = param1.readInteger();
         _validFrom = param1.readLong();
         _validTo = param1.readLong();
         _createdAt = param1.readLong();
         _updatedAt = param1.readLong();
         _collection = param1.readString();
         _productCode = param1.readString();
         _wallet = param1.readString();
         _claimItem = new ClaimItem(param1);
      }
      
      public function get claimId() : String
      {
         return _claimId;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get claimedAmount() : int
      {
         return _claimedAmount;
      }
      
      public function get claimLimit() : int
      {
         return _claimLimit;
      }
      
      public function get validFrom() : Number
      {
         return _validFrom;
      }
      
      public function get validTo() : Number
      {
         return _validTo;
      }
      
      public function get createdAt() : Number
      {
         return _createdAt;
      }
      
      public function get updatedAt() : Number
      {
         return _updatedAt;
      }
      
      public function get collection() : String
      {
         return _collection;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get wallet() : String
      {
         return _wallet;
      }
      
      public function get claimItem() : ClaimItem
      {
         return _claimItem;
      }
   }
}

