package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendRequestsMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendRequestsEvent extends MessageEvent implements IMessageEvent
   {
      public function FriendRequestsEvent(param1:Function)
      {
         super(param1,FriendRequestsMessageParser);
      }
      
      public function getParser() : FriendRequestsMessageParser
      {
         return this._parser as FriendRequestsMessageParser;
      }
   }
}

