package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
   
   [SecureSWF(rename="true")]
   public class NewFriendRequestMessageParser implements IMessageParser
   {
      private var UnknownVarFromNewFriendRequestMessageParser_FriendRequestData_1:FriendRequestData;
      
      public function NewFriendRequestMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.UnknownVarFromNewFriendRequestMessageParser_FriendRequestData_1 = new FriendRequestData(param1);
         return true;
      }
      
      public function get req() : FriendRequestData
      {
         return this.UnknownVarFromNewFriendRequestMessageParser_FriendRequestData_1;
      }
   }
}

