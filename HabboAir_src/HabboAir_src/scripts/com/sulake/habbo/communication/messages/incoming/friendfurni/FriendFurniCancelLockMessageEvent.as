package com.sulake.habbo.communication.messages.incoming.friendfurni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniCancelLockMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniCancelLockMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function FriendFurniCancelLockMessageEvent(param1:Function)
      {
         super(param1,FriendFurniCancelLockMessageParser);
      }
      
      public function getParser() : FriendFurniCancelLockMessageParser
      {
         return _parser as FriendFurniCancelLockMessageParser;
      }
   }
}

