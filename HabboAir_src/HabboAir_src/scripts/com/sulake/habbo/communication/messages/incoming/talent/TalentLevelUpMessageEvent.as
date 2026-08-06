package com.sulake.habbo.communication.messages.incoming.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentLevelUpMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TalentLevelUpMessageEvent(param1:Function)
      {
         super(param1,TalentLevelUpMessageParser);
      }
      
      public function getParser() : TalentLevelUpMessageParser
      {
         return _parser as TalentLevelUpMessageParser;
      }
   }
}

