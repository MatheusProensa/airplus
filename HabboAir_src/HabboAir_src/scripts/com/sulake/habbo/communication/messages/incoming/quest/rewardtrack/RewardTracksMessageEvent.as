package com.sulake.habbo.communication.messages.incoming.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTracksMessageParser;
   
   [SecureSWF(rename="true")]
   public class RewardTracksMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function RewardTracksMessageEvent(param1:Function)
      {
         super(param1,RewardTracksMessageParser);
      }
      
      public function getParser() : RewardTracksMessageParser
      {
         return _parser as RewardTracksMessageParser;
      }
   }
}

