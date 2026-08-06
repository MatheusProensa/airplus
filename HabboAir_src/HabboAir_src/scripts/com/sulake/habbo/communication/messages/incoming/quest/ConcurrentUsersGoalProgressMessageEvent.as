package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.ConcurrentUsersGoalProgressMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConcurrentUsersGoalProgressMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ConcurrentUsersGoalProgressMessageEvent(param1:Function)
      {
         super(param1,ConcurrentUsersGoalProgressMessageParser);
      }
      
      public function getParser() : ConcurrentUsersGoalProgressMessageParser
      {
         return _parser as ConcurrentUsersGoalProgressMessageParser;
      }
   }
}

