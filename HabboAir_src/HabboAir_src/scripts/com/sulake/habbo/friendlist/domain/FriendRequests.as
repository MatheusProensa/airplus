package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.Util;
   
   public class FriendRequests
   {
      private var UnknownVarFromFriendRequests_IFriendRequestsDeps_1_1:IFriendRequestsDeps_1;
      
      private var _requests:Array = [];
      
      private var _limit:int;
      
      private var _clubLimit:int;
      
      public function FriendRequests(param1:IFriendRequestsDeps_1, param2:int, param3:int)
      {
         super();
         UnknownVarFromFriendRequests_IFriendRequestsDeps_1_1 = param1;
         _limit = param2;
         _clubLimit = param3;
      }
      
      public function clearAndUpdateView(param1:Boolean) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _requests)
         {
            if(!param1 || _loc2_.state != 1)
            {
               _loc3_.push(_loc2_);
            }
         }
         for each(var _loc4_ in _loc3_)
         {
            Util.remove(_requests,_loc4_);
            if(UnknownVarFromFriendRequests_IFriendRequestsDeps_1_1.view != null)
            {
               UnknownVarFromFriendRequests_IFriendRequestsDeps_1_1.view.removeRequest(_loc4_);
            }
            _loc4_.dispose();
         }
         refreshShading();
      }
      
      public function acceptFailed(param1:int) : void
      {
         var _loc2_:FriendRequest = getRequestByRequesterId(param1);
         if(_loc2_ == null)
         {
            Logger.log("Failed to accept friend request from " + param1 + ", error retrieving the friendrequest.");
            return;
         }
         _loc2_.state = 4;
         UnknownVarFromFriendRequests_IFriendRequestsDeps_1_1.view.refreshRequestEntry(_loc2_);
      }
      
      public function addRequest(param1:FriendRequest) : void
      {
         _requests.push(param1);
      }
      
      public function addRequestAndUpdateView(param1:FriendRequest) : void
      {
         _requests.push(param1);
         UnknownVarFromFriendRequests_IFriendRequestsDeps_1_1.view.addRequest(param1);
      }
      
      public function getRequest(param1:int) : FriendRequest
      {
         for each(var _loc2_ in _requests)
         {
            if(_loc2_.requestId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getRequestByRequesterId(param1:int) : FriendRequest
      {
         for each(var _loc2_ in _requests)
         {
            if(_loc2_.requesterUserId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function refreshShading() : void
      {
         var _loc1_:* = true;
         for each(var _loc2_ in _requests)
         {
            _loc1_ = !_loc1_;
            UnknownVarFromFriendRequests_IFriendRequestsDeps_1_1.view.refreshShading(_loc2_,_loc1_);
         }
      }
      
      public function getCountOfOpenRequests() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in requests)
         {
            if(_loc2_.state == 1)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get requests() : Array
      {
         return _requests;
      }
      
      public function get limit() : int
      {
         return _limit;
      }
      
      public function get clubLimit() : int
      {
         return _clubLimit;
      }
      
      public function set limit(param1:int) : void
      {
         _limit = param1;
      }
   }
}

