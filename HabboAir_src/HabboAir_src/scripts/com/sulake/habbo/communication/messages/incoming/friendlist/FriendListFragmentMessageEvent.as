package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendsListFragmentMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendListFragmentMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function FriendListFragmentMessageEvent(param1:Function)
      {
         super(param1,FriendsListFragmentMessageParser);
      }
      
      public function getParser() : FriendsListFragmentMessageParser
      {
         return this._parser as FriendsListFragmentMessageParser;
      }
   }
}

