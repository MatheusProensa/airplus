package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   
   [SecureSWF(rename="true")]
   public class FriendsListFragmentMessageParser implements IMessageParser
   {
      protected var _totalFragments:int;
      
      protected var _fragmentNo:int;
      
      private var _friendFragment:Array;
      
      public function FriendsListFragmentMessageParser()
      {
         super();
      }
      
      public function get totalFragments() : int
      {
         return _totalFragments;
      }
      
      public function get fragmentNo() : int
      {
         return _fragmentNo;
      }
      
      public function get friendFragment() : Array
      {
         return _friendFragment;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _totalFragments = param1.readInteger();
         _fragmentNo = param1.readInteger();
         _friendFragment = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._friendFragment.push(new FriendData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _friendFragment = [];
         return true;
      }
   }
}

