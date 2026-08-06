package com.sulake.habbo.communication.messages.parser.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class DailyTasksTaskUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function DailyTasksTaskUpdateMessageEvent(param1:Function)
      {
         super(param1,DailyTasksTaskUpdateMessageParser);
      }
      
      public function getParser() : DailyTasksTaskUpdateMessageParser
      {
         return _parser as DailyTasksTaskUpdateMessageParser;
      }
   }
}

