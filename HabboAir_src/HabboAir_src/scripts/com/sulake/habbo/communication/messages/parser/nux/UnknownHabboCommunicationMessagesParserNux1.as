package com.sulake.habbo.communication.messages.parser.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UnknownHabboCommunicationMessagesParserNux1 implements IMessageParser
   {
      public function UnknownHabboCommunicationMessagesParserNux1()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         return true;
      }
   }
}

