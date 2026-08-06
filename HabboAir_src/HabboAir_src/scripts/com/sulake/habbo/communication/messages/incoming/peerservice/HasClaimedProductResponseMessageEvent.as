package com.sulake.habbo.communication.messages.incoming.peerservice
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.peerservice.HasClaimedProductResponseParser;
   
   [SecureSWF(rename="true")]
   public class HasClaimedProductResponseMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function HasClaimedProductResponseMessageEvent(param1:Function)
      {
         super(param1,HasClaimedProductResponseParser);
      }
      
      public function getParser() : HasClaimedProductResponseParser
      {
         return _parser as HasClaimedProductResponseParser;
      }
   }
}

