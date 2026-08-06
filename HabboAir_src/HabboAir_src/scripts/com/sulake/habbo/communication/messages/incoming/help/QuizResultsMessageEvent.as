package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.QuizResultsMessageParser;
   
   [SecureSWF(rename="true")]
   public class QuizResultsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function QuizResultsMessageEvent(param1:Function)
      {
         super(param1,QuizResultsMessageParser);
      }
      
      public function getParser() : QuizResultsMessageParser
      {
         return _parser as QuizResultsMessageParser;
      }
   }
}

