package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalProgressMessageParser;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalProgressMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CommunityGoalProgressMessageEvent(param1:Function)
      {
         super(param1,CommunityGoalProgressMessageParser);
      }
      
      public function getParser() : CommunityGoalProgressMessageParser
      {
         return _parser as CommunityGoalProgressMessageParser;
      }
   }
}

