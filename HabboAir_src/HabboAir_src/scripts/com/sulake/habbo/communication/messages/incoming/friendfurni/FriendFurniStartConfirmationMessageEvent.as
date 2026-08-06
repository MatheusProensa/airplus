package com.sulake.habbo.communication.messages.incoming.friendfurni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendfurni.FriendFurniStartConfirmationMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniStartConfirmationMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function FriendFurniStartConfirmationMessageEvent(param1:Function)
      {
         super(param1,FriendFurniStartConfirmationMessageParser);
      }
      
      public function getParser() : FriendFurniStartConfirmationMessageParser
      {
         return _parser as FriendFurniStartConfirmationMessageParser;
      }
   }
}

