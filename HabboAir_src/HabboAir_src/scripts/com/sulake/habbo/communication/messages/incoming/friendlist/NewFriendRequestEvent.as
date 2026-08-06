package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewFriendRequestMessageParser;
   
   [SecureSWF(rename="true")]
   public class NewFriendRequestEvent extends MessageEvent implements IMessageEvent
   {
      public function NewFriendRequestEvent(param1:Function)
      {
         super(param1,NewFriendRequestMessageParser);
      }
      
      public function getParser() : NewFriendRequestMessageParser
      {
         return this._parser as NewFriendRequestMessageParser;
      }
   }
}

