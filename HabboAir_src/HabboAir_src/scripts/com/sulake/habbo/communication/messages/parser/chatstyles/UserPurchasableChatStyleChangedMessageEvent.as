package com.sulake.habbo.communication.messages.parser.chatstyles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class UserPurchasableChatStyleChangedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UserPurchasableChatStyleChangedMessageEvent(param1:Function)
      {
         super(param1,UserPurchasableChatStyleChangedMessageParser);
      }
      
      public function getParser() : UserPurchasableChatStyleChangedMessageParser
      {
         return _parser as UserPurchasableChatStyleChangedMessageParser;
      }
   }
}

