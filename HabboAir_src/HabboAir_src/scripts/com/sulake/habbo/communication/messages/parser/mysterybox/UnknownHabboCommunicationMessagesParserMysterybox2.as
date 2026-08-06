package com.sulake.habbo.communication.messages.parser.mysterybox
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UnknownHabboCommunicationMessagesParserMysterybox2 implements IMessageParser
   {
      public function UnknownHabboCommunicationMessagesParserMysterybox2()
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

