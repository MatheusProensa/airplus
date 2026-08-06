package com.sulake.habbo.communication.messages.parser.chatstyles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class UserPurchasableChatStylesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UserPurchasableChatStylesMessageEvent(param1:Function)
      {
         super(param1,UserPurchasableChatStylesMessageParser);
      }
      
      public function getParser() : UserPurchasableChatStylesMessageParser
      {
         return _parser as UserPurchasableChatStylesMessageParser;
      }
   }
}

