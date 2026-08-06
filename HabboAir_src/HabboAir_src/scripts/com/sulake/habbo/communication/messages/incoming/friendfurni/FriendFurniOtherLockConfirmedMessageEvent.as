package com.sulake.habbo.communication.messages.incoming.friendfurni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniOtherLockConfirmedMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniOtherLockConfirmedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function FriendFurniOtherLockConfirmedMessageEvent(param1:Function)
      {
         super(param1,FriendFurniOtherLockConfirmedMessageParser);
      }
      
      public function getParser() : FriendFurniOtherLockConfirmedMessageParser
      {
         return _parser as FriendFurniOtherLockConfirmedMessageParser;
      }
   }
}

