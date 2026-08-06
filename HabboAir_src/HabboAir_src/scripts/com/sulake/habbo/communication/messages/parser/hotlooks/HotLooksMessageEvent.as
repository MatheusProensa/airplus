package com.sulake.habbo.communication.messages.parser.hotlooks
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class HotLooksMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function HotLooksMessageEvent(param1:Function)
      {
         super(param1,HotLooksMessageParser);
      }
      
      public function getParser() : HotLooksMessageParser
      {
         return _parser as HotLooksMessageParser;
      }
   }
}

