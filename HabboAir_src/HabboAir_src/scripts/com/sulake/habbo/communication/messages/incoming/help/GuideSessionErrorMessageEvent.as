package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionErrorMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionErrorMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuideSessionErrorMessageEvent(param1:Function)
      {
         super(param1,GuideSessionErrorMessageParser);
      }
      
      public function getParser() : GuideSessionErrorMessageParser
      {
         return _parser as GuideSessionErrorMessageParser;
      }
   }
}

