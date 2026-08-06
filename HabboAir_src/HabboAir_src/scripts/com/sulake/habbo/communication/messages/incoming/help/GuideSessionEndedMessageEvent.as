package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionEndedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionEndedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuideSessionEndedMessageEvent(param1:Function)
      {
         super(param1,GuideSessionEndedMessageParser);
      }
      
      public function getParser() : GuideSessionEndedMessageParser
      {
         return _parser as GuideSessionEndedMessageParser;
      }
   }
}

