package com.sulake.habbo.communication.messages.incoming.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackPremiumPurchaseResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class RewardTrackPremiumPurchaseResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function RewardTrackPremiumPurchaseResultMessageEvent(param1:Function)
      {
         super(param1,RewardTrackPremiumPurchaseResultMessageParser);
      }
      
      public function getParser() : RewardTrackPremiumPurchaseResultMessageParser
      {
         return _parser as RewardTrackPremiumPurchaseResultMessageParser;
      }
   }
}

