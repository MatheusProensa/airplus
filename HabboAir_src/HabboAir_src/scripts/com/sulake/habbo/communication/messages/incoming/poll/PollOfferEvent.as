package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.PollOfferParser;
   
   [SecureSWF(rename="true")]
   public class PollOfferEvent extends MessageEvent implements IMessageEvent
   {
      public function PollOfferEvent(param1:Function)
      {
         super(param1,PollOfferParser);
      }
      
      public function getParser() : PollOfferParser
      {
         return _parser as PollOfferParser;
      }
   }
}

