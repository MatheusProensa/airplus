package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class UnknownHabboCommunicationMessagesParserHabbicons4
   {
      public function UnknownHabboCommunicationMessagesParserHabbicons4()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : UnknownHabboCommunicationMessagesParserHabbicons1
      {
         var _loc2_:UnknownHabboCommunicationMessagesParserHabbicons1 = new UnknownHabboCommunicationMessagesParserHabbicons1();
         _loc2_.habbiconId = param1.readInteger();
         _loc2_.habbiconState = param1.readInteger();
         return _loc2_;
      }
   }
}

