package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.AcceptFriendResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class AcceptFriendResultEvent extends MessageEvent implements IMessageEvent
   {
      public function AcceptFriendResultEvent(param1:Function)
      {
         super(param1,AcceptFriendResultMessageParser);
      }
      
      public function getParser() : AcceptFriendResultMessageParser
      {
         return this._parser as AcceptFriendResultMessageParser;
      }
   }
}

