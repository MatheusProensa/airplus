package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionStartedMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionStartedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ChatReviewSessionStartedMessageEvent(param1:Function)
      {
         super(param1,ChatReviewSessionStartedMessageParser);
      }
      
      public function getParser() : ChatReviewSessionStartedMessageParser
      {
         return _parser as ChatReviewSessionStartedMessageParser;
      }
   }
}

