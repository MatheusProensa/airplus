package com.sulake.habbo.communication.messages.parser.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class DailyTasksTasksAddedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function DailyTasksTasksAddedMessageEvent(param1:Function)
      {
         super(param1,DailyTasksTasksAddedMessageParser);
      }
      
      public function getParser() : DailyTasksTasksAddedMessageParser
      {
         return _parser as DailyTasksTasksAddedMessageParser;
      }
   }
}

