package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionPartnerIsTypingMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionPartnerIsTypingMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuideSessionPartnerIsTypingMessageEvent(param1:Function)
      {
         super(param1,GuideSessionPartnerIsTypingMessageParser);
      }
      
      public function getParser() : GuideSessionPartnerIsTypingMessageParser
      {
         return _parser as GuideSessionPartnerIsTypingMessageParser;
      }
   }
}

