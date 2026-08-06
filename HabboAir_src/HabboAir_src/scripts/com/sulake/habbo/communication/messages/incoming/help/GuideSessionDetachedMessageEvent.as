package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionDetachedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionDetachedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuideSessionDetachedMessageEvent(param1:Function)
      {
         super(param1,GuideSessionDetachedMessageParser);
      }
      
      public function getParser() : GuideSessionDetachedMessageParser
      {
         return _parser as GuideSessionDetachedMessageParser;
      }
   }
}

