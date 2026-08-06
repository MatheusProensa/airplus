package com.sulake.habbo.communication.messages.incoming.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrackLevelMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentTrackLevelMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TalentTrackLevelMessageEvent(param1:Function)
      {
         super(param1,TalentTrackLevelMessageParser);
      }
      
      public function getParser() : TalentTrackLevelMessageParser
      {
         return _parser as TalentTrackLevelMessageParser;
      }
   }
}

