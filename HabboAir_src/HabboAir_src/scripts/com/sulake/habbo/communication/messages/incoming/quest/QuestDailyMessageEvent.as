package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.QuestDailyMessageParser;
   
   [SecureSWF(rename="true")]
   public class QuestDailyMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function QuestDailyMessageEvent(param1:Function)
      {
         super(param1,QuestDailyMessageParser);
      }
      
      public function getParser() : QuestDailyMessageParser
      {
         return _parser as QuestDailyMessageParser;
      }
   }
}

