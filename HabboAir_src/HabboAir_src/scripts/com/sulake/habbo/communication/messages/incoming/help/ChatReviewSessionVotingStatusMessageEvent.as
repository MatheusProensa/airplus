package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.ChatReviewSessionVotingStatusMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionVotingStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ChatReviewSessionVotingStatusMessageEvent(param1:Function)
      {
         super(param1,ChatReviewSessionVotingStatusMessageParser);
      }
      
      public function getParser() : ChatReviewSessionVotingStatusMessageParser
      {
         return _parser as ChatReviewSessionVotingStatusMessageParser;
      }
   }
}

