package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.SeasonalQuestsMessageParser;
   
   [SecureSWF(rename="true")]
   public class SeasonalQuestsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function SeasonalQuestsMessageEvent(param1:Function)
      {
         super(param1,SeasonalQuestsMessageParser);
      }
      
      public function getParser() : SeasonalQuestsMessageParser
      {
         return _parser as SeasonalQuestsMessageParser;
      }
   }
}

