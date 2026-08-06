package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionResultsMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionResultsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ChatReviewSessionResultsMessageEvent(param1:Function)
      {
         super(param1,ChatReviewSessionResultsMessageParser);
      }
      
      public function getParser() : ChatReviewSessionResultsMessageParser
      {
         return _parser as ChatReviewSessionResultsMessageParser;
      }
   }
}

