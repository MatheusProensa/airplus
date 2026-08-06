package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendsListFragmentMessageParser;
   import flash.utils.Dictionary;
   
   public class FriendList
   {
      private var UnknownVarFromFriendList_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromFriendList_Array_1:Array;
      
      public function FriendList()
      {
         super();
      }
      
      public function onFriendsListFragment(param1:IMessageEvent) : void
      {
         var _loc2_:FriendsListFragmentMessageParser = (param1 as FriendListFragmentMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         for each(var _loc3_ in _loc2_.friendFragment)
         {
            UnknownVarFromFriendList_Dictionary_1[_loc3_.id] = _loc3_.name;
         }
      }
      
      public function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:FriendListUpdateMessageParser = (param1 as FriendListUpdateEvent).getParser();
         for each(var _loc3_ in _loc2_.removedFriendIds)
         {
            UnknownVarFromFriendList_Dictionary_1[_loc3_] = null;
         }
         for each(var _loc4_ in _loc2_.addedFriends)
         {
            UnknownVarFromFriendList_Dictionary_1[_loc4_.id] = _loc4_.name;
         }
         UnknownVarFromFriendList_Array_1 = _loc2_.removedFriendIds.length > 0 || _loc2_.addedFriends.length > 0 ? null : UnknownVarFromFriendList_Array_1;
      }
      
      public function get list() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         if(UnknownVarFromFriendList_Array_1 == null)
         {
            UnknownVarFromFriendList_Array_1 = [];
            for(var _loc1_ in UnknownVarFromFriendList_Dictionary_1)
            {
               _loc3_ = int(_loc1_);
               _loc2_ = UnknownVarFromFriendList_Dictionary_1[_loc3_];
               if(_loc2_ != null)
               {
                  UnknownVarFromFriendList_Array_1.push(new FriendEntryData(_loc3_,_loc2_));
               }
            }
            UnknownVarFromFriendList_Array_1.sortOn("userName",1);
         }
         return UnknownVarFromFriendList_Array_1;
      }
   }
}

