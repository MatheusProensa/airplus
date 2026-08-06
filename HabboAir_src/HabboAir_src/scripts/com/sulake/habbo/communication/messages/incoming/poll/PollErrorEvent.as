package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.UnknownHabboCommunicationMessagesParserPoll1;
   
   [SecureSWF(rename="true")]
   public class PollErrorEvent extends MessageEvent implements IMessageEvent
   {
      public function PollErrorEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserPoll1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserPoll1
      {
         return _parser as UnknownHabboCommunicationMessagesParserPoll1;
      }
   }
}

