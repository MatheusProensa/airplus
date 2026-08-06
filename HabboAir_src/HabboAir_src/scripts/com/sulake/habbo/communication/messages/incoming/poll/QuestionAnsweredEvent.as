package com.sulake.habbo.communication.messages.incoming.poll
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.QuestionAnsweredParser;
   
   [SecureSWF(rename="true")]
   public class QuestionAnsweredEvent extends MessageEvent implements IMessageEvent
   {
      public function QuestionAnsweredEvent(param1:Function)
      {
         super(param1,QuestionAnsweredParser);
      }
      
      public function getParser() : QuestionAnsweredParser
      {
         return _parser as QuestionAnsweredParser;
      }
   }
}

