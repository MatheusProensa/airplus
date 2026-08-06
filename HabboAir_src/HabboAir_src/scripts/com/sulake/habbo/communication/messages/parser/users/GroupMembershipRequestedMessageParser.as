package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.MemberData;
   
   [SecureSWF(rename="true")]
   public class GroupMembershipRequestedMessageParser implements IMessageParser
   {
      private var _groupId:int;
      
      private var _requester:MemberData;
      
      public function GroupMembershipRequestedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _requester = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         _requester = new MemberData(param1);
         return true;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get requester() : MemberData
      {
         return _requester;
      }
   }
}

