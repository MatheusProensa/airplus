package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.CurrentTimingCodeMessageParser;
   
   [SecureSWF(rename="true")]
   public class CurrentTimingCodeMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CurrentTimingCodeMessageEvent(param1:Function)
      {
         super(param1,CurrentTimingCodeMessageParser);
      }
      
      public function getParser() : CurrentTimingCodeMessageParser
      {
         return _parser as CurrentTimingCodeMessageParser;
      }
   }
}

