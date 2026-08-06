package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GroupDetailsChangedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GroupDetailsChangedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GroupDetailsChangedMessageEvent(param1:Function)
      {
         super(param1,GroupDetailsChangedMessageParser);
      }
      
      public function get groupId() : int
      {
         return GroupDetailsChangedMessageParser(_parser).groupId;
      }
   }
}

