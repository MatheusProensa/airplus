package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
   
   [SecureSWF(rename="true")]
   public class FriendRequestsMessageParser implements IMessageParser
   {
      private var UnknownVarFromFriendRequestsMessageParser_Int_1:int;
      
      private var UnknownVarFromFriendRequestsMessageParser_Array_1:Array;
      
      public function FriendRequestsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.UnknownVarFromFriendRequestsMessageParser_Array_1 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         this.UnknownVarFromFriendRequestsMessageParser_Int_1 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         Logger.log("Received friend requests: " + UnknownVarFromFriendRequestsMessageParser_Int_1 + ", " + _loc2_);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.UnknownVarFromFriendRequestsMessageParser_Array_1.push(new FriendRequestData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get totalReqCount() : int
      {
         return this.UnknownVarFromFriendRequestsMessageParser_Int_1;
      }
      
      public function get reqs() : Array
      {
         return this.UnknownVarFromFriendRequestsMessageParser_Array_1;
      }
   }
}

