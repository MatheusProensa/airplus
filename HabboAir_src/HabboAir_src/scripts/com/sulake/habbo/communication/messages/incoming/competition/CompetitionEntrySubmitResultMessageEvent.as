package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.CompetitionEntrySubmitResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionEntrySubmitResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CompetitionEntrySubmitResultMessageEvent(param1:Function)
      {
         super(param1,CompetitionEntrySubmitResultMessageParser);
      }
      
      public function getParser() : CompetitionEntrySubmitResultMessageParser
      {
         return _parser as CompetitionEntrySubmitResultMessageParser;
      }
   }
}

