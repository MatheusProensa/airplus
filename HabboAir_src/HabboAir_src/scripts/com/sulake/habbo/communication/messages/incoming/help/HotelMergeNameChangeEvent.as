package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.UnknownHabboCommunicationMessagesParserHelp1;
   
   [SecureSWF(rename="true")]
   public class HotelMergeNameChangeEvent extends MessageEvent implements IMessageEvent
   {
      public function HotelMergeNameChangeEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserHelp1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserHelp1
      {
         return _parser as UnknownHabboCommunicationMessagesParserHelp1;
      }
   }
}

