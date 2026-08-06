package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalEarnedPrizesMessageParser;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalEarnedPrizesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CommunityGoalEarnedPrizesMessageEvent(param1:Function)
      {
         super(param1,CommunityGoalEarnedPrizesMessageParser);
      }
      
      public function getParser() : CommunityGoalEarnedPrizesMessageParser
      {
         return this._parser as CommunityGoalEarnedPrizesMessageParser;
      }
   }
}

