package com.sulake.habbo.communication.messages.incoming.landingview.votes
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.landingview.votes.CommunityVoteReceivedParser;
   
   [SecureSWF(rename="true")]
   public class CommunityVoteReceivedEvent extends MessageEvent
   {
      public function CommunityVoteReceivedEvent(param1:Function)
      {
         super(param1,CommunityVoteReceivedParser);
      }
      
      public function getParser() : CommunityVoteReceivedParser
      {
         return _parser as CommunityVoteReceivedParser;
      }
   }
}

