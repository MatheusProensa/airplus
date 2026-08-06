package com.sulake.habbo.communication.messages.incoming.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackClaimResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class RewardTrackClaimResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function RewardTrackClaimResultMessageEvent(param1:Function)
      {
         super(param1,RewardTrackClaimResultMessageParser);
      }
      
      public function getParser() : RewardTrackClaimResultMessageParser
      {
         return _parser as RewardTrackClaimResultMessageParser;
      }
   }
}

