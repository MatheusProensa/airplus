package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.BlockListMessageParser;
   
   [SecureSWF(rename="true")]
   public class BlockListMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function BlockListMessageEvent(param1:Function)
      {
         super(param1,BlockListMessageParser);
      }
      
      public function get blockedUserIds() : Array
      {
         return (_parser as BlockListMessageParser).blockedUsers;
      }
   }
}

