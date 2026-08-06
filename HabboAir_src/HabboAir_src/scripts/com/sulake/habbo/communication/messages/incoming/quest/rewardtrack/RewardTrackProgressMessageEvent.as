package com.sulake.habbo.communication.messages.incoming.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackProgressMessageParser;
   
   [SecureSWF(rename="true")]
   public class RewardTrackProgressMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function RewardTrackProgressMessageEvent(param1:Function)
      {
         super(param1,RewardTrackProgressMessageParser);
      }
      
      public function getParser() : RewardTrackProgressMessageParser
      {
         return _parser as RewardTrackProgressMessageParser;
      }
   }
}

