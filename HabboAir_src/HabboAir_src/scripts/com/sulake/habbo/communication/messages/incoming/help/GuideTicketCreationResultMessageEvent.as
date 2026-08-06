package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideTicketCreationResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideTicketCreationResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuideTicketCreationResultMessageEvent(param1:Function)
      {
         super(param1,GuideTicketCreationResultMessageParser);
      }
      
      public function getParser() : GuideTicketCreationResultMessageParser
      {
         return _parser as GuideTicketCreationResultMessageParser;
      }
   }
}

