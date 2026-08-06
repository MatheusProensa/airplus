package com.sulake.habbo.communication.messages.parser.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class DailyTasksActiveListMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function DailyTasksActiveListMessageEvent(param1:Function)
      {
         super(param1,DailyTasksActiveListMessageParser);
      }
      
      public function getParser() : DailyTasksActiveListMessageParser
      {
         return _parser as DailyTasksActiveListMessageParser;
      }
   }
}

