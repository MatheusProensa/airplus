package com.sulake.habbo.communication.messages.parser.chatstyles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class UserNftChatStylesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UserNftChatStylesMessageEvent(param1:Function)
      {
         super(param1,UserNftChatStylesMessageParser);
      }
      
      public function getParser() : UserNftChatStylesMessageParser
      {
         return _parser as UserNftChatStylesMessageParser;
      }
   }
}

