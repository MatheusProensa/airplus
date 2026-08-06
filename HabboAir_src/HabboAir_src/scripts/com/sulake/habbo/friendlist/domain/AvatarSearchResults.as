package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
   import flash.utils.Dictionary;
   
   public class AvatarSearchResults
   {
      private var UnknownVarFromAvatarSearchResults_IFriendRequestsDeps_2_1:IFriendRequestsDeps_2;
      
      private var _friends:Array;
      
      private var _others:Array;
      
      private var UnknownVarFromAvatarSearchResults_Dictionary_1:Dictionary = new Dictionary();
      
      public function AvatarSearchResults(param1:IFriendRequestsDeps_2)
      {
         super();
         UnknownVarFromAvatarSearchResults_IFriendRequestsDeps_2_1 = param1;
      }
      
      public function getResult(param1:int) : HabboSearchResultData
      {
         for each(var _loc3_ in _friends)
         {
            if(_loc3_.avatarId == param1)
            {
               return _loc3_;
            }
         }
         for each(var _loc2_ in _others)
         {
            if(_loc2_.avatarId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function searchReceived(param1:Array, param2:Array) : void
      {
         _friends = param1;
         _others = param2;
         UnknownVarFromAvatarSearchResults_IFriendRequestsDeps_2_1.view.refreshList();
      }
      
      public function get friends() : Array
      {
         return _friends;
      }
      
      public function get others() : Array
      {
         return _others;
      }
      
      public function setFriendRequestSent(param1:int) : void
      {
         UnknownVarFromAvatarSearchResults_Dictionary_1[param1] = "yes";
      }
      
      public function isFriendRequestSent(param1:int) : Boolean
      {
         return UnknownVarFromAvatarSearchResults_Dictionary_1[param1] != null;
      }
   }
}

