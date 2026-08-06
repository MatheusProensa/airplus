package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class NftCollection
   {
      public static var UnknownVarFromNftCollection_Int_1:int = 0;
      
      public static var UnknownVarFromNftCollection_Int_2:int = 1;
      
      public static var UnknownVarFromNftCollection_Int_3:int = 2;
      
      public static var UnknownVarFromNftCollection_Int_4:int = 0;
      
      public static var UnknownVarFromNftCollection_Int_5:int = 1;
      
      private var _items:Array;
      
      private var _collectionId:String;
      
      private var _collectionName:String;
      
      private var _collectionScore:int;
      
      private var _collectionTotalScore:int;
      
      private var _collectionBoostScore:int;
      
      private var _bonusItem:CollectibleItem;
      
      private var _rewardItem:CollectibleItem;
      
      private var _releasedTime:Number;
      
      private var _snapshotTime:Number;
      
      private var _status:int;
      
      private var _bonusItemClaim:CollectibleItemClaim;
      
      private var _rewardItemClaim:CollectibleItemClaim;
      
      private var _collectedItemCount:int;
      
      private var _claimingBonusStatus:int;
      
      private var _claimingRewardStatus:int;
      
      public function NftCollection(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         var _loc2_:CollectibleItem = null;
         _claimingBonusStatus = UnknownVarFromNftCollection_Int_4;
         _claimingRewardStatus = UnknownVarFromNftCollection_Int_4;
         super();
         var _loc6_:int = param1.readInteger();
         _items = [];
         _collectedItemCount = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            _loc2_ = new CollectibleItem(param1);
            _items.push(_loc2_);
            if(_loc2_.amount > 0)
            {
               _collectedItemCount += 1;
            }
            _loc3_++;
         }
         _collectionId = param1.readString();
         _collectionName = param1.readString();
         _collectionScore = param1.readInteger();
         _collectionTotalScore = param1.readInteger();
         _collectionBoostScore = param1.readInteger();
         var _loc4_:Boolean = param1.readBoolean();
         if(_loc4_)
         {
            _bonusItem = new CollectibleItem(param1);
         }
         var _loc5_:Boolean = param1.readBoolean();
         if(_loc5_)
         {
            _rewardItem = new CollectibleItem(param1);
         }
         _releasedTime = param1.readLong();
         _snapshotTime = param1.readLong();
         _status = param1.readShort();
         if(_loc4_)
         {
            _bonusItemClaim = new CollectibleItemClaim(param1);
         }
         if(_loc5_)
         {
            _rewardItemClaim = new CollectibleItemClaim(param1);
         }
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      public function get collectionId() : String
      {
         return _collectionId;
      }
      
      public function get collectionName() : String
      {
         return _collectionName;
      }
      
      public function get collectionScore() : int
      {
         return _collectionScore;
      }
      
      public function get collectionTotalScore() : int
      {
         return _collectionTotalScore;
      }
      
      public function get collectionBoostScore() : int
      {
         return _collectionBoostScore;
      }
      
      public function get bonusItem() : CollectibleItem
      {
         return _bonusItem;
      }
      
      public function get rewardItem() : CollectibleItem
      {
         return _rewardItem;
      }
      
      public function get releasedTime() : Number
      {
         return _releasedTime;
      }
      
      public function get snapshotTime() : Number
      {
         return _snapshotTime;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get bonusItemClaim() : CollectibleItemClaim
      {
         return _bonusItemClaim;
      }
      
      public function get rewardItemClaim() : CollectibleItemClaim
      {
         return _rewardItemClaim;
      }
      
      public function get collectedItemCount() : int
      {
         return _collectedItemCount;
      }
      
      public function get totalItemCount() : int
      {
         return _items.length;
      }
      
      public function get progressPercentage() : int
      {
         return collectedItemCount * 100 / totalItemCount;
      }
      
      public function get claimingBonusStatus() : int
      {
         return _claimingBonusStatus;
      }
      
      public function get claimingRewardStatus() : int
      {
         return _claimingRewardStatus;
      }
      
      public function claimRewardAwaiting() : void
      {
         _claimingRewardStatus = UnknownVarFromNftCollection_Int_5;
      }
      
      public function claimBonusAwaiting() : void
      {
         _claimingBonusStatus = UnknownVarFromNftCollection_Int_5;
      }
      
      public function claimRewardFinished(param1:Boolean) : void
      {
         _claimingRewardStatus = UnknownVarFromNftCollection_Int_4;
         if(param1)
         {
            rewardItemClaim.claimedAmount += 1;
         }
      }
      
      public function claimBonusFinished(param1:Boolean) : void
      {
         _claimingBonusStatus = UnknownVarFromNftCollection_Int_4;
         if(param1)
         {
            bonusItemClaim.claimedAmount += 1;
         }
      }
      
      public function get hasRewardItem() : Boolean
      {
         return _rewardItem != null;
      }
      
      public function get hasBonusItem() : Boolean
      {
         return _bonusItem != null;
      }
      
      public function get rewardClaimed() : Boolean
      {
         return hasRewardItem && _rewardItemClaim != null && (_rewardItemClaim.claimedAmount > 0 && _rewardItemClaim.claimedAmount >= _rewardItemClaim.claimLimit || _claimingRewardStatus == NftCollection.UnknownVarFromNftCollection_Int_5);
      }
      
      public function get bonusClaimed() : Boolean
      {
         return hasBonusItem && _bonusItemClaim != null && (_bonusItemClaim.claimedAmount > 0 && _bonusItemClaim.claimedAmount >= _bonusItemClaim.claimLimit || _claimingBonusStatus != NftCollection.UnknownVarFromNftCollection_Int_4);
      }
      
      public function get canClaimReward() : Boolean
      {
         return hasRewardItem && _rewardItemClaim != null && _rewardItemClaim.status == CollectibleItemClaim.UnknownVarFromCollectibleItemClaim_Int_1 && !rewardClaimed && _rewardItemClaim.claimedAmount < _rewardItemClaim.claimLimit && _claimingRewardStatus == NftCollection.UnknownVarFromNftCollection_Int_4;
      }
      
      public function get canClaimBonus() : Boolean
      {
         return hasBonusItem && _bonusItemClaim != null && _bonusItemClaim.status == CollectibleItemClaim.UnknownVarFromCollectibleItemClaim_Int_1 && !bonusClaimed && _bonusItemClaim.claimedAmount < _bonusItemClaim.claimLimit && _claimingBonusStatus == NftCollection.UnknownVarFromNftCollection_Int_4;
      }
      
      public function isBonusSnapshotPassed() : Boolean
      {
         return _snapshotTime < new Date().time;
      }
   }
}

