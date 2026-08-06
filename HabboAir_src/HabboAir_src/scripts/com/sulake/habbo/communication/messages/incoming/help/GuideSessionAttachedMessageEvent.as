package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.GuideSessionAttachedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionAttachedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuideSessionAttachedMessageEvent(param1:Function)
      {
         super(param1,GuideSessionAttachedMessageParser);
      }
      
      public function getParser() : GuideSessionAttachedMessageParser
      {
         return _parser as GuideSessionAttachedMessageParser;
      }
   }
}

