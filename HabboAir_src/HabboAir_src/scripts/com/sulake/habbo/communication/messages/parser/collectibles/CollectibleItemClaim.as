package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CollectibleItemClaim
   {
      public static var UnknownVarFromCollectibleItemClaim_Int_1:int = 0;
      
      public static var UnknownVarFromCollectibleItemClaim_Int_2:int = 1;
      
      private var _claimId:String;
      
      private var _claimedAmount:int;
      
      private var _claimLimit:int;
      
      private var _status:int;
      
      public function CollectibleItemClaim(param1:IMessageDataWrapper)
      {
         super();
         _claimId = param1.readString();
         _claimedAmount = param1.readInteger();
         _claimLimit = param1.readInteger();
         _status = param1.readShort();
      }
      
      public function get claimId() : String
      {
         return _claimId;
      }
      
      public function get claimedAmount() : int
      {
         return _claimedAmount;
      }
      
      public function set claimedAmount(param1:int) : void
      {
         _claimedAmount = param1;
      }
      
      public function get claimLimit() : int
      {
         return _claimLimit;
      }
      
      public function get status() : int
      {
         return _status;
      }
   }
}

